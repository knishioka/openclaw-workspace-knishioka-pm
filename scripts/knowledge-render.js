#!/usr/bin/env node
/*
  Render knowledge base + decisions markdown from scripts/knowledge-collect JSON.

  Usage:
    node scripts/knowledge-render.js --in <json> --out knowledge --repo <owner/name>

  Outputs:
    - knowledge/repos/<name>-kb.md
    - knowledge/decisions/<name>-decisions.md

  Prints a small JSON summary to stdout.
*/

const fs = require('fs');
const path = require('path');

function arg(name) {
  const i = process.argv.indexOf(name);
  if (i === -1) return null;
  return process.argv[i + 1] ?? null;
}

const inPath = arg('--in');
const outRoot = arg('--out') || 'knowledge';
const repo = arg('--repo');

if (!inPath || !repo) {
  console.error('Usage: node scripts/knowledge-render.js --in <json> --out knowledge --repo <owner/name>');
  process.exit(2);
}

const name = repo.split('/')[1];
const reposDir = path.join(outRoot, 'repos');
const decisionsDir = path.join(outRoot, 'decisions');
fs.mkdirSync(reposDir, { recursive: true });
fs.mkdirSync(decisionsDir, { recursive: true });

const raw = fs.readFileSync(inPath, 'utf8');
const data = JSON.parse(raw);

const collectedAt = data.collected_at || new Date().toISOString().slice(0, 10);
const meta = data.metadata || {};
const pkg = data.tech_stack?.package_json ?? null;

function uniq(arr) {
  return [...new Set((arr || []).filter(Boolean))];
}

function take(arr, n) {
  return (arr || []).slice(0, n);
}

function fmtDate(iso) {
  if (!iso) return null;
  const d = new Date(iso);
  if (Number.isNaN(d.getTime())) return iso.slice(0, 10);
  return d.toISOString().slice(0, 10);
}

function cleanOneLine(s) {
  return String(s || '')
    .replace(/\s+/g, ' ')
    .trim();
}

function extractWhy(body) {
  const text = String(body || '').replace(/\r/g, '');
  if (!text.trim()) return null;

  // Try common headings / markers (EN/JP)
  const patterns = [
    /(?:^|\n)\s*(?:Why|Motivation|Rationale|Background|理由|背景)\s*[:：]\s*([\s\S]{0,400})/i,
    /(?:^|\n)\s*-\s*(?:Why|Motivation|Rationale|理由|背景)\s*[:：]\s*([\s\S]{0,400})/i,
  ];
  for (const re of patterns) {
    const m = text.match(re);
    if (m && m[1]) {
      const snippet = m[1].split(/\n\s*\n/)[0];
      return cleanOneLine(snippet).slice(0, 240);
    }
  }

  // Otherwise: first non-empty paragraph (but keep it short)
  const para = text
    .split(/\n\s*\n/)
    .map(p => cleanOneLine(p))
    .find(p => p && p.length >= 20);
  return para ? para.slice(0, 240) : null;
}

function isRoutineTitle(title) {
  const t = String(title || '').toLowerCase();
  if (!t) return true;
  // If it includes big-change verbs, keep it even if it's a chore.
  const keep = /(migrate|refactor|rewrite|introduce|architecture|design|breaking|oauth|auth|schema|api|cache|db|queue|worker|mcp|pdf|remotion|extension)/i;
  if (keep.test(t)) return false;

  const skip = /^(chore|docs|style|test|ci|build|refactor\(lint\)|lint|format)(:|\()/i;
  if (skip.test(t)) return true;
  if (/(bump|dependabot|version|typo|spelling|prettier|eslint|ruff|black)/i.test(t)) return true;
  return false;
}

function inferPatterns({ repo, meta, pkg, readme }) {
  const patterns = [];
  const topics = meta?.topics || [];
  const deps = (pkg && Array.isArray(pkg.dependencies)) ? pkg.dependencies : [];
  const devDeps = (pkg && Array.isArray(pkg.devDependencies)) ? pkg.devDependencies : [];
  const all = new Set([...deps, ...devDeps].map(s => String(s).toLowerCase()));

  function has(x) { return all.has(String(x).toLowerCase()); }

  const r = String(repo).toLowerCase();
  if (r.includes('mcp') || topics.includes('mcp')) patterns.push('MCP server / tool integration');
  if (has('fastify') || has('express') || has('hono') || has('koa')) patterns.push('HTTP API server');
  if (has('zod') || has('ajv')) patterns.push('Runtime schema validation');
  if (has('drizzle-orm') || has('prisma') || has('typeorm')) patterns.push('ORM-based persistence');
  if (has('pdf-lib') || has('pdfkit') || has('puppeteer')) patterns.push('Document/PDF generation');
  if (has('react') || has('next') || has('nextjs')) patterns.push('React/Next.js UI');
  if (has('remotion')) patterns.push('Remotion-based video generation');

  const readmeText = String(readme || '').toLowerCase();
  if (/chrome extension|manifest v3|manifestv3/.test(readmeText) || r.includes('chrome-extension')) {
    patterns.push('Chrome extension (likely Manifest V3)');
  }
  if (/cli|command line/.test(readmeText)) patterns.push('CLI-style usage');
  if (/docker|container/.test(readmeText)) patterns.push('Containerized/devcontainer workflow');

  return uniq(patterns);
}

function keyDeps(pkg) {
  if (!pkg) return { deps: [], devDeps: [], scripts: [] };
  const deps = take((pkg.dependencies || []).sort(), 12);
  const devDeps = take((pkg.devDependencies || []).sort(), 12);
  const scripts = take((pkg.scripts || []).sort(), 15);
  return { deps, devDeps, scripts };
}

function loadExistingSources(filePath) {
  if (!fs.existsSync(filePath)) return new Set();
  const txt = fs.readFileSync(filePath, 'utf8');
  const sources = new Set();

  // PR #123
  for (const m of txt.matchAll(/PR\s*#(\d+)/g)) sources.add(`PR#${m[1]}`);
  // commit abc1234
  for (const m of txt.matchAll(/\bcommit\s+([0-9a-f]{7,40})\b/ig)) sources.add(`commit:${m[1].slice(0, 7)}`);
  // explicit source lines
  for (const m of txt.matchAll(/Source\s*:\s*(.+)$/gm)) sources.add(cleanOneLine(m[1]));
  return sources;
}

function toKbMarkdown({ repo, collectedAt, meta, pkg, patterns, decisions }) {
  const { deps, devDeps, scripts } = keyDeps(pkg);
  const topics = (meta.topics || []).join(', ');

  const lines = [];
  lines.push(`# ${name} Knowledge Base`);
  lines.push('');
  lines.push('## Overview');
  lines.push('');
  lines.push(`- Repo: ${repo}`);
  if (meta.description) lines.push(`- Description: ${cleanOneLine(meta.description)}`);
  if (meta.language) lines.push(`- Primary language (GitHub): ${meta.language}`);
  if (topics) lines.push(`- Topics: ${topics}`);
  if (meta.license) lines.push(`- License: ${meta.license}`);
  if (meta.default_branch) lines.push(`- Default branch: ${meta.default_branch}`);
  if (meta.created_at) lines.push(`- Created: ${fmtDate(meta.created_at)}`);
  if (meta.updated_at) lines.push(`- Updated: ${fmtDate(meta.updated_at)}`);
  lines.push(`- Collected: ${collectedAt}`);
  lines.push('');

  lines.push('## Tech Stack');
  lines.push('');
  if (pkg) {
    lines.push(`- package.json: present`);
    if (deps.length) lines.push(`- Dependencies (sample): ${deps.join(', ')}`);
    if (devDeps.length) lines.push(`- Dev dependencies (sample): ${devDeps.join(', ')}`);
    if (scripts.length) lines.push(`- npm scripts (keys): ${scripts.join(', ')}`);
  } else {
    lines.push('- package.json: not found (or not accessible via GitHub contents API)');
  }
  lines.push(`- pyproject.toml: ${data.tech_stack?.has_pyproject ? 'present' : 'not found'}`);
  lines.push(`- requirements.txt: ${data.tech_stack?.has_requirements ? 'present' : 'not found'}`);
  lines.push('');

  lines.push('## Architecture / Patterns');
  lines.push('');
  if (patterns.length) {
    for (const p of patterns) lines.push(`- ${p}`);
  } else {
    lines.push('- (No clear patterns inferred from README/dependencies in this snapshot)');
  }
  lines.push('');

  lines.push('## Tech Decisions (from PRs/commits)');
  lines.push('');
  if (decisions.length) {
    for (const d of decisions) {
      const why = d.why ? ` -- ${d.why}` : ' -- (Why not stated in PR/commit body)';
      lines.push(`- [${d.date}] ${d.title}${why} (source: ${d.source})`);
    }
  } else {
    lines.push('- (No non-routine design decisions detected in recent PRs/commits)');
  }
  lines.push('');

  return lines.join('\n');
}

function toDecisionsMarkdown({ decisions }) {
  const lines = [];
  lines.push(`# ${name} Design Decisions`);
  lines.push('');

  if (!decisions.length) {
    lines.push('_No new decisions captured in this run._');
    lines.push('');
    return lines.join('\n');
  }

  for (const d of decisions) {
    lines.push(`## ${d.date}: ${d.title}`);
    lines.push('');
    lines.push(`- **What**: ${d.title}`);
    lines.push(`- **Why**: ${d.why || 'Not explicitly stated in PR/commit body (see source)'} `);
    lines.push(`- **Source**: ${d.source}`);
    lines.push('');
  }

  return lines.join('\n');
}

function cap200Lines(md) {
  const lines = md.split('\n');
  if (lines.length <= 200) return md;
  // Keep header + most recent content: drop from the middle conservatively.
  const head = lines.slice(0, 40);
  const tail = lines.slice(lines.length - 140);
  return [...head, '', '_...older entries summarized/omitted to keep within 200 lines..._', '', ...tail].join('\n');
}

// --- Build decisions list ---
const existingKbSources = loadExistingSources(path.join(reposDir, `${name}-kb.md`));
const existingDecisionSources = loadExistingSources(path.join(decisionsDir, `${name}-decisions.md`));

const candidates = [];
for (const pr of (data.merged_prs || [])) {
  if (isRoutineTitle(pr.title)) continue;
  candidates.push({
    date: fmtDate(pr.merged_at),
    title: cleanOneLine(pr.title),
    why: extractWhy(pr.body),
    source: `PR #${pr.number}`,
    sourceKey: `PR#${pr.number}`
  });
}

// If PR list is empty (or too routine), fall back to commits.
if (candidates.length < 3) {
  for (const c of (data.recent_commits || [])) {
    if (isRoutineTitle(c.message)) continue;
    candidates.push({
      date: fmtDate(c.date),
      title: cleanOneLine(c.message),
      why: null,
      source: `commit ${c.sha}`,
      sourceKey: `commit:${String(c.sha).slice(0, 7)}`
    });
  }
}

// Deduplicate + keep most recent (by date desc)
const seen = new Set();
const deduped = [];
for (const c of candidates) {
  const k = c.sourceKey;
  if (seen.has(k)) continue;
  seen.add(k);
  // Skip if already present in existing files
  if (existingKbSources.has(k) || existingDecisionSources.has(k) || existingKbSources.has(c.source) || existingDecisionSources.has(c.source)) {
    continue;
  }
  deduped.push(c);
}

deduped.sort((a, b) => (b.date || '').localeCompare(a.date || ''));
const decisions = take(deduped, 6);

const patterns = inferPatterns({ repo, meta, pkg, readme: data.readme_excerpt });

const kbPath = path.join(reposDir, `${name}-kb.md`);
const decisionsPath = path.join(decisionsDir, `${name}-decisions.md`);

const kbMd = cap200Lines(toKbMarkdown({ repo, collectedAt, meta, pkg, patterns, decisions }));
const decMd = cap200Lines(toDecisionsMarkdown({ decisions }));

const kbPrev = fs.existsSync(kbPath) ? fs.readFileSync(kbPath, 'utf8') : null;
const decPrev = fs.existsSync(decisionsPath) ? fs.readFileSync(decisionsPath, 'utf8') : null;

fs.writeFileSync(kbPath, kbMd);
fs.writeFileSync(decisionsPath, decMd);

const discoveries = [];
if (patterns.length) discoveries.push(`patterns: ${patterns.join('; ')}`);
if (pkg?.dependencies?.length) discoveries.push(`deps(sample): ${take(pkg.dependencies.sort(), 6).join(', ')}`);
if (meta.topics?.length) discoveries.push(`topics: ${meta.topics.join(', ')}`);

const out = {
  repo,
  collectedAt,
  kbUpdated: kbPrev !== kbMd,
  decisionsUpdated: decPrev !== decMd,
  decisionsAdded: decisions.length,
  discoveries
};

process.stdout.write(JSON.stringify(out));

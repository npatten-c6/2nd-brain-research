---
type: "primary source - blog post"
title: "I built an AI Second Brain. It's made me a 10x better GTM leader"
source: "https://www.kieranflanagan.io/p/i-built-an-ai-second-brain-its-made?has_completed_unsubscribed_unlock=true"
author:
  - "[[Kieran Flanagan]]"
published: 2026-05-08
created: 2026-06-23
description: "The single most impactful thing I've built with AI, and why every GTM leader needs one."
tags:
  - "clippings"
---

<!--
SOURCE ARTIFACT — verbatim web clipping of Kieran Flanagan's post (see frontmatter
`source`/`published`; captured 2026-06-23). Do not edit the body; re-clip to update.
The worked example here (Obsidian vault + Claude Code, files-as-truth) is a GTM
practitioner's account, not our recommendation — analysis lives in ../analysis/.
-->
### The single most impactful thing I've built with AI, and why every GTM leader needs one.

What I’ll cover in this post is the single most impactful thing I’ve built with AI. It’s my ‘Second Brain’. I’ve been building it for the past 3 months, and it’s the single most impactful thing I’ve done to become a better GTM leader. It’s fundamentally changed the quality and speed of the decisions I make.

I recently took over a group of 400+ people.

I’ve done this before. The first few months are brutal in any version of the world — endless meetings, decks, memos, and the slow grind of chasing down the right data. What’s worked, what hasn’t, who actually knows what. There’s a whole gauntlet to run before you’re informed enough to make a good decision.

This time was different. I built my AI Second Brain before I started. Three months of building it, and it changed how I worked completely.

That’s what this post is about. The complete system. How it’s built, how it runs, and why it’s the single most impactful thing I’ve done to become a better GTM leader.

**What you’re building**

The system runs on two things working together: an Obsidian vault and Claude Code.

Obsidian is a tool for working with plain markdown files — text files that live on your machine, not in someone else’s cloud. You can open them, search them, link them together, and browse them as a connected knowledge graph.

The vault is organised into folders that each have a specific job.

![](https://substackcdn.com/image/fetch/$s_!AfGB!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F703d514f-0206-4353-9cd4-bd520ac44c2b_1360x1060.png)

Claude Code is an AI that runs in your terminal and reads and writes directly to that vault. What makes it different from dropping a question into a Claude instance is persistence. Every time you start a session, it automatically loads your CLAUDE.md, the operating rules you’ve set for how it should work with you, your project index, and your recent daily logs. It has your full strategic context before you say a word.

CLAUDE.md is the constitution of the whole system. It holds your identity, your voice, your non-negotiables, your conventions. It’s the file that makes every session feel continuous rather than starting from scratch. You co-evolve it with Claude Code over time, and it gets sharper the more you use it.

The vault is the structured knowledge. Claude Code is the intelligence that reads it, writes to it, and reasons across it. Neither works without the other. A vault without AI is a wiki that decays because no one has time to maintain it. AI without a vault starts from zero every session and forgets everything the moment you close the tab.

You own it entirely. The vault is files on your machine. You can browse it in Obsidian, search it with any text tool, and back it up however you want. The AI operates on your files; it doesn’t store your strategic context in someone else’s system.

![](https://substackcdn.com/image/fetch/$s_!UYL2!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ff2bfd90e-46f0-494d-9962-3e5bc49c6d09_1360x1040.png)

**How the memory actually persists**

This is the question every reader will have: doesn’t Claude forget everything when you close the session?

It would, without the hooks.

Three automated processes run in the background to make memory permanent. When you start a session, a hook fires that loads your `CLAUDE.md` and project index before you say a word — full strategic context, instantly. When Claude Code is running low on context mid-session, a pre-compact hook intercepts, sends the conversation to the Claude Agent SDK, extracts a structured summary, and saves it to `daily-logs/` before anything is lost. When you close a session, the same process runs, decisions made, lessons learned, action items captured, all written to the vault.

Every session leaves a trace. Every trace is available to the next session. That’s the architecture that makes everything else work.

**1\. The Foundation: seed it with everything you already have**

The starting point is simpler than it sounds. You gather the documents you already have about a project — strategy decks, KPI reviews, sprint trackers, meeting transcripts, data exports, team roadmaps — drop them into a folder called ‘raw’, and run one command.

*/project new \<name>*

The system reads every file in that folder, extracts the structure — metrics, decisions, timelines, blockers, open questions, stakeholders — and produces a single living project file with every claim sourced back to the document it came from.

For my Agentic GTM group (new group), I dropped 55 documents into a folder: each team submitted a ‘Team Atlas’ describing their mission, projects, and goals. I included these along with the financial model, sprint plans, interview transcripts we did, both live and async, and strategy decks. The system produced a structured project file with north star metrics cited to the financial model, a bet portfolio ranked by impact, 13 synthesis themes extracted from 52 team profiles, open decisions awaiting data, and active blockers. 300 lines of structured context, assembled in minutes from documents I’d otherwise be holding in my head separately.

For Scaled Selling, another group, I dropped 40 documents — 12 months of KPI decks, executive updates, sprints, and more. Same process, same result.

It’s an incredibly powerful way to seed your core projects within the system.

**Living documents: a live intelligence feed for every project**

Every project runs on a small set of canonical sources that determine whether it’s on track or in trouble: the weekly KPI dashboard, the sprint tracker, the monthly business review, the exec update deck, and the decisions and blockers log.

After seeding, you tell the system exactly which sources matter for each project and how often they typically change. The KPI dashboard updates weekly. The sprint tracker updates every two weeks. The exec readout drops monthly. The system maps the cadence, checks each source on schedule, and pulls in changes when they’ve been modified.

What this gives you is something most executives never have: every project file stays current automatically. When you ask the system a strategic question, where are we against target, what’s blocked, what changed since last week, the answer is drawn from sources that were checked this morning, not from a snapshot you took three weeks ago when you seeded the project.

**2\. The Daily & Weekly Loop: the rhythm that builds on itself**

This is what separates the Second Brain from every notes tool or wiki you’ve tried before. Those start strong and decay because someone has to maintain them. This works the opposite way; you use it to do your job, and the vault gets smarter as a side effect.

The loop has four moments: morning, before meetings, during the day, and the end of the day.

**Morning: /today**

You open the system and run one command. It scans eight sources simultaneously:

- Your calendar — classifies open blocks by depth. 90+ minutes for deep work, under 45 for shallow tasks
- Your project files — extracts open decisions, blockers, and stakeholders waiting on you
- Yesterday’s plan — anything unfinished gets a ranking boost. It’s already slipped once
- Your recent daily logs — open commitments you’ve made that haven’t been resolved
- Gmail — unread threads that need a response from you, not FYI noise
- Fellow — action items assigned to you from the last 48 hours of meetings
- Todoist — tasks in your inbox, with overdue or due-today items getting an urgency boost
- Manual priorities — anything you flagged during the day via /priorities add

Then it does two things with what it finds.

First, it ranks. Every item gets placed into a four-tier priority model:

1. Someone is blocked on me — a person can’t move until I act. Always comes first.
2. Leadership-facing deadline — a committed delivery date to an exec or board.
3. Project momentum at risk — a bet stalls if I don’t engage today.
4. Personal commitment — I told someone I’d do something.

Items that have been rolling forward from previous days get boosted within their tier. Something that’s slipped three times ranks higher than something new at the same level.

Then it schedules. The system reads your open time blocks and maps ranked items into them by type:

- Deep blocks (90+ min) get the heavy work — writing, strategy, complex decisions
- Medium blocks (45–89 min) get focused but bounded tasks — reviews, prep, analysis
- Shallow blocks (under 45 min) get quick items — email responses, approvals, Slack follow-ups

If there isn’t enough time for everything, it says so explicitly and tells you what to cut or defer. Real example of mine (yes, it’s way too long right now:))

![](https://substackcdn.com/image/fetch/$s_!-a6C!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5d4c26c4-113f-4773-a73c-a3a95534c58f_1262x496.png)

**Before meetings: /brief \[person or project\]**

Run this before any meaningful meeting. It pulls from four sources simultaneously — your project files, recent email threads, Fellow meeting summaries, and internal docs. What you get is a structured brief built around what you actually need walking in:

- Where things currently stand
- What they need from you in this meeting
- Your last stated position on the key issues
- Open threads between you that haven’t been resolved
- Three things likely top of mind for them right now

Every claim cites its source. You know whether the context came from a meeting last Tuesday or an email three weeks ago. Example output below.

![](https://substackcdn.com/image/fetch/$s_!iEfu!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F51f7c0ee-ecad-43b1-9bd1-f566baac49bc_680x635.png)

**During the day: /priorities add {priority}**

Something lands mid-meeting that changes your day. A decision gets made that shifts a project. Someone asks for something by end of week. You don’t re-run `/today`. You run `/priorities add [thing]` and the system holds it. It shows up in tonight’s `/shutdown` (described below) and feeds into tomorrow’s `/today` automatically.

You’ll always have a up to date prioritised list of what you need to work on. For me, this has been a game changer.

**End of day:** `/shutdown`

Three questions: what got done, what didn’t, any new commitments?

The system pulls up today’s plan, reconciles it against what you’ve told it, and does five things:

1. Marks items done, partial, or deferred
2. Extracts new commitments and routes them into the relevant project files
3. Moves open decisions from “pending” to “decided” where applicable
4. Creates a roll-forward for tomorrow — what slipped, why, suggested top 3 for the morning
5. Saves the full session summary to `daily-logs/`

Five minutes. This is what makes the system compound. Every `/shutdown` adds to what `/today` knows tomorrow. Skip it and you lose the thread.

**The weekly feed:** `/ingest`

The daily loop keeps you organised. `/ingest` keeps the vault fed.

Your strategic context doesn’t arrive in one place. It arrives through email, meetings, slacks, shared documents, and internal search — across different channels, on different days, in different formats. `/ingest` pulls from all of them at once and routes everything into the right place in the vault.

It runs in two modes.

- **Full scan:** `/ingest: `Checks five sources simultaneously — Fellow meeting summaries, Gmail threads needing action, Google Drive documents that have been modified, Glean for internal docs mentioning your active projects, and Google Calendar for meetings that happened, Slack for all messages. For each item found, it shows you a routing table: here’s what changed, here’s which project it belongs to, here’s whether to update an existing file, create a new one, or skip it. You confirm before anything gets written. Nothing touches the vault without your approval.

Run this weekly — Friday afternoon works well — or after a heavy meeting week where a lot moved across a lot of channels at once.

- **Quick mode:** `/ingest raw: `Skips the external source scan entirely. Only processes files you’ve manually dropped into the `raw/` folder. Someone sends you a PDF, a transcript comes in, a strategy deck lands in your inbox — you drop it into `raw/`, run `/ingest raw`, and it’s processed into the right project file in minutes.

Both modes show you what they found and where they’d route it before making any changes. You stay in control of what goes in. The system does the work of figuring out where it belongs.

This is what stops the vault from becoming a snapshot. Every week, everything that happened across every channel gets pulled in, structured, and connected to the right projects. The vault doesn’t decay. It compounds.

The system doesn’t let things quietly die. If something has been rolling forward for a week, it shows up with escalating urgency. It’s incredibly powerful in keeping you focused on the most impactful work.

![](https://substackcdn.com/image/fetch/$s_!97OZ!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F1e8dcf72-45c3-44fb-b13e-5450314fc890_1360x960.png)

**3\. The Strategy Layer: questions you couldn’t answer before**

Once the Foundation is seeded and the Daily/Weekly Loop is running, you now have strategy superpowers.

With the system, the context is now fully assembled and continually enriched with the latest updates. Claude.md informs my brain how to be my strategic partner across projects.

**Connecting dots across meetings and documents**

You can easily connect context across meetings e.g.

*“Three different directors raised headcount constraint arguments in separate meetings this week. Is this a systemic problem or three separate ones?”*

*“My demand gen lead pitched a new channel strategy on Monday, my ops lead proposed restructuring the lead routing model on Wednesday, and a competitive analysis landed on Friday that challenges both. Where do they conflict?”*

**Stress-testing your own strategy**

*“We set a target of 30% pipeline growth. Walk me through which initiatives deliver that and where the gaps are.”*

*“Five teams claim their work will improve conversion rates. If I remove the ones without quantified evidence, what’s actually left?”*

*“Our biggest bet assumes the new pricing model ships in Q3. What breaks if it slips to Q4?”*

You’re always one question away from having true context and depth of knowledge across your strategy.

**Tracking commitments and accountability**

This is the one most executives underestimate until they’ve used it.

*“That board deliverable has been slipping. When did it first appear in my plan, how many times has it rolled forward, and who’s actually waiting on it?”*

*“Show me every decision made in the last two weeks, who made it, and which ones are still waiting on follow-through.”*

Staying on top of everything becomes so much easier.

The shift this creates is hard to describe until you’ve felt it. You stop operating at the edge of your context, the constant low-level anxiety of knowing you’re probably missing something important. The system holds the complexity so you don’t have to. Your job becomes making the decisions, not remembering the inputs.

**4\. The Creation Engine: output with full context loaded**

The system doesn’t just organise information and answer questions. It produces the artifacts you’d normally spend hours writing, grounded in everything the vault knows.

The difference between asking a standard AI to write a memo on your Q3 strategy and asking this system is context. A standard AI starts from zero every time. This system starts from your project files, open decisions, meeting findings, financial models, and frameworks. The draft it produces isn’t generic. It reflects the actual state of your work, sourced, current, and in your voice.

**/draft — every output format you need**

You tell the system what you need and the topic. It searches the vault for everything relevant — project files, wiki pages, frameworks, recent daily logs — and produces a first draft with source citations.

Four formats, each with tight rules:

**Memo** — recommendation first, always. TL;DR, context, argument, risks, ask. Never longer than two pages. The point is in the first sentence.

**Deck** — slide-by-slide outline with speaker notes. One key point per slide, twelve slides maximum. Opens with the sharpest version of the argument, not background slides that warm the room up.

**Email** — the point in the first sentence. Context below it. Under 200 words. If it needs to be longer, it should be a memo.

**Loom script** — conversational, not a teleprompter read. Hook, context, the thing, the ask. Under five minutes with visual cues for when to switch screens.

Every draft saves to the vault with the sources it drew from. You review it, tell the system what to sharpen, cut, or redirect, and it revises in place.

The first draft is 80% there because the context was already loaded, not because AI is particularly good at writing, but because it knows exactly what it’s writing about.

**5\. The Governance Layer: the system that keeps itself honest**

Any knowledge system drifts. Numbers go stale. Decisions get recorded inconsistently. Things fall through the cracks. The difference here is the system catches its own drift — you don’t have to.

**/lint — the vault health check**

Run this once a week. It reads every file in the vault and checks for six specific problems:

**Contradictions** — a metric cited differently in two files, a decision recorded as open in one place and decided in another, a deadline that doesn’t match between a project file and a meeting note. These are the errors that surface in meetings at the worst possible moment. The system finds them before you’re in the room.

**Stale claims** — any number, status, or date older than 60 days without a refresh. If a project phase hasn’t changed in two months, it flags whether the project is actually stuck or the file is just out of date.

**Orphan pages** — files that exist but nothing links to them. Invisible in the knowledge graph. Either connect them or remove them.

**Missing concepts** — terms or names that appear in three or more files but don’t have their own dedicated page. Ideas that have become central to your work without being explicitly documented.

**Neglected projects** — project files that haven’t been updated in 14 or more days with no recent activity in the log. A flag, not a deletion. Is the project done, paused, or just being ignored?

**Unsourced claims** — numbers, dates, quotes, or decisions that lack source attribution. Every factual claim in the vault must cite where it came from. `/lint` enforces it.

For each issue it finds, it proposes a concrete fix. Nothing changes until you confirm.

Five minutes once a week. It’s the difference between a knowledge system that compounds and one that quietly rots.

---

It’s hard to explain how differently I work now. How I feel more empowered. How I’m able to spend time on the most impactful work, vs. busy work. How I’m so much more informed.

To showcase this, I’m going to do a live video of me working, so people can look over my shoulder and see the ‘Second Brain’ in action. Stay tuned for that.

Happy AI’fying

Kieran
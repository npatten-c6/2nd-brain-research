# Guidelines

These are the guidelines and rules for agents working in `2nd-brain-research`.

## What this project is

Research toward building our own local-first, LLM-managed personal wiki / second brain / "open brain" system. Current phase is research and design, not implementation.

Working direction: follow Google's Open Knowledge Format (OKF) as the baseline knowledge file format (markdown + YAML frontmatter + links), but **local-only** — no Google services. Derived stores (SQLite/DuckDB/FTS/vector) are views over files, never the source of truth.

## Project Structure / Resources

- `docs/` contains project documentation.
- `docs/impl-research/` collects research on ideas/approaches. Start at [`docs/impl-research/research-index.md`](docs/impl-research/research-index.md) for the catalog of research docs and current working assumptions.
- [`style.md`](style.md) — writing & style conventions for project docs. Consult before authoring or editing any markdown.

## Managing and tracking work

This project uses git & Clew — a lightweight CLI that tracks work as git-tracked markdown files with YAML frontmatter.

### Clew Core concepts

- **Increment** — a standalone unit of work that should leave the codebase stable, tested, and committable when complete.
- **Task** — a Markdown checkbox inside an Increment.
- **Path** — the hand-curated priority order across active Increments, stored in `.clew/path.md`.
- **Archive** — completed or abandoned Increments moved to `.clew/archive/`.
- **Tag** — lightweight frontmatter classification for filtering. e.g. `bug`, `needs-info`, `p0`.

### Clew best practices

- Any non-trivial work should be tracked in a Clew increment.
- Keep the current increment up to date. Discoveries, decisions, and remaining tasks should be reflected in the increment markdown as they evolve.
- Before initiating work:
  - Ensure you have up to date information on the increment (`clew show <id>`).
  - If the increment doesn't have sufficient detail or planning: interview me relentlessly about every aspect of the plan / increment until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer. Ask the questions one at a time. If a question can be answered by exploring the project, explore the project instead.
- Keep the system in sync by running `clew start <id>` so work in progress has the correct status.
- Run `clew done <id>` only after user confirms the work is complete; then commit work with the `.clew/` changes.

### Common Clew commands

| Need                           | Command                               |
| ------------------------------ | ------------------------------------- |
| See active work                | `clew list`                           |
| See archived/abandoned too     | `clew list --all`                     |
| Filter by status               | `clew list --status todo`             |
| Filter by tag                  | `clew list --tag bug`                 |
| Pick next work if not provided | `clew next`                           |
| Pick and start next work       | `clew next --start`                   |
| Read an Increment              | `clew show <id>`                      |
| Create an Increment stub       | `clew new "Short title"`              |
| Create with body               | `clew new "Short title" < body.md`    |
| Create as child of another     | `clew new "Child" --parent <id>`      |
| Add tags                       | `clew tag <id> bug p0`                |
| Remove tags                    | `clew untag <id> p0`                  |
| Start work                     | `clew start <id>`                     |
| Finish work                    | `clew done <id>`                      |
| Mark blocked (with reason)     | `clew block <id> "waiting on API"`    |
| Clear blocked flag             | `clew unblock <id>`                   |
| Abandon work (with reason)     | `clew abandon <id> "obsolete"`        |
| Reopen archived work           | `clew reopen <id>`                    |
| Renumber an Increment ID       | `clew renumber <current-id> <new-id>` |

### Creating Increments

Common pattern — create, tag, and populate body in one command (body via stdin heredoc). Section structure below is illustrative default; projects can adapt.

```bash
clew new "Add OAuth routes" --tag needs-info --tag auth <<'EOF'
## Requirements & the 'Why'

What's essential and why this increment matters.

## Acceptance criteria

- [ ] Criterion 1
...
- [ ] Criterion N

## Tasks

- [ ] First task
EOF
```

### Additional Clew Information

See `.clew/README.md`, `clew --help`, or `clew <command> --help` for more detailed information.

---

## Initial Setup - DELETE THIS SECTION after bootstrap

Collaborate with me to setup this new project for success.
Guide me through the process, but act as a critical thinking collaborator.
Ensure the user understands the consequences of major decisions.
Help us both avoid dumb mistakes.

First ask if I have existing docs or planning materials for the project. If so, help me load them in, then read them thoroughly.

Then interview me relentlessly about every aspect of this project and my goals relating to it until we reach a shared understanding.
Walk down each branch of the design tree, resolving dependencies between decisions one-by-one.
For each question, provide your recommended answer. Frame questions around the deliverables (1, 2, 3 below) so the interview produces what's needed.

Ask the questions one at a time. If a question can be answered by the provided materials, use them instead of asking. (In doubt or conflict, discuss with user and go with their most recent preference.)

Based on the interview and conversation we want to achieve the following:

1. Generate a plan.md file — durable project scoping, not a TODO list (ongoing work lives in Clew increments). Capture:
   - Goals/why/purpose of the project
   - Core/key requirements for what the project will do and what type of project it will be
     - e.g. coding (website, library, tool), writing, research, agentic workflow container, etc.
   - The primary workflows (thinking through user and agent collaboration)
2. Update the `README.md` accordingly.
   - README purpose is to concisely and effectively convey:
     - Purpose / Why of the project
     - How to set it up on a new machine (e.g. quick start from fresh git clone)
     - concise human instructions for usage
3. Update `AGENTS.md` accordingly
   - Concise and effective instructions for agents working in the project.
   - Keep sparse / token light
   - Only information / context essential for 95%+ of all agent tasks in the project should be included
   - Prefer referencing / linking to other documents
   - replace / remove this `## Initial Setup` section as part of the update.

Plan out your actions before you start editing / creating files.
Once all 3 steps above are complete this 'initial setup' is successful.

Note: `setup.log` captured initial setup bash script output - it's safe to delete unless the user wants to keep it.

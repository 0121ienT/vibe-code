# Vibe Kanban & FastCode Project Context

## Global Architecture
This project consists of 4 distinct services integrated via Docker Compose:
- **Vibe Kanban (Frontend)**: React application running on port `3000`. Acts as a git worktree manager and visual kanban board.
- **FastCode (Backend API)**: High-performance Python-based code understanding framework running on port `8001`. Uses `uv` for dependency management. Accesses `./FastCode/repos` to index code.
- **Nanobot (Agent reasoning)**: FastCode's conversational agent running on port `18791`. Communicates directly with the FastCode API.
- **OmniRoute (Router/Dashboard)**: Runs independently on port `20128`.

## Code Guidelines & Standards
- **Vibe Kanban (JS/TS)**: Emphasize clean Architecture, strict TypeScript typing where appropriate, and modular React functional components. Prioritize modern UX/UI.

### Vibe Coding Design System (TailwindCSS)
When generating UI code, **MUST strictly adhere** to this default theme architecture:
- **Colors**: `background: #F5F5F0`, `surface: #F5F5F0` (Fallback for cards), `primary: #0F172A`, `accent: #4CAF50`
- **Border Radius**: Extensively use `24px` for all boundaries (`DEFAULT`, `card`, `button`)
- **Shadows**: Utilize deep shadows `0 20px 40px -5px rgba(0,0,0,0.1)` for `card` and `button`
- **Fonts**: Use `font-heading` (Merriweather, serif) for titles, and `font-body` (Inter, sans-serif) for body texts
- **Border Width**: `1px` standard for `card`
- **FastCode (Python 3.12+)**: Comply with PEP 8. Dependency changes must be managed using the `uv` tool (e.g., `uv pip install --link-mode=copy -r requirements.txt`) due to OneDrive filesystem sync constraints. Keep the virtual environment clean.

## Commands & Workflows
- **Docker Orchestration**: The entire application stack is managed centrally:
  ```bash
  # Start the entire suite
  docker compose up -d

  # Check real-time logs for all services
  docker compose logs -f

  # Stop everything
  docker compose down
  ```
- **Terminal Execution**: Instead of raw pip, remember to use `npx` prefixes for global TS tools when configuring environments dynamically (e.g. `npx claude` or `npx gemini`).

## Claude Specific Rules
1. **Always read this file** to gain context before assisting with debugging or coding.
2. Use the local **FastCode MCP Server** whenever you need to search or aggregate context across the codebase deeply.
3. If the user asks for workflow integrations, remember that the **connect-apps-plugin** is available in `./connect-apps-plugin`. Use it to execute automated API tasks (Gmail, Slack, Jira) if the setup has been completed via `/connect-apps:setup`.
4. Be brief, professional, and code-focused in your responses. Do not alter `docker-compose.yml` blindly without ensuring it affects `vibe-kanban`, `fastcode`, `nanobot`, and `omniroute` cohesively.

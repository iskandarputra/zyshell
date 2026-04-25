# zy

A modern shell runtime written in C with structured in-process data pipelines, interactive UX, policy/audit controls, and built-in developer tooling.

This repository is the official public release channel.

## Repository Scope

- Publishes binary releases (`.deb`) for Debian/Ubuntu users.
- Source code is currently private.
- Use this repository for installation, release notes, and package distribution.

## What zy Provides

zy combines three major capabilities in one shell:

1. POSIX-style command and scripting workflow for daily terminal use.
2. Structured data pipeline operations (`open`, `where`, `sort-by`, `get`, `first`, etc.).
3. Operational controls such as command policy rules and audit verification.

Core characteristics:

- Implemented in C as a single shell runtime.
- 370+ built-in commands across navigation, data, string, math, system, and developer workflows.
- 12 runtime value types for structured pipelines.
- Interactive features: suggestions, completion, keybindings, themes, and prompt customization.

## Feature Overview

### Data Pipeline

- Load and transform structured data from files and command output.
- Filter, sort, reshape, and aggregate records/tables directly in shell pipelines.
- Convert between common formats (JSON/CSV/TOML/YAML/XML/TSV/HTML/Markdown).

### Interactive UX

- Context-aware completion and history search.
- Autosuggestion support with inline acceptance.
- Theme and prompt customization (`customize`, `config`, `set-theme`).
- Smart navigation tools (`z`, `zi`, bookmarks, stack navigation).

### Security and Governance

- Policy engine (`policy`) for execution restrictions and safety rules.
- Audit ledger (`audit`) with verification/export/search workflows.

### Built-In Developer Tools

- Shell testing commands (`assert-*`, `test-run`).
- Script debugging support (`dbg`).
- File watching (`fs-watch`) and task runner (`task`).
- Utility commands for HTTP calls, visualization, and operational workflows.

## Installation

Download the latest package from [Releases](https://github.com/iskandarputra/zyshell/releases), then install:

```bash
sudo dpkg -i zy_*.deb
sudo apt-get install -f
```

Run zy:

```bash
zy
```

Set as default shell (optional):

```bash
chsh -s /usr/bin/zy
```

## Public Docs

- Public project page: https://www.iskandarputra.com
- Command/reference docs are published through the website documentation section.

## Acknowledgments

zy references and respects ideas and interface patterns from the broader open-source shell ecosystem.

Notable projects that influenced command UX and workflow direction:

- [Nushell](https://github.com/nushell/nushell)
- [zsh](https://github.com/zsh-users/zsh)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
- [z.lua](https://github.com/skywind3000/z.lua) / [zoxide](https://github.com/ajeetdsouza/zoxide)
- [fzf](https://github.com/junegunn/fzf)

## License and Rights

Binary distribution and repository contents are provided under the terms declared in this repository.

© 2026 Iskandar Putra. All rights reserved.

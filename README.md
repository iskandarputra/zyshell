# zy — Zyvrixsh Shell

A POSIX-compatible interactive shell written in C with a structured data pipeline inspired by Nushell.

**Version:** 1.0.12
**Language:** C (gcc, -std=gnu17)
**Lines of code:** ~71k (zy_src/) + ~5k (headers) + ~16k (tests)
**License:** See [LICENSE](LICENSE)

## What It Is

`zy` is a single-binary shell that combines:

- **POSIX sh/bash/zsh compatibility** — pipes, redirections, job control, `if/for/while/case`, parameter expansion (`${var:-default}`, `${var//pat/rep}`, etc.), command substitution, arithmetic, heredocs, process substitution, globs, brace expansion, history expansion (`!!`, `!$`), signal traps
- **Nushell-style structured data** — a 12-type value system (`int`, `float`, `string`, `bool`, `list`, `record`, `table`, `filesize`, `duration`, `datetime`, `binary`, `null`) with in-process pipelines that pass typed values between builtins without serialization
- **370 built-in commands** — dispatched via binary search, covering filters, string ops, math, type conversions, date/time, path manipulation, format I/O (JSON, CSV, YAML, TOML, TSV, XML), hashing, bits/bytes, random generators, assertions, and system tools

## Build

```sh
make all
```

Requires: `gcc`, `libsqlite3-dev`, `libpthread`, `libm`, `libdl`

**Alternative (Meson):**

```sh
meson setup builddir && meson compile -C builddir
```

Produces: `./zy` (single binary, ~1.5 MB)

```sh
# Run
./zy

# Run a command
./zy -c 'ls | where type == "file" | sort-by size --reverse | first 5'

# Run a script
./zy script.zy
```

## Install

```sh
sudo make install   # installs to /usr/local/bin/zy
# or
bash install.sh
```

## Project Structure

```
zy_src/
├── 00_foundation/  # Layer 0 — zero-dependency primitives
│   ├── src/
│   │   ├── zy_alloc.c      Safe malloc/calloc/realloc/strdup with OOM abort
│   │   ├── zy_buf.c        Dynamic string buffer (ZyBuf: grow/append/printf/detach)
│   │   ├── zy_string.c     argv join, shell quoting
│   │   ├── zy_arena.c      Region-based arena allocator (8-byte aligned)
│   │   ├── zy_status.c     Structured error/status type with code + message
│   │   └── zy_regex.c      PCRE2/POSIX regex wrapper
│   └── inc/
│       ├── zy_alloc.h, zy_buf.h, zy_string.h, zy_arena.h, zy_status.h
│       ├── zy_regex.h, zy_defs.h (constants/limits), zy_globals.h (extern state)
│
├── 01_platform/    # Layer 1 — OS abstraction (~1.5k lines)
│   ├── src/
│   │   ├── zy_platform_posix.c  POSIX implementation (Linux/macOS/BSD)
│   │   └── zy_platform_win.c    Windows implementation (MSYS2/MinGW-w64)
│   └── inc/
│       └── zy_platform.h
│
├── 02_lang/        # Layer 2 — Language frontend (~6k lines)
│   ├── src/
│   │   ├── zy_lexer.c      56+ token types, 6 quoting modes, heredocs
│   │   ├── zy_parser.c     Recursive descent → 25+ AST node types
│   │   └── zy_glob.c       POSIX + ksh extended + zsh qualifiers + .gitignore-aware globstar
│   └── inc/
│       ├── zy_lexer.h, zy_parser.h, zy_glob.h
│
├── 03_runtime/     # Layer 3 — Type system & data infrastructure (~3k lines)
│   ├── src/
│   │   ├── zy_value.c          12-type structured value system (ZyValue)
│   │   ├── zy_pipeline_data.c  In-process ZyValue pipeline side-channel
│   │   ├── zy_jobs.c           Job control (fg/bg/wait/disown)
│   │   ├── zy_functions.c      User function storage + AST deep copy
│   │   ├── zy_continuation.c   Multi-line input detection
│   │   └── zy_error_display.c  Nushell-style structured error display
│   └── inc/
│       ├── zy_value.h, zy_pipeline_data.h, zy_jobs.h, zy_functions.h, zy_continuation.h
│
├── 04_engine/      # Layer 4 — Execution core (~10k lines)
│   ├── src/
│   │   ├── zy_executor.c         Core recursive execution engine (exec_node/exec_command/exec_pipeline)
│   │   ├── zy_builtin_registry.c 369-entry sorted dispatch table + builtin wrappers
│   │   ├── zy_exec_expand.c      Variable/glob/alias expansion, redirect save/restore
│   │   ├── zy_exec_value.c       Value literal parsing, argv-to-ZyValue conversion
│   │   ├── zy_variables.c        Variable storage, parameter expansion, command substitution
│   │   ├── zy_signals.c          Signal handling + crash recovery with stack traces
│   │   └── zy_utils.c            Command validation (builtin/PATH lookup)
│   └── inc/
│       ├── zy_executor.h, zy_builtin_registry.h, zy_exec_internal.h
│       ├── zy_variables.h, zy_signals.h
│
├── 05_shell/       # Layer 5 — REPL & user interaction (~3.5k lines)
│   ├── src/
│   │   ├── zy_main.c       Entry point + REPL loop
│   │   ├── zy_input.c      Raw-mode line editor with syntax highlighting + autosuggestions
│   │   └── zy_first_run.c  First-run config generator + banner
│   └── inc/
│       ├── zy_input.h, zy_first_run.h, input_builtins.h
│       ├── shell.h          Backward-compatible wrapper (re-exports zy_defs.h + zy_globals.h)
│       └── zy_features.h    Runtime feature gates
│
├── 06_builtins/    # Built-in commands (~30k lines, 44 files)
│   ├── src/
│   │   ├── filter_builtins.c   each, where, sort-by, flatten, group-by, merge, zip, chunk, window...
│   │   ├── data_builtins.c     get, select, first, last, describe, from-json, to-json, open, query-db...
│   │   ├── str_builtins.c      str-*, split-*, encode/decode, parse, detect-columns...
│   │   ├── math_builtins.c     math-abs through math-variance (26 operations)
│   │   ├── conv_builtins.c     into-int, into-float, into-string, into-bool, into-filesize...
│   │   ├── format_builtins.c   from/to YAML, TOML, XML, TSV, HTML, Markdown
│   │   ├── io_builtins.c       echo, print, printf, read
│   │   ├── nushell_builtins.c  save, glob, input, do, sleep, rm, cp, mv, mkdir, ps, du, which, complete...
│   │   ├── path_builtins.c     path-basename through path-type (11 operations)
│   │   ├── date_builtins.c     date-now, date-format, date-humanize, date-to-record...
│   │   ├── bits_builtins.c     bits-and through bits-ror (8 operations)
│   │   ├── bytes_builtins.c    bytes-length through bytes-build (11 operations)
│   │   ├── random_builtins.c   random-int, random-float, random-bool, random-chars, random-uuid...
│   │   ├── hash_builtins.c     hash-md5, hash-sha256
│   │   ├── gen_builtins.c      seq, seq-char, seq-date, cal, generate
│   │   ├── viz_builtins.c      sparkline, chart, progress
│   │   ├── assert_builtins.c   assert-eq, assert-ne, assert-true, assert-false, assert-error, assert-type
│   │   ├── var_builtins.c      export, unset, readonly, local, let, mut, const
│   │   ├── core_builtins.c     set, trap, shift, type/whence, suspend, banner
│   │   ├── core_compat.c       zsh compatibility: zstyle, zpty, sched, zparseopts, emulate...
│   │   ├── ls_builtin.c        ls with structured table output
│   │   ├── http_builtin.c      http get/post/head (HTTPS via OpenSSL when available)
│   │   ├── help_builtin.c      Comprehensive help system (7k lines)
│   │   └── ...                  alias, hooks, debugger, fs-watch, skills, stats, etc.
│   └── inc/                     40 builtin headers
│
├── 07_modules/     # Subsystems (~12k lines)
│   ├── src/
│   │   ├── completion.c      2-pass tab completion (prefix → fuzzy) with TUI menu
│   │   ├── completion_data.c  Static completion data (git flags, etc.)
│   │   ├── config.c          Data-driven config with descriptor table
│   │   ├── config_wizard.c   Interactive TUI setup wizard
│   │   ├── history.c         Traditional history with zsh-format file + ! expansion
│   │   ├── zyhistory.c       SQLite-backed smart history (exit codes, durations, CWD)
│   │   ├── zyjump.c          Frecency directory jumper (z/zi) with context-aware scoring
│   │   ├── zyfuzz.c          Weighted fuzzy matcher + interactive TUI picker
│   │   ├── audit.c           SHA-256 hash-chain command audit ledger (SQLite)
│   │   ├── policy.c          Command allowlist/denylist + rate limiting
│   │   ├── plugin.c          Script plugin loader (~/.zy/plugins/)
│   │   └── features.c        Runtime feature gates
│   └── inc/                   12 module headers
│
├── 08_ui/          # Terminal UI (~3k lines)
│   ├── src/
│   │   ├── prompt.c       5 prompt styles (aura/edge/flux/bare/classic), 30+ language detection
│   │   ├── prompt_git.c   Git status fetcher (branch, staged, modified, ahead/behind, state)
│   │   ├── table.c        Unicode box-drawing table renderer with auto-width
│   │   └── theme.c        18 built-in truecolor themes with OSC terminal palette support
│   └── inc/
│       ├── prompt.h, prompt_git.h, table.h, theme.h
│
└── 09_core/        # (removed — zy_regex moved to 00_foundation)

tests/              # Tests (~16k lines, 68 files)
```

## Core Concepts

### Dual Pipeline Mode

When all commands in a pipeline are zy builtins, they run **in-process** and pass `ZyValue` pointers directly — no fork, no serialization:

```sh
[1 2 3 4 5] | where {|x| $x > 2} | each {|x| $x * 10} | math sum
# → 120   (entirely in-process, single thread)
```

When a pipeline contains any external command, zy falls back to traditional **fork-based POSIX pipes** with automatic JSON/TSV serialization at the boundary.

### ZyValue Type System

12 types, stored as a C tagged union (`ZyValue`):

| Type       | Example                    | Storage                        |
| ---------- | -------------------------- | ------------------------------ |
| `null`     | `null`                     | —                              |
| `bool`     | `true`, `false`            | `bool`                         |
| `int`      | `42`, `0xff`, `0b1010`     | `int64_t`                      |
| `float`    | `3.14`                     | `double`                       |
| `string`   | `"hello"`                  | heap `char*`                   |
| `list`     | `[1 2 3]`                  | dynamic array                  |
| `record`   | `{name: "zy", ver: 1}`     | ordered key-value pairs        |
| `table`    | `[[name age]; [Alice 30]]` | column metadata + record array |
| `filesize` | `10mb`, `2.5gb`            | `int64_t` (bytes)              |
| `duration` | `5sec`, `100ms`, `2hr`     | `int64_t` (nanoseconds)        |
| `datetime` | `2024-01-15T10:30:00`      | `int64_t` (unix timestamp)     |
| `binary`   | `0x[FF D8 FF E0]`          | byte array                     |

### Nushell-Compatible Syntax

```sh
# Variables
let name = "world"
$env.MY_VAR = "value"
echo $"Hello ($name)"          # string interpolation

# Closures
[1 2 3] | each {|x| $x * 2}   # explicit parameter
[1 2 3] | each { $in * 2 }    # implicit $in

# Control flow
if ($x > 10) { "big" } else { "small" }
for i in [1 2 3] { echo $i }
match $val { "a" => 1, "b" => 2, _ => 0 }
try { risky_cmd } catch { "failed" }

# Custom commands
def greet [name: string] { echo $"Hello ($name)" }

# Ranges
0..5        # [0, 1, 2, 3, 4, 5]
0..<5       # [0, 1, 2, 3, 4]  (exclusive)
0..2..10    # [0, 2, 4, 6, 8, 10]  (step)

# Data pipeline
ls | where type == "file" | sort-by size --reverse | first 10
open data.json | get users | where age > 25 | select name email
sys | get memory
```

### POSIX Compatibility

All standard sh/bash/zsh constructs work:

```sh
# Parameter expansion
echo ${var:-default} ${#var} ${var//old/new} ${var:0:5}

# Redirections and pipes
cmd > out.txt 2>&1
cmd1 | cmd2 |& cmd3
cat <<EOF
heredoc content
EOF

# Job control
long_cmd &
fg %1
jobs

# Globs
ls *.{c,h}
echo {1..10}
ls **/*.c            # gitignore-aware recursive glob
```

## Configuration

Config is stored in `~/.zyrc` and managed via:

```sh
config set theme dracula
config set style aura
config set prompt_height two
config list
config wizard       # interactive TUI wizard
```

18 built-in themes: `ether`, `ember`, `frost`, `aurora`, `carbon`, `neon`, `retro`, `rose`, `dracula`, `tokyo-night`, `catppuccin`, `gruvbox`, `nord`, `one-dark`, `solarized`, `kanagawa`, `everforest`, `cyberpunk`

5 prompt styles: `aura` (floating pills), `edge` (vertical bars), `flux` (gradient), `bare` (minimal), `classic` (traditional)

## Tests

```sh
bash tests/run_tests.sh                       # full suite (51 C unit + integration + compat)
bash tests/compat/test_nushell_parity.sh      # 166+ Nushell parity assertions
bash tests/compat/test_700_commands.sh        # 360+ Linux command compatibility
```

See [`tests/README.md`](tests/README.md) for the complete test directory layout and guide.

## Known Limitations

- **Windows support is experimental**

## Audit Reports

Detailed source-level audit reports (generated from reading every line of source):

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) — System architecture and data flow
- [docs/BUILTINS.md](docs/BUILTINS.md) — Complete builtin reference (all 368 commands)
- [docs/INTERNALS.md](docs/INTERNALS.md) — Type system, pipeline, parser, and execution internals

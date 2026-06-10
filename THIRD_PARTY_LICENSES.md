# Third-Party Licenses (snapshot)

This file records the licenses of every upstream project zy acknowledges in its READMEs, as verified on the date below. The snapshot exists so that if any upstream relicenses tomorrow, the evidence of what their license was when zy claimed attribution lives here in our tree.

**Snapshot verified:** 2026-05-25 (commit that introduced this file).

> If you are auditing zy for license compliance and the upstream URL no longer shows the license recorded here, use the inline text below or the Wayback Machine snapshot of the upstream URL at or before the date above.

zy itself contains **no source code** from any of these projects. Inspiration is reproduced through original implementation only. The vendor libraries under `zy_src/vendor/` are the only third-party code in the tree; their licenses are recorded in this file and in the adjacent `LICENSE` file in each vendor directory.

## Quick index

| Tier | Project | SPDX |
|---|---|---|
| Inspiration only | Bash | GPL-3.0-or-later |
| Inspiration only | Zsh | Zsh License (MIT-style) |
| Inspiration only | Oh My Zsh | MIT |
| Inspiration only | Nushell | MIT |
| Inspiration only | Starship | ISC |
| Inspiration only | Powerline Extra Symbols | MIT |
| Inspiration only | Nerd Fonts (project + scripts) | MIT |
| Inspiration only | Nerd Fonts (font files, only if redistributed) | SIL OFL 1.1 |
| Inspiration only | Yazi | MIT |
| Inspiration only | fzf | MIT |
| Inspiration only | fff (Bash, dylanaraps) | MIT |
| Inspiration only | fff.nvim | MIT |
| Inspiration only | zoxide | MIT |
| Inspiration only | z.lua | MIT |
| Bundled (vendor/) | tomlc99 | MIT |
| Bundled (vendor/) | stb_image | Public domain |
| Dynamic link | SQLite | Public domain |
| Dynamic link | PCRE2 | BSD-3-Clause |
| Dynamic link | OpenSSL | Apache-2.0 (or original SSLeay dual) |
| Dynamic link | libexpat | MIT |
| Dynamic link | libarchive | BSD-2-Clause |

## Per-project records

### Bash

- **Upstream:** https://www.gnu.org/software/bash/
- **License file:** https://git.savannah.gnu.org/cgit/bash.git/tree/COPYING
- **SPDX:** `GPL-3.0-or-later`
- **Relationship to zy:** Inspiration only. zy reimplements the POSIX scripting model and a number of Bash-specific conveniences (`BASH_REMATCH`, `FUNCNAME`, `trap DEBUG`, `mapfile`, etc.) in original C. No Bash source code is present in the zy tree.
- **Note:** Bash is the most copyleft of the projects zy borrows from. The "no source code" guarantee above is what keeps zy MIT-licensable. If any Bash source ever lands in the zy tree, zy must be relicensed to GPL-3.0-or-later before redistribution.

### Zsh

- **Upstream:** https://www.zsh.org/
- **License file:** https://sourceforge.net/p/zsh/code/ci/master/tree/LICENCE
- **SPDX:** Custom "Zsh License" (MIT-style, BSD-flavored, permissive)
- **Relationship to zy:** Inspiration only. zy reproduces `zstyle`, `compinit`, `compdef`, parameter-expansion shorthands, and the autosuggestion behavior in original C. No Zsh source code is present in the zy tree.
- **Note:** The Zsh License itself is permissive. Some files in the Zsh distribution (notably under `Functions/Misc/` and a handful of `Completion/` files) are GPL-licensed contributions. zy reproduces no behavior from those files directly; the implementations are written from scratch against the documented surface.

### Oh My Zsh

- **Upstream:** https://github.com/ohmyzsh/ohmyzsh
- **License file:** https://github.com/ohmyzsh/ohmyzsh/blob/master/LICENSE.txt
- **SPDX:** `MIT`
- **Relationship to zy:** Inspiration only. zy reproduces completion ergonomics, alias conventions, and the "good out of the box" defaults that Oh My Zsh popularized.

### Nushell

- **Upstream:** https://github.com/nushell/nushell
- **License file:** https://github.com/nushell/nushell/blob/main/LICENSE
- **SPDX:** `MIT`
- **Relationship to zy:** Inspiration only. zy reproduces the structured-data pipeline model and many builtin names and signatures (`where`, `each`, `select`, `get`, `sort-by`, `from-json`, etc.) so users do not have to learn a new vocabulary. No Nushell source code is present in the zy tree.

### Starship

- **Upstream:** https://github.com/starship/starship
- **License file:** https://github.com/starship/starship/blob/master/LICENSE
- **SPDX:** `ISC`
- **Relationship to zy:** Inspiration only. zy reproduces the TOML-driven hot-reloading module-shaped prompt model, the format and style grammar, the `prev_fg` / `prev_bg` gradient idea, the per-module `detect_files` / `detect_folders` / `detect_extensions` convention, and many module names. No Starship source code is present in the zy tree.

### Powerline Extra Symbols

- **Upstream:** https://github.com/ryanoasis/powerline-extra-symbols
- **License file:** https://github.com/ryanoasis/powerline-extra-symbols/blob/master/LICENSE
- **SPDX:** `MIT`
- **Relationship to zy:** Inspiration only. zy hard-codes the Private Use Area codepoints from this project (U+E0B0..U+E0D7) so the 22 pill shapes can render in any compatible Nerd Font. zy does not ship the glyph data itself; that lives in the user's installed Nerd Font.

### Nerd Fonts

- **Upstream:** https://github.com/ryanoasis/nerd-fonts
- **License files:**
  - Project, scripts, tooling: https://github.com/ryanoasis/nerd-fonts/blob/master/LICENSE
  - Font binaries (per-font): https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/SIL_OFL.txt and the per-font `LICENSE.txt` shipped inside each font's archive
- **SPDX:** `MIT` for the project and its scripts. `OFL-1.1` for the font binary files themselves.
- **Relationship to zy:** Inspiration only. zy's optional `setup-font.sh` (shipped at `/usr/share/zy/setup-font.sh` after install) downloads MesloLGL Nerd Font from the upstream releases page **at install time, on the user's machine**. zy itself does not bundle any font binary. The SIL OFL 1.1 license therefore never enters zy's distribution; it only governs the file the user downloads from upstream after running the installer.

### Yazi

- **Upstream:** https://github.com/sxyazi/yazi
- **License file:** https://github.com/sxyazi/yazi/blob/main/LICENSE
- **SPDX:** `MIT`
- **Relationship to zy:** Inspiration only. zy's `explore` builtin reproduces yazi's three-pane Miller-columns layout, async preview scheduling, sixel + kitty image rendering, archive browsing, visual mode, and multi-tab. The implementation is original C; the design lineage is acknowledged with thanks.

### fzf

- **Upstream:** https://github.com/junegunn/fzf
- **License file:** https://github.com/junegunn/fzf/blob/master/LICENSE
- **SPDX:** `MIT`
- **Relationship to zy:** Inspiration only. zy's `fzf` builtin reproduces the fuzzy picker grammar (`'exact`, `^prefix`, `suffix$`, `!negate`) and the common `--multi` / `--reverse` / `--select-1` / `--filter` / `--prompt` flags. The implementation is original C built on zy's own zyfuzz engine.

### fff (Bash, by dylanaraps)

- **Upstream:** https://github.com/dylanaraps/fff
- **License file:** https://github.com/dylanaraps/fff/blob/master/LICENSE.md
- **SPDX:** `MIT`
- **Relationship to zy:** Inspiration only. zy's `fff` builtin shares the name and the spirit. The implementation is original C with no shared code.

### fff.nvim

- **Upstream:** https://github.com/dmtrKovalenko/fff.nvim
- **License file:** https://github.com/dmtrKovalenko/fff.nvim/blob/main/LICENSE
- **SPDX:** `MIT`
- **Relationship to zy:** Inspiration only. zy's `fff` engine borrows the design lineage of fff.nvim's Rust implementation: recursive index with `.gitignore` parsing, git-status overlay in the picker, persistent index across calls, bigram pre-filter. The implementation is original C; no Rust code is translated or vendored.

### zoxide

- **Upstream:** https://github.com/ajeetdsouza/zoxide
- **License file:** https://github.com/ajeetdsouza/zoxide/blob/main/LICENSE
- **SPDX:** `MIT`
- **Relationship to zy:** Inspiration only. zy's `z` and `zi` reproduce the frecency idea (time-decayed visit counts to surface the directories you actually use). The implementation is original C with a SQLite-backed store rather than zoxide's binary format.

### z.lua

- **Upstream:** https://github.com/skywind3000/z.lua
- **License file:** https://github.com/skywind3000/z.lua/blob/master/LICENSE
- **SPDX:** `MIT`
- **Relationship to zy:** Inspiration only. zy's `zi` interactive picker model and cross-shell frecency conventions echo z.lua's design.

### tomlc99 (bundled at `zy_src/vendor/tomlc99/`)

- **Upstream:** https://github.com/cktan/tomlc99
- **License file:** https://github.com/cktan/tomlc99/blob/master/LICENSE (also present at `zy_src/vendor/tomlc99/LICENSE`)
- **SPDX:** `MIT`
- **Relationship to zy:** Vendored. Used as the TOML parser for `~/.zy/config.toml` and structured-data `from toml` / `to toml`.

### stb_image (bundled at `zy_src/vendor/stb/`)

- **Upstream:** https://github.com/nothings/stb
- **License notice:** End of each `stb_*.h` file (see `zy_src/vendor/stb/stb_image_impl.c`)
- **SPDX:** Public domain (with optional MIT fallback)
- **Relationship to zy:** Vendored. PNG / JPEG / GIF / BMP / WebP decoders feeding the `explore` image preview path (sixel + kitty graphics).

### SQLite (dynamically linked)

- **Upstream:** https://www.sqlite.org
- **License page:** https://www.sqlite.org/copyright.html
- **SPDX:** Public domain (with a "blessing" rather than a license in the conventional sense)
- **Relationship to zy:** Dynamic link via `-lsqlite3`. Used by the history store, audit ledger, bookmark store, and the `query-db` builtin.

### PCRE2 (dynamically linked, optional)

- **Upstream:** https://www.pcre.org
- **License file:** https://github.com/PCRE2Project/pcre2/blob/master/LICENCE
- **SPDX:** `BSD-3-Clause`
- **Relationship to zy:** Optional dynamic link. Gates the richer regex engine behind `-DZY_HAS_PCRE2` at build time. The `=~` operator and `match` builtin work without it, with the POSIX regex fallback.

### OpenSSL (dynamically linked, optional)

- **Upstream:** https://www.openssl.org
- **License file:** https://github.com/openssl/openssl/blob/master/LICENSE.txt
- **SPDX:** `Apache-2.0` (since OpenSSL 3.0). Earlier versions use a dual SSLeay/Original SSL license.
- **Relationship to zy:** Optional dynamic link. Gates HTTPS support in the built-in HTTP client behind `-DZY_HAS_TLS` at build time. The HTTP client works without it for plain `http://` URLs.

### libexpat (dynamically linked, optional)

- **Upstream:** https://libexpat.github.io
- **License file:** https://github.com/libexpat/libexpat/blob/master/expat/COPYING
- **SPDX:** `MIT`
- **Relationship to zy:** Optional dynamic link. XML parser for the `from xml` builtin.

### libarchive (dynamically linked, optional)

- **Upstream:** https://libarchive.org
- **License file:** https://github.com/libarchive/libarchive/blob/master/COPYING
- **SPDX:** `BSD-2-Clause`
- **Relationship to zy:** Optional dynamic link. Enables in-place archive browsing in `explore` (tar, zip, 7z, etc.).

---

## Full text of the licenses referenced above

This section reproduces the canonical text of each license type referenced above, so the obligations are present in this tree even if every upstream URL above breaks.

### MIT License

Used by: Oh My Zsh, Nushell, Powerline Extra Symbols, Yazi, fzf, fff (dylanaraps), fff.nvim, zoxide, z.lua, tomlc99, libexpat, Nerd Fonts (project & scripts).

```
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

### ISC License

Used by: Starship.

```
ISC License

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
```

### BSD 2-Clause License

Used by: libarchive.

```
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
```

### BSD 3-Clause License

Used by: PCRE2.

Identical to BSD 2-Clause above, plus a third clause prohibiting use of the project name or contributor names to endorse derived products without prior written permission.

### Apache License 2.0

Used by: OpenSSL 3.0+.

Full text: https://www.apache.org/licenses/LICENSE-2.0

Key obligations for zy: zy dynamically links OpenSSL but does not bundle it. Under Apache-2.0, dynamic linking does not trigger any redistribution obligations on the linking software.

### Zsh License

Used by: Zsh.

```
The Z Shell is copyright (c) 1992-2023 Paul Falstad, Richard Coleman, Zoltán Hidvégi,
Andrew Main, Peter Stephenson, Sven Wischnowsky, and others.  All rights reserved.

Individual authors, whether or not specifically named, retain copyright in
all changes; in what follows, they are referred to as 'the Zsh Development
Group'.  This is for convenience only and this body has no legal status.
The Z shell is distributed under the following licence; any provisions made
in individual files take precedence.

Permission is hereby granted, without written agreement and without licence
or royalty fees, to use, copy, modify, and distribute this software and to
distribute modified versions of this software for any purpose, provided that
the above copyright notice and the following two paragraphs appear in all
copies of this software.

In no event shall the Zsh Development Group be liable to any party for direct,
indirect, special, incidental, or consequential damages arising out of the use
of this software and its documentation, even if the Zsh Development Group have
been advised of the possibility of such damage.

The Zsh Development Group specifically disclaim any warranties, including, but
not limited to, the implied warranties of merchantability and fitness for a
particular purpose.  The software provided hereunder is on an 'as is' basis,
and the Zsh Development Group have no obligation to provide maintenance,
support, updates, enhancements, or modifications.
```

### GPL-3.0-or-later

Used by: Bash.

Full text: https://www.gnu.org/licenses/gpl-3.0.txt

Key consideration for zy: GPL-3.0 is copyleft. zy contains **no Bash source code** (verified in the per-project record above). If any Bash source is ever incorporated into zy, the project must be relicensed to GPL-3.0-or-later before redistribution.

### SIL Open Font License 1.1

Used by: Nerd Fonts (font binary files only).

Full text: https://openfontlicense.org/open-font-license-official-text/

Key consideration for zy: zy does not bundle or distribute any font binary. The optional `setup-font.sh` script downloads font files from the upstream Nerd Fonts releases page at install time, on the user's machine. The OFL governs the file the user receives from upstream, not zy itself.

### Public domain (SQLite, stb_image)

These projects are released into the public domain with no claim of copyright. zy uses them with no obligations beyond gratitude. The SQLite project asks for a "blessing" rather than a license; the gist is "may you do good, not evil, with this software".

---

## How this file is maintained

When a new third-party project is referenced in a README or vendored under `zy_src/vendor/`, append a per-project record to this file with the SPDX identifier, the verified-on date, and the upstream LICENSE URL. If the canonical text of the license is not already in the "Full text" section, add it.

If an upstream relicenses, do **not** delete the old record from this file. Add a dated note inside the existing record explaining the change and the date observed. The point of this file is to be permanent evidence; deletions defeat the purpose.

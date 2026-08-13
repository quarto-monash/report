# Hack font for LaTeX

This repository provides the [Hack](https://sourcefoundry.org/hack/) monospaced font, with and without ligatures, for use with LaTeX.

## Installation

Copy the `tex/` and `fonts/` directories of this repo into your `TEXMFHOME` tree, then refresh the filename database.

**Linux and macOS** (bash/zsh):

```sh
TEXMFHOME=$(kpsewhich -var-value TEXMFHOME)
cp -r tex fonts "$TEXMFHOME"/
mktexlsr "$TEXMFHOME"
```

**Windows** (PowerShell, with TeX Live or MiKTeX installed):

```powershell
$TEXMFHOME = kpsewhich -var-value TEXMFHOME
Copy-Item -Recurse -Force tex,fonts "$TEXMFHOME"
mktexlsr "$TEXMFHOME"
```

## Usage

```latex
\usepackage{hack}
```

Under pdflatex, this sets `T1`-encoded Hack as the document's monospace (`\ttfamily`) font and registers the required font map, so no `updmap` step is needed.
Under XeLaTeX/LuaLaTeX, it loads the packaged `Hack-*.ttf` files directly via `fontspec`.

## Optional ligatures

The `ligatures` option only works under XeLaTeX or LuaLaTeX.

```latex
\usepackage[ligatures]{hack}
```

This switches to [Hack FC Ligatured CCG](https://github.com/gaplo917/Ligatured-Hack), a variant of Hack with Fira Code-style programming ligatures (`<-`, `|>`, `==`, `<=`, `!=`, ...).

## Contents

```
tex/latex/hack/               hack.sty, t1hack.fd (font shape declarations)
fonts/tfm/public/hack/        TFM metrics for the pdflatex virtual fonts
fonts/vf/public/hack/         virtual fonts mapping T1 encoding onto the raw glyphs
fonts/truetype/public/hack/   Hack and Hack FC Ligatured CCG .ttf files
fonts/enc/dvips/hack/         T1 re-encoding vector
fonts/map/dvips/hack/         pdftex font map
```

## Licence

The Hack fonts are redistributed here unmodified aside from the TDS repackaging and T1 re-encoding metadata; see [LICENCE.md](LICENCE.md) for the full licence text (MIT + Bitstream Vera Licence), which must accompany any redistribution.

The Hack FC Ligatured CCG fonts are redistributed unmodified under a GPL-3.0 licence; see [LICENCE.md](LICENCE.md) for the full licence text, which must accompany any redistribution.

All other files are made available under an MIT license.

// Monash Report — Typst template for Quarto by Rob J Hyndman
//
// Recreates the LaTeX report format's cover page (logo, blue contact block,
// red title, accreditation logos) and body styling (red sans headings,
// custom header/footer, italic captions) using Typst.

#let monash-red = rgb("#b30000")
#let monash-blue = rgb("#0000b3")
#let link-blue = rgb(0, 0, 255)

#let content-to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else if content == [ ] {
    " "
  } else {
    ""
  }
}

#let report(
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  organization: none,
  department: [Department of Econometrics \& Business Statistics],
  phone: [(03) 9903 4416],
  email: [BusEco-Econometrics\@monash.edu],
  margin: (top: 2.4cm, bottom: 2.4cm, left: 2.5cm, right: 2.5cm),
  paper: "a4",
  lang: "en",
  region: "AU",
  font: "XCharter",
  fontsize: 11pt,
  linestretch: 1.5,
  heading-family: "Fira Sans",
  mono-family: "Hack",
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  let authornames = if authors != none {
    authors.map(a => content-to-string(a.name)).join(", ", last: " & ")
  } else { "" }

  set document(title: title) if title != none
  set document(author: authornames) if authornames != ""

  set text(lang: lang, region: region, font: font, size: fontsize)
  set par(justify: true, leading: linestretch * 0.65em, spacing: linestretch * 1em)
  show math.equation: set text(font: "XCharter Math")
  show raw: set text(font: mono-family)
  show link: set text(fill: link-blue)
  show ref: set text(fill: link-blue)
  show cite: set text(fill: link-blue)

  // Section numbering, limited to depth 2 (mirrors number-depth: 2)
  let numbering-fn = if sectionnumbering != none {
    (..nums) => {
      if nums.pos().len() <= 2 { numbering(sectionnumbering, ..nums) }
    }
  } else { none }
  set heading(numbering: numbering-fn)

  show heading.where(level: 1): it => block(above: 1.9em, below: 1em)[
    #set text(font: heading-family, size: 1em, weight: "bold", fill: monash-red)
    #it
  ]
  show heading.where(level: 2): it => block(above: 1.3em, below: 0.5em)[
    #set text(font: heading-family, size: 0.9em, weight: "bold", fill: monash-red)
    #it
  ]
  show heading.where(level: 3): it => block(above: 1em, below: 0.4em)[
    #set text(font: heading-family, size: 0.9em, weight: "bold")
    #it
  ]

  // Figure/table captions: bold label, italic text, centered
  show figure.caption: it => align(center)[
    #strong[#it.supplement #context it.counter.display(it.numbering):]
    #emph(it.body)
  ]

  set table(inset: 6pt, stroke: none)
  set bibliography(title: [References])

  // ---- Cover page ----
  set page(
    paper: paper,
    margin: (top: 1cm, bottom: 1cm, left: 1.1cm, right: 1.1cm),
    numbering: none,
    header: none,
    footer: none,
  )

  let contact-row(glyph, value) = if value != none [
    #text(font: "Font Awesome 7 Free Solid", size: 9pt, fill: monash-blue)[#glyph]~
    #value \
  ]

  grid(
    columns: (6.3cm, 1fr),
    column-gutter: 0.5cm,
    v(0.5cm) + block(height: 26.7cm)[
      #v(0.3cm)
      #image("monash2.png", width: 6cm)
      #v(1fr)
      #image("MBSportrait.jpg", width: 2cm)
      #v(0.4cm)
      #block(width: 5cm)[
        #set par(leading: 0.5em, justify: false)
        #text(font: heading-family, size: 13pt, weight: "bold", fill: monash-blue)[#department]
      ]
      #v(0.55cm)
      #set text(font: heading-family, size: 10pt, fill: monash-blue)
      #set par(leading: 0.5em)
      #contact-row("\u{f095}", phone)
      #contact-row("\u{f0e0}", email)
      #v(0.35cm)
      #text(font: heading-family, size: 10pt, fill: monash-blue)[ABN: 12 377 614 012]
    ],
    v(0.8cm) + block(
      height: 26.6cm,
      stroke: (left: 1pt + black),
      inset: (left: 1cm),
    )[
      #v(3.6cm)
      #set par(justify: false)
      #if title != none {
        block(width: 9cm)[
          #set par(leading: 0.5em, justify: false)
          #text(font: heading-family, size: 24pt, weight: "bold", fill: monash-red)[#title]
        ]
      }
      #if subtitle != none {
        v(0.2cm)
        text(font: heading-family, size: 16pt, weight: "bold", fill: monash-red)[#subtitle]
      }
      #v(1fr)
      #if authors != none {
        set par(leading: 0.5em)
        for (i, a) in authors.enumerate() {
          if i > 0 { v(0.25cm) }
          text(font: heading-family, size: 14pt, weight: "bold")[#a.name]
          if a.degrees != none and a.degrees != [] {
            linebreak()
            text(font: heading-family, size: 12pt)[#a.degrees]
          }
        }
      }
      #v(2cm)
      #if organization != none {
        text(font: heading-family, size: 12pt)[Report for]
        linebreak()
        text(font: heading-family, size: 12pt)[#organization]
      }
      #v(0.7cm)
      #if date != none {
        text(font: heading-family, size: 13pt, weight: "bold")[#date]
      }
      #v(2cm)
    ],
  )

  place(
    bottom + right,
    dx: 0cm,
    dy: 0.2cm,
    grid(
      columns: 3,
      column-gutter: 9pt,
      image("AACSB.png", height: 0.6cm),
      image("EQUIS.png", height: 0.6cm),
      image("AMBA.png", height: 0.6cm),
    ),
  )

  pagebreak()

  // ---- Body pages ----
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
    header: context {
      if title != none {
        text(font: heading-family, size: 10pt)[#title]
        v(-12pt)
        line(length: 100%, stroke: 0.4pt)
      }
    },
    footer: context {
      line(length: 100%, stroke: 0.4pt)
      v(-10pt)
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        text(font: heading-family, size: 10pt)[
          #if authors != none {
            authors.map(a => a.family).join(", ")
          }#if date != none [: #date]
        ],
        text(font: heading-family, size: 16pt, weight: "bold")[#counter(page).display()],
      )
    },
  )

  if toc {
    let toc-heading = if toc_title == none { auto } else { toc_title }
    block(above: 0em, below: 2em)[
      #outline(title: toc-heading, depth: toc_depth, indent: toc_indent)
    ]
  }

  doc
}

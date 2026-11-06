// =============================================================================
// TEMPLATE — todos los estilos del documento (formato paper IEEE, 2 columnas).
// No depende de `metadata.typ`: todo se configura con los parámetros de
// `template` y `paper-header`.
// =============================================================================

// ---- Rótulos por idioma -----------------------------------------------------
// Se eligen con `lang` y se pueden sobrescribir uno a uno con `labels: (...)`.
#let labels-es = (
  abstract: [Resumen],
  keywords: [Palabras clave],
  bibliography: [Referencias],
  appendix: [Anexo],
  figure: [Fig.],
  table: [Tabla],
  equation: [Ec.],
  listing: [Listado],
)

#let labels-en = (
  abstract: [Abstract],
  keywords: [Index Terms],
  bibliography: [References],
  appendix: [Appendix],
  figure: [Fig.],
  table: [Table],
  equation: [Eq.],
  listing: [Listing],
)

#let get-labels(lang, overrides) = {
  let base = if lang == "en" { labels-en } else { labels-es }
  base + overrides
}

// Configuración activa (rótulos y color de acento), fijada por `template` y
// leída por `paper-header` y `appendix` para no repetir parámetros.
#let paper-config = state("paper-config", (labels: labels-es, accent: rgb("#1f3a5f"), mono-font: "DejaVu Sans Mono", font-size: 10pt))

// Cabecera del artículo (título, autoría, resumen y palabras clave) a ancho
// completo sobre las dos columnas de la primera página.
// `authors`: array de diccionarios (name:, affiliation:, email:); los campos
// ausentes o `none` se omiten.
#let paper-header(
  title: none,
  authors: (),
  kicker: none,
  date: none,
  abstract: none,
  keywords: (),
  author-columns: auto,
) = place(top + center, scope: "parent", float: true, clearance: 1.8em, context {
  let cfg = paper-config.get()
  let l = cfg.labels
  let ncols = if author-columns == auto { calc.max(1, calc.min(authors.len(), 3)) } else { author-columns }

  let author-cell(a) = {
    text(size: 11pt)[#a.at("name", default: none)]
    if a.at("affiliation", default: none) != none {
      linebreak()
      text(size: 8.5pt, style: "italic")[#a.affiliation]
    }
    if a.at("email", default: none) != none {
      linebreak()
      text(size: 8pt, font: cfg.mono-font)[#a.email]
    }
  }

  block(width: 100%, clip: true)[
    #set par(first-line-indent: 0pt, justify: true)
    #align(center)[
      #if kicker != none [
        #text(size: 8pt, fill: cfg.accent, tracking: 0.04em)[#upper(kicker)]
        #v(0.9em)
      ]
      #par(justify: false)[#text(size: 17pt, weight: "regular", hyphenate: false)[#title]]
      #v(1em)
      #grid(
        columns: (1fr,) * ncols,
        row-gutter: 0.9em,
        column-gutter: 1em,
        ..authors.map(author-cell),
      )
      #if date != none [
        #v(0.3em)
        #text(size: 8.5pt)[#date]
      ]
    ]
    #v(1.2em)
    #line(length: 100%, stroke: 0.5pt + luma(150))
    #v(0.4em)
    #if abstract != none {
      text(size: 9pt)[#text(weight: "bold", style: "italic")[#l.abstract—]#abstract]
    }
    #if keywords.len() > 0 [
      #v(0.5em)
      #align(left, text(size: 9pt)[
        #text(weight: "bold", style: "italic")[#l.keywords—]#keywords.join(", ").
      ])
    ]
    #v(0.4em)
    #line(length: 100%, stroke: 0.5pt + luma(150))
  ]
})

#let template(
  body,
  lang: "es",
  region: auto,
  labels: (:),
  accent: rgb("#1f3a5f"),
  font: "New Computer Modern",
  mono-font: "DejaVu Sans Mono",
  font-size: 10pt,
  paper: "a4",
  margin: (x: 1.7cm, top: 2.1cm, bottom: 2cm),
  columns: 2,
  column-gutter: 0.55cm,
  header-left: none,
  header-right: none,
) = {
  let l = get-labels(lang, labels)
  let region = if region == auto { if lang == "es" { "es" } else { none } } else { region }

  // ---- Página -------------------------------------------------------------
  // La cabecera corrida se muestra desde la página 2 si hay algún texto.
  set page(
    paper: paper,
    margin: margin,
    columns: columns,
    numbering: "1",
    header: context {
      if here().page() > 1 and (header-left != none or header-right != none) {
        set text(size: 7.5pt, fill: luma(90))
        grid(
          columns: (1fr, auto),
          header-left,
          header-right,
        )
        v(-0.5em)
        line(length: 100%, stroke: 0.4pt + luma(170))
      }
    },
    footer: context {
      set text(size: 8pt)
      align(center, counter(page).display("1"))
    },
  )
  set std.columns(gutter: column-gutter)

  // ---- Texto --------------------------------------------------------------
  set text(font: font, size: font-size, lang: lang, region: region)
  set par(justify: true, leading: 0.55em, spacing: 0.6em, first-line-indent: (amount: 1em, all: false))
  set list(indent: 0.6em, body-indent: 0.4em)
  set enum(indent: 0.6em, body-indent: 0.4em)
  show link: set text(fill: accent)
  show ref: set text(fill: accent)
  show cite: set text(fill: accent)

  // ---- Encabezados (estilo IEEE: I. SECCIÓN / A. Subsección) --------------
  set heading(numbering: "I.A.1")
  show heading: set block(sticky: true)
  show heading.where(level: 1): it => block(above: 1.3em, below: 0.75em, width: 100%)[
    #set align(center)
    #set text(size: font-size, weight: "regular")
    #if it.numbering != none [#context counter(heading).display("I.")#h(0.5em)]
    #smallcaps(it.body)
  ]
  show heading.where(level: 2): it => block(above: 1em, below: 0.6em)[
    #set text(size: font-size, weight: "regular", style: "italic")
    #if it.numbering != none [#context numbering("A.", ..counter(heading).get().slice(1, 2))#h(0.45em)]
    #it.body
  ]
  show heading.where(level: 3): it => block(above: 0.8em, below: 0.5em)[
    #set text(size: font-size, weight: "regular", style: "italic")
    #if it.numbering != none [#context numbering("1)", ..counter(heading).get().slice(2, 3))#h(0.4em)]
    #it.body:
  ]

  // ---- Ecuaciones ---------------------------------------------------------
  set math.equation(numbering: "(1)", supplement: l.equation)
  show math.equation.where(block: true): set block(above: 0.8em, below: 0.8em)

  // ---- Figuras y tablas ---------------------------------------------------
  set figure(gap: 0.6em)
  set figure.caption(separator: [. ])
  show figure.caption: set text(size: 0.8em)
  show figure.caption: set align(left)
  show figure.caption: set par(justify: true)
  show figure.where(kind: image): set figure(supplement: l.figure)
  show figure.where(kind: table): set figure(supplement: l.table)
  show figure.where(kind: "listing"): set figure(supplement: l.listing)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: "listing"): set figure.caption(position: top)
  show figure: set block(above: 1em, below: 1em)
  set table(stroke: none, inset: (x: 4pt, y: 3pt))
  show table: set text(size: 0.8em)
  show table: set par(justify: false)

  // ---- Código -------------------------------------------------------------
  show raw: set text(font: mono-font)
  show raw.where(block: false): set text(size: 0.85em)
  show raw.where(block: true): set text(size: 0.7em)
  show raw.where(block: true): set align(left)
  show raw.where(block: true): it => block(
    width: 100%,
    fill: luma(245),
    stroke: 0.4pt + luma(200),
    inset: 6pt,
    radius: 2pt,
    it,
  )

  // ---- Bibliografía -------------------------------------------------------
  set bibliography(style: "ieee", title: l.bibliography)
  show bibliography: set text(size: 0.8em)
  show bibliography: set heading(numbering: none)

  // ---- Outlines (listas de figuras/tablas/listados) -----------------------
  set outline(indent: auto)
  show outline: set heading(numbering: none, outlined: false)

  paper-config.update((labels: l, accent: accent, mono-font: mono-font, font-size: font-size))
  body
}

// Activa el modo anexos: una columna, numeración A, B, C… y el rótulo
// `labels.appendix` ("Anexo" / "Appendix") definido en `template`.
#let appendix(body) = context {
  let cfg = paper-config.get()
  let l = cfg.labels
  set page(columns: 1)
  set heading(numbering: "A.1", supplement: l.appendix)
  counter(heading).update(0)
  show heading.where(level: 1): it => block(above: 1.4em, below: 0.8em, width: 100%)[
    #set text(size: cfg.font-size * 1.1, weight: "bold")
    #if it.numbering != none [#l.appendix #context counter(heading).display("A").#h(0.5em)]
    #it.body
  ]
  show heading.where(level: 2): it => block(above: 1em, below: 0.6em)[
    #set text(size: cfg.font-size, weight: "bold")
    #if it.numbering != none [#context counter(heading).display("A.1")#h(0.5em)]
    #it.body
  ]
  body
}

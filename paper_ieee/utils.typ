// =============================================================================
// UTILS — componentes reutilizables (imágenes, rejillas comparativas, tablas).
// =============================================================================

// Indicación de contenido pendiente. Búscalas con "TODO" antes de entregar.
#let todo(body) = text(fill: rgb("#9a5b00"), style: "italic", size: 0.92em)[[TODO: #body]]

// Imagen o, si `path` es `none`, un marcador gris con el texto `label`.
#let img-slot(path, label: [Imagen pendiente], height: 2.6cm, width: 100%) = {
  if path == none {
    rect(
      width: width,
      height: height,
      fill: luma(238),
      stroke: (paint: luma(160), thickness: 0.6pt, dash: "dashed"),
      align(center + horizon, text(size: 7pt, fill: luma(100))[#label]),
    )
  } else {
    image(path, width: width, height: if height == auto { auto } else { height }, fit: "contain")
  }
}

// Subfigura con rótulo "(a) texto" debajo.
#let subfig(body, letter, cap) = stack(
  dir: ttb,
  spacing: 0.35em,
  body,
  align(center, text(size: 7.5pt)[(#letter) #cap]),
)

// Rejilla comparativa: `items` es un array de (ruta, rótulo).
// Las subfiguras se etiquetan automáticamente (a), (b), (c)…
#let comparison-grid(items, columns: 4, height: 2.6cm, gutter: 6pt) = grid(
  columns: (1fr,) * columns,
  gutter: gutter,
  ..items.enumerate().map(((i, it)) => {
    let (path, cap) = it
    subfig(img-slot(path, label: cap, height: height), numbering("a", i + 1), cap)
  }),
)

// Tabla de métricas con filetes tipo booktabs.
// `header`: array de celdas de cabecera; `rows`: arrays de celdas.
// `best`: lista de (fila, columna) a resaltar en negrita (índices desde 0, sin cabecera).
#let metrics-table(header, ..rows, best: ()) = {
  let rows = rows.pos()
  let ncols = header.len()
  table(
    columns: (auto,) + (1fr,) * (ncols - 1),
    align: (x, y) => if x == 0 { left + horizon } else { center + horizon },
    table.hline(stroke: 0.8pt),
    table.header(..header.map(h => strong(h))),
    table.hline(stroke: 0.5pt),
    ..rows.enumerate().map(((r, row)) => row.enumerate().map(((c, cell)) => {
      if (r, c) in best { strong(cell) } else { cell }
    })).flatten(),
    table.hline(stroke: 0.8pt),
  )
}

// Celda de valor pendiente.
#let tbd = text(fill: luma(120))[--]

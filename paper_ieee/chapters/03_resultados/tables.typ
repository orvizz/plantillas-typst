// Tablas del capítulo III. Resultados.
// Rellena los valores sustituyendo `tbd`. Usa `best: ((fila, col),)` para
// resaltar en negrita el mejor valor (índices desde 0, sin contar cabecera).
#import "../../utils.typ": metrics-table, tbd

#let cols = ([Configuración], [Métrica 1], [Métrica 2], [Métrica 3])
#let row(name) = (name, tbd, tbd, tbd)

#let tab-resultados = [
  #figure(
    metrics-table(
      cols,
      ([Referencia], [0.61], [12.4], [0.80]),
      ([$a = 0.5$], [0.72], [11.9], [0.83]),
      ([$a = 1$], [0.78], [10.2], [0.79]),
      row[$a = 2$],
      best: ((2, 1), (2, 2), (1, 3)),
    ),
    caption: [Resultados del experimento 1 para cada valor de $a$ (valores de ejemplo).],
  ) <tab:resultados>
]

// Tabla a ancho completo (dos columnas) para comparativas con muchas columnas.
#let tab-global = [
  #figure(
    placement: top,
    scope: "parent",
    metrics-table(
      ([Método], [Métrica 1], [Métrica 2], [Métrica 3], [Métrica 4], [Métrica 5], [Valoración]),
      ([Método A], tbd, tbd, tbd, tbd, tbd, tbd),
      ([Método B], tbd, tbd, tbd, tbd, tbd, tbd),
      ([Método propuesto], tbd, tbd, tbd, tbd, tbd, tbd),
    ),
    caption: [Comparativa global entre métodos.],
  ) <tab:global>
]

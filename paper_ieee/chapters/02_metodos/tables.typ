// Tablas del capítulo II. Material y métodos.
#import "../../utils.typ": metrics-table, tbd

#let tab-material = [
  #figure(
    metrics-table(
      ([Id.], [Descripción], [Tamaño], [Origen]),
      ([D1], [#tbd], [#tbd], [#tbd]),
      ([D2], [#tbd], [#tbd], [#tbd]),
      ([D3], [#tbd], [#tbd], [#tbd]),
    ),
    caption: [Material utilizado y sus características principales.],
  ) <tab:material>
]

#let tab-parametros = [
  #figure(
    metrics-table(
      ([Parámetro], [Símbolo], [Valores explorados]),
      ([Ganancia], [$a$], [$a in {0.5, 1, 2}$]),
      ([Desplazamiento], [$b$], [#tbd]),
    ),
    caption: [Parámetros del método (@eq:ejemplo) y valores explorados.],
  ) <tab:parametros>
]

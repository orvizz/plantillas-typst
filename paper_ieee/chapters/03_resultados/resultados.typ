// =============================================================================
// III. RESULTADOS Y DISCUSIÓN — figuras, tablas e interpretación crítica.
// =============================================================================
#import "../../metadata.typ": imgs
#import "../../utils.typ": todo, img-slot, comparison-grid
#import "tables.typ": tab-resultados, tab-global

= Resultados y discusión <sec:resultados>

#todo[Introduce brevemente qué se muestra en esta sección y con qué criterios se evalúa].

== Experimento 1 <sec:res-exp1>

// Figura a ancho completo (ocupa las dos columnas, arriba de la página).
#figure(
  placement: top,
  scope: "parent",
  comparison-grid((
    (imgs.ejemplo.original, [Original]),
    (imgs.ejemplo.resultado, [Resultado]),
    (imgs.ejemplo.detalle-a, [Detalle A]),
    (imgs.ejemplo.detalle-b, [Detalle B]),
  )),
  caption: [Comparativa visual del experimento 1. Las subfiguras se etiquetan automáticamente (a)–(d).],
) <fig:exp1>

La @fig:exp1 muestra que #todo[describe lo que se observa]. La @tab:resultados cuantifica estos resultados; el mejor valor de cada columna aparece en negrita.

#tab-resultados

// Figura a una columna.
#figure(
  img-slot(imgs.ejemplo.grafica, label: [Gráfica pendiente], height: 3.4cm),
  caption: [Evolución de la métrica en función del parámetro $a$ (@eq:ejemplo).],
) <fig:exp1-grafica>

#todo[Interpretación crítica de la @fig:exp1-grafica: tendencia, compromiso y limitaciones].

== Comparativa global <sec:res-global>

#tab-global

La @tab:global resume #todo[comparativa entre configuraciones o métodos].

== Limitaciones <sec:res-limitaciones>

- *Limitación 1*: #todo[descripción y posible solución].
- *Limitación 2*: #todo[descripción y posible solución].

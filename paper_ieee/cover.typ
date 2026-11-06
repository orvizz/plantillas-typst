// =============================================================================
// COVER — cabecera del artículo en la primera página (formato paper).
// Nota: la "portada" es el bloque de título + resumen a ancho completo, no una
// página independiente (desviación justificada de la política para respetar el
// formato de artículo científico).
// =============================================================================
#import "metadata.typ": *
#import "template.typ": paper-header
#import "utils.typ": todo

#paper-header(
  title: doc-title,
  authors: doc-authors,
  kicker: doc-kicker,
  date: doc-date,
  keywords: doc-keywords,
  // El resumen debe ser más breve que la introducción (≈150-250 palabras):
  // objetivo → método → resultados cuantitativos clave → conclusión/relevancia.
  abstract: [
    #todo[Contexto y problema en una o dos frases]. #todo[Objetivo del trabajo y método empleado]. #todo[Resultados principales, con cifras]. #todo[Conclusión y relevancia práctica].
  ],
)

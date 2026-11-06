// =============================================================================
// MAIN — orquestador del documento.
// Compilar con:  typst compile main.typ
// =============================================================================
#import "metadata.typ": doc-title, doc-short-title, doc-authors, doc-kicker, doc-lang, doc-accent
#import "template.typ": template, appendix

#set document(
  title: doc-title,
  author: doc-authors.map(a => a.name),
  date: auto,
)

#show: template.with(
  lang: doc-lang,
  accent: doc-accent,
  header-left: doc-short-title,
  header-right: doc-kicker,
)

// Cabecera del artículo (título + autores + resumen) en la primera página.
#include "cover.typ"

// Cuerpo del artículo (flujo continuo a dos columnas, sin saltos de página).
#include "chapters/01_introduccion/introduccion.typ"
#include "chapters/02_metodos/metodos.typ"
#include "chapters/03_resultados/resultados.typ"
#include "chapters/04_conclusiones/conclusiones.typ"

#bibliography("sources.bib")

// Material complementario a una columna: declaración de IA y anexos.
#pagebreak(weak: true)
#show: appendix
// Opcional: borra esta línea (y la carpeta) si no necesitas la declaración.
#include "chapters/05_declaracion_ia/declaracion_ia.typ"
#include "chapters/06_anexos/anexos.typ"

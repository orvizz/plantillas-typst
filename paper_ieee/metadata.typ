// =============================================================================
// METADATA — datos reutilizados en todo el documento.
// Cambia aquí cualquier dato y se actualizará en todas partes.
// =============================================================================

#let doc-title = "Título completo del artículo"
// Versión corta para la cabecera corrida de las páginas 2 en adelante.
#let doc-short-title = "Título corto"
// Lista de autores. Cada uno admite `name`, `affiliation` y `email`; los campos
// que no se indiquen (o valgan `none`) no se muestran.
#let doc-authors = (
  (
    name: "Nombre Apellido1 Apellido2",
    affiliation: "Departamento — Universidad [NOMBRE]",
    email: "correo@universidad.es",
  ),
  // (name: "Segundo Autor", affiliation: "Institución", email: "otro@dominio.es"),
)
// Línea pequeña sobre el título (asignatura, actividad, congreso…). `none` la oculta.
#let doc-kicker = "Asignatura · Actividad"
#let doc-date = "Mes de Año"
#let doc-keywords = (
  "palabra clave 1",
  "palabra clave 2",
  "palabra clave 3",
)

// Idioma del documento: "es" o "en" (rótulos, separación silábica, comillas).
#let doc-lang = "es"
// Color de enlaces, referencias, citas y línea superior de la cabecera.
#let doc-accent = rgb("#1f3a5f")

// -----------------------------------------------------------------------------
// Rutas de las imágenes. Mientras valgan `none` se muestra un marcador gris.
// Las rutas son relativas a la raíz del proyecto (donde está `main.typ`),
// p. ej. "resources/figuras/ejemplo_original.png". Agrupa las rutas como
// prefieras (por experimento, por capítulo…) y úsalas como `imgs.ejemplo.original`.
// -----------------------------------------------------------------------------
#let imgs = (
  ejemplo: (
    original: none,     // "resources/figuras/ejemplo_original.png"
    resultado: none,    // "resources/figuras/ejemplo_resultado.png"
    detalle-a: none,
    detalle-b: none,
    grafica: none,      // "resources/figuras/ejemplo_grafica.png"
  ),
)

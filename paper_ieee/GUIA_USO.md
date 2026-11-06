# Guía de uso — `paper_ieee`

Plantilla de Typst para artículos científicos con formato tipo **IEEE a dos columnas**. Incluye cabecera con título, autores, resumen y palabras clave, secciones numeradas en romanos (I., II., …), figuras y tablas a una o dos columnas, ecuaciones numeradas, listados de código, bibliografía IEEE y anexos a una columna.

Sirve para trabajos de asignatura, informes de laboratorio, artículos de congreso o cualquier documento breve con estructura de paper. Viene en español por defecto, pero se puede pasar a inglés con un solo cambio.

---

## 1. Estructura de ficheros

```
paper_ieee/
├── main.typ            Orquestador: configura el documento e incluye todo lo demás.
├── template.typ        Estilos y funciones de maquetación: template, paper-header, appendix.
├── utils.typ           Componentes reutilizables: todo, img-slot, subfig, comparison-grid, metrics-table, tbd.
├── metadata.typ        Datos del documento (título, autores, idioma…) y rutas de imágenes.
├── cover.typ           Cabecera de la primera página (título + autores + resumen).
├── sources.bib         Bibliografía (BibTeX).
├── TYPST_POLICY.md     Política de estructura (copia local de la plantilla).
├── chapters/
│   ├── 01_introduccion/introduccion.typ
│   ├── 02_metodos/metodos.typ + tables.typ
│   ├── 03_resultados/resultados.typ + tables.typ
│   ├── 04_conclusiones/conclusiones.typ
│   ├── 05_declaracion_ia/declaracion_ia.typ   (opcional)
│   └── 06_anexos/anexos.typ
└── resources/
    ├── figuras/        Imágenes y gráficas del documento.
    └── logos/
```

## 2. Inicio rápido

1. Copia la carpeta `paper_ieee/` a tu proyecto.
2. Edita `metadata.typ` con tu título, autores, fecha y palabras clave.
3. Escribe el resumen en `cover.typ` y el contenido en `chapters/`.
4. Compila:
   ```sh
   typst compile main.typ        # genera main.pdf
   typst watch main.typ          # recompila al guardar
   ```

Compila siempre `main.typ`, no los capítulos por separado. Un capítulo suelto no ve las etiquetas de los demás, así que el editor puede marcar errores como `label <eq:ejemplo> does not exist` que no aparecen al compilar `main.typ`.

La plantilla usa las fuentes **New Computer Modern** (incluida en Typst) y **DejaVu Sans Mono** para el código. Si no tienes esta última, cámbiala con el parámetro `mono-font` (ver §4).

---

## 3. `metadata.typ` — datos del documento

Todo lo que se repite en el documento está aquí. Si cambias un valor, se actualiza en todas partes.

| Variable          | Tipo                 | Uso |
|-------------------|----------------------|-----|
| `doc-title`       | string               | Título en la cabecera y en los metadatos del PDF. |
| `doc-short-title` | string               | Título corto de la cabecera corrida (izquierda, desde la página 2). |
| `doc-authors`     | array de diccionarios | Autores (ver abajo). Sus nombres pasan a los metadatos del PDF. |
| `doc-kicker`      | string o `none`      | Línea pequeña sobre el título, en mayúsculas y color de acento (asignatura, actividad, congreso…). También aparece a la derecha de la cabecera corrida. Con `none` se oculta. |
| `doc-date`        | string o `none`      | Fecha bajo los autores. |
| `doc-keywords`    | array de strings     | Palabras clave. Con `()` se oculta la línea. |
| `doc-lang`        | `"es"` o `"en"`      | Idioma: rótulos, separación silábica y comillas. |
| `doc-accent`      | color                | Color de enlaces, referencias, citas y del *kicker*. |
| `imgs`            | diccionario          | Rutas de las imágenes (ver §7.2). |

**Autores.** Cada autor es un diccionario con `name`, `affiliation` y `email`. Solo `name` es obligatorio; los demás campos se omiten si no se indican o valen `none`.

```typst
#let doc-authors = (
  (name: "Ana García", affiliation: "Universidad X", email: "ana@x.es"),
  (name: "Luis Pérez", affiliation: "Universidad Y"),
)
```

Los autores se colocan en una rejilla de hasta 3 columnas. Si hay más, pasan a la fila siguiente.

---

## 4. `template(body, ..)` — estilos globales

Se aplica en `main.typ` con una regla `show`:

```typst
#show: template.with(
  lang: doc-lang,
  accent: doc-accent,
  header-left: doc-short-title,
  header-right: doc-kicker,
)
```

Todos los parámetros son opcionales:

| Parámetro       | Por defecto                              | Descripción |
|-----------------|------------------------------------------|-------------|
| `lang`          | `"es"`                                   | Idioma del texto y conjunto de rótulos (`"es"` o `"en"`). |
| `region`        | `auto`                                   | Región del idioma. Con `auto` es `"es"` si `lang` es `"es"`. |
| `labels`        | `(:)`                                    | Sustituye rótulos sueltos (ver abajo). |
| `accent`        | `rgb("#1f3a5f")`                         | Color de enlaces, `@ref` y citas. |
| `font`          | `"New Computer Modern"`                  | Fuente del texto. |
| `mono-font`     | `"DejaVu Sans Mono"`                     | Fuente del código y de los correos. |
| `font-size`     | `10pt`                                   | Tamaño base. Títulos, pies y tablas escalan a partir de él. |
| `paper`         | `"a4"`                                   | Tamaño de papel (`"us-letter"`, …). |
| `margin`        | `(x: 1.7cm, top: 2.1cm, bottom: 2cm)`    | Márgenes. |
| `columns`       | `2`                                      | Número de columnas del cuerpo. Con `1` queda un informe a una columna. |
| `column-gutter` | `0.55cm`                                 | Separación entre columnas. |
| `header-left`   | `none`                                   | Texto izquierdo de la cabecera corrida (páginas ≥ 2). |
| `header-right`  | `none`                                   | Texto derecho de la cabecera corrida. Si ambos son `none`, no hay cabecera. |

**Qué configura `template`:**
- Párrafos justificados con sangría de primera línea.
- Encabezados IEEE: `I. SECCIÓN` en versalitas centradas, `A. Subsección` en cursiva y `1) Subsubsección:` en cursiva, terminada en dos puntos.
- Ecuaciones numeradas `(1)`.
- Pie de figura debajo de las imágenes y encima de las tablas y listados.
- Tablas sin bordes.
- Bloques de código con fondo gris.
- Bibliografía en estilo `ieee`.
- Pie de página con el número de página.

### Idioma y rótulos

| Clave          | `"es"`          | `"en"`        |
|----------------|-----------------|---------------|
| `abstract`     | Resumen         | Abstract      |
| `keywords`     | Palabras clave  | Index Terms   |
| `bibliography` | Referencias     | References    |
| `appendix`     | Anexo           | Appendix      |
| `figure`       | Fig.            | Fig.          |
| `table`        | Tabla           | Table         |
| `equation`     | Ec.             | Eq.           |
| `listing`      | Listado         | Listing       |

Para cambiar solo algunos rótulos, pasa `labels` con las claves que quieras. El resto se toma del idioma:

```typst
#show: template.with(lang: "en", labels: (keywords: [Keywords], figure: [Figure]))
```

`paper-header` y `appendix` leen automáticamente los rótulos y el color definidos en `template`. No hace falta repetirlos.

---

## 5. `paper-header(..)` — cabecera del artículo

Se llama una sola vez, en `cover.typ`. Coloca título, autores, resumen y palabras clave **a ancho completo** sobre las dos columnas de la primera página.

| Parámetro        | Descripción |
|------------------|-------------|
| `title`          | Título. |
| `authors`        | Array de autores (`name`, `affiliation`, `email`). |
| `kicker`         | Línea superior pequeña (o `none`). |
| `date`           | Fecha (o `none`). |
| `abstract`       | Contenido del resumen (o `none` para omitirlo). |
| `keywords`       | Array de palabras clave (`()` para omitirlas). |
| `author-columns` | Columnas de la rejilla de autores. Con `auto` es `min(nº autores, 3)`. |

```typst
#paper-header(
  title: doc-title,
  authors: doc-authors,
  kicker: doc-kicker,
  date: doc-date,
  keywords: doc-keywords,
  abstract: [Texto del resumen…],
)
```

---

## 6. `appendix(body)` — modo anexos

Se activa en `main.typ` tras la bibliografía, con `#show: appendix`. A partir de ese punto:

- La página pasa a **una columna**.
- La numeración de secciones se reinicia como `A`, `B`, `C`… y las subsecciones como `A.1`.
- Las secciones de nivel 1 se titulan «Anexo A. …» («Appendix A. …» en inglés), y `@sec:...` las referencia como «Anexo A».

Las secciones sin numerar, como la declaración de IA, no llevan el prefijo «Anexo».

---

## 7. `utils.typ` — componentes reutilizables

Importa solo lo que necesites, con la ruta relativa al capítulo:

```typst
#import "../../utils.typ": todo, img-slot, comparison-grid, metrics-table, tbd
```

### 7.1 `todo(body)`
Marca contenido pendiente en naranja y cursiva: `[TODO: …]`. Antes de entregar, busca «TODO» para no dejar ninguno.

```typst
#todo[Añadir la cifra de precisión final]
```

### 7.2 `img-slot(path, label: .., height: 2.6cm, width: 100%)`
Muestra la imagen de `path`. Si `path` es `none`, dibuja un **marcador gris discontinuo** con el texto `label`. Así puedes maquetar el documento antes de tener las imágenes.

- `height: auto` respeta la proporción de la imagen.
- La imagen se ajusta con `fit: "contain"`, así que no se deforma.

Se combina con el diccionario `imgs` de `metadata.typ`:

```typst
// metadata.typ
#let imgs = (exp1: (original: "resources/figuras/exp1.png", resultado: none))

// capítulo
#figure(
  img-slot(imgs.exp1.original, label: [Original], height: 3cm),
  caption: [Imagen original.],
) <fig:exp1-original>
```

Las rutas son relativas a la raíz del proyecto, porque `img-slot` se define en `utils.typ`, que está en la raíz.

### 7.3 `subfig(body, letter, cap)`
Apila un contenido con el rótulo `(letter) cap` debajo. Normalmente no se usa directamente, porque `comparison-grid` lo llama por ti.

```typst
#subfig(image("resources/figuras/a.png"), "a", [Original])
```

### 7.4 `comparison-grid(items, columns: 4, height: 2.6cm, gutter: 6pt)`
Rejilla de subfiguras etiquetadas automáticamente como (a), (b), (c)… `items` es un array de pares `(ruta, rótulo)`, y las rutas `none` se muestran como marcador.

```typst
#figure(
  placement: top, scope: "parent",      // ancho completo (ver §8.1)
  comparison-grid((
    (imgs.exp1.original, [Original]),
    (imgs.exp1.resultado, [Resultado]),
    (none, [Histograma]),
  ), columns: 3, height: 2.9cm),
  caption: [Comparativa del experimento 1.],
) <fig:exp1>
```

### 7.5 `metrics-table(header, ..rows, best: ())`
Tabla con filetes tipo *booktabs* (línea gruesa arriba y abajo, fina bajo la cabecera).

- La primera columna se alinea a la izquierda; las demás, centradas y con el mismo ancho.
- La cabecera se pone en negrita.
- `best` es una lista de pares `(fila, columna)` que se resaltan en negrita. Los índices empiezan en 0 y **no cuentan la cabecera**.

```typst
#metrics-table(
  ([Método], [Precisión], [Tiempo (s)]),
  ([A], [0.81], [12.0]),
  ([B], [0.86], [9.5]),
  best: ((1, 1), (1, 2)),
)
```

Como cualquier tabla, debe ir dentro de un `#figure(..)` con su `caption` y su etiqueta `<tab:...>`.

### 7.6 `tbd`
Celda de valor pendiente (un `--` gris). Úsala en tablas a medio rellenar. Un patrón útil es crear filas vacías con una función auxiliar:

```typst
#let row(name) = (name, tbd, tbd, tbd)
#metrics-table(([Config.], [M1], [M2], [M3]), row[Base], row[Propuesto])
```

---

## 8. Elementos del documento

### 8.1 Figuras y tablas a una o dos columnas
- **Una columna** (por defecto): `#figure(..)` sin más.
- **Ancho completo** (las dos columnas): añade `placement: top, scope: "parent"`. La figura flota a la parte superior de la página. Úsalo para rejillas comparativas o tablas con muchas columnas (ver `tab-global` en `chapters/03_resultados/tables.typ`).

### 8.2 Tablas en `tables.typ`
Según la política, todas las tablas de un capítulo viven en su `tables.typ` y se importan desde el capítulo. Envuelve cada tabla en `[...]` para poder etiquetarla dentro de un `#let`:

```typst
// chapters/02_metodos/tables.typ
#let tab-material = [
  #figure(metrics-table(..), caption: [..]) <tab:material>
]

// chapters/02_metodos/metodos.typ
#import "tables.typ": tab-material
#tab-material
```

### 8.3 Ecuaciones
Las ecuaciones de bloque se numeran solas. Etiquétalas con `eq:` para poder citarlas:

```typst
$ y = a x + b. $ <eq:lineal>
Según la @eq:lineal…          // → "Ec. 1"
```

### 8.4 Listados de código
Usa una figura con `kind: "listing"`. El rótulo «Listado» y la posición del pie arriba se aplican solos:

```typst
#figure(kind: "listing", caption: [Función principal.])[
  ```python
  def f(x): return 2 * x
  ```
] <lst:principal>
```

Para leer el código desde un fichero:
`raw(read("../../code/main.py"), lang: "python", block: true)`.

### 8.5 Etiquetas y referencias
Usa siempre `@etiqueta`, nunca números escritos a mano. Prefijos obligatorios:

| Prefijo | Elemento |
|---------|----------|
| `sec:`  | Secciones |
| `fig:`  | Figuras |
| `tab:`  | Tablas |
| `eq:`   | Ecuaciones |
| `lst:`  | Listados |

Si quieres un texto propio en lugar del rótulo automático, usa `#link(<sec:ia>)[declaración sobre el uso de IA]`.

### 8.6 Bibliografía
Añade las entradas a `sources.bib` y cítalas con `@clave` (p. ej. `@shannon1948`). Para varias citas seguidas, escribe `@a @b`. Solo aparecen en la lista las entradas citadas. Las entradas de ejemplo (`knuth1984texbook`, `shannon1948`, `typstdocs`) se pueden borrar.

---

## 9. Adaptar la estructura

- **Añadir un capítulo.** Crea `chapters/NN_nombre/nombre.typ`, empieza con `= Título <sec:nombre>` y añade su `#include` en `main.typ`. Cada capítulo gestiona sus propias subsecciones.
- **Quitar un capítulo.** Borra su `#include` en `main.typ` y las referencias `@sec:...` que apunten a él.
- **Declaración de IA (opcional).** Si no la necesitas, elimina la línea `#include "chapters/05_declaracion_ia/declaracion_ia.typ"` de `main.typ` y la carpeta.
- **Sin anexos.** Elimina desde `#pagebreak(weak: true)` hasta el final de `main.typ`. Ten en cuenta que las listas de figuras, tablas y listados están en `anexos.typ`. Si las mantienes, muévelas a otro sitio.
- **Documento a una columna.** Pasa `columns: 1` a `template`. Las figuras con `scope: "parent"` siguen funcionando.

## 10. Antes de entregar

- Busca `TODO` en todo el proyecto (`grep -rn "TODO" chapters cover.typ`).
- Comprueba que no quedan rutas `none` en `imgs` ni celdas `tbd` en las tablas.
- Borra las entradas de ejemplo de `sources.bib` que no uses y los valores de ejemplo de las tablas.
- Revisa que el resumen sea más corto que la introducción.

## 11. Desviaciones respecto a `TYPST_POLICY.md`

- **Portada.** La política pide una portada de una página exacta. En formato paper, la «portada» es la cabecera a ancho completo de la primera página (`paper-header`). El bloque usa `clip: true` para que no desborde.
- **Listas de figuras y tablas.** La política las sitúa en `main.typ`. Aquí están en `chapters/06_anexos/anexos.typ` para no consumir espacio del cuerpo del artículo. Siguen incluyendo figuras, tablas y listados (`kind: "listing"`).
- **Saltos de página.** El cuerpo del artículo es un flujo continuo a dos columnas, por lo que no hay `#pagebreak` entre capítulos. Solo hay uno antes de los anexos.

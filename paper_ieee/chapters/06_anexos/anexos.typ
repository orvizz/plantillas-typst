// =============================================================================
// ANEXOS — código, resultados complementarios y listas de figuras, tablas y
// listados. Se maquetan a una columna (ver `appendix` en template.typ).
// =============================================================================
#import "../../utils.typ": todo

= Código fuente <sec:anexo-codigo>

#todo[Pega aquí el código o léelo de fichero con `raw(read("../../code/archivo.py"), lang: "python", block: true)`.] El @lst:ejemplo muestra el formato de un listado.

#figure(
  kind: "listing",
  caption: [Ejemplo de listado de código.],
)[
```python
def linear(x, a=1.0, b=0.0):
    """Aplica y = a·x + b (Ec. 1)."""
    return a * x + b
```
] <lst:ejemplo>

= Resultados complementarios <sec:anexo-extra>

#todo[Figuras o tablas extensas que no caben en el cuerpo. Refiérelas desde el texto, p. ej. «véase el @sec:anexo-extra»].

= Listas de figuras, tablas y listados <sec:anexo-listas>

#outline(title: [Lista de figuras], target: figure.where(kind: image))
#outline(title: [Lista de tablas], target: figure.where(kind: table))
#outline(title: [Lista de listados], target: figure.where(kind: "listing"))

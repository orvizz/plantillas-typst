// =============================================================================
// II. MATERIAL Y MÉTODOS — descripción formal y reproducible del trabajo.
// =============================================================================
#import "../../utils.typ": todo
#import "tables.typ": tab-material, tab-parametros

= Material y métodos <sec:metodos>

== Material y entorno <sec:material>

#todo[Describe los datos, equipos o software utilizados (con versión) y cómo se obtuvieron]. La @tab:material resume sus características.

#tab-material

== Método propuesto <sec:metodo>

#todo[Describe el método paso a paso, de forma independiente de la implementación]. Las ecuaciones numeradas se etiquetan con el prefijo `eq:` para poder referenciarlas, como la @eq:ejemplo:
$ y = f(x) = a x + b. $ <eq:ejemplo>

=== Variante o subetapa
Los encabezados de tercer nivel se muestran en cursiva y terminan en dos puntos. Una ecuación de varias líneas alineada:
$ H &= - sum_(k=0)^(L-1) p_k log_2 p_k, \ p_k &= n_k / N. $ <eq:ejemplo-multilinea>

Su uso sigue a @shannon1948. Los parámetros explorados se recogen en la @tab:parametros.

#tab-parametros

== Procedimiento experimental <sec:procedimiento>

+ #todo[Paso 1].
+ #todo[Paso 2].
+ #todo[Paso 3: criterio de selección de parámetros o de evaluación].

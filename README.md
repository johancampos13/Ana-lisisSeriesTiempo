# Ana-lisisSeriesTiempo
Repositorio códigos R para la clase de Análisis de Series de Tiempo, PUJ CALI

Mini libro en bookdown sobre el índice mensual de ventas reales del comercio minorista en Colombia (DANE, Encuesta Mensual de Comercio).

- **Libro:** https://johancampos13.github.io/Ana-lisisSeriesTiempo/
- **Unidad 1 – Propuesta:** `propuesta.Rmd` → `propuesta.html` (también en el capítulo 1 del libro)
- **Unidad 2 – Promedio móvil, rezagos y estacionalidad:** capítulos 2 a 6 del libro

## Estructura

| Archivo | Contenido |
|:--|:--|
| `index.Rmd`, `01-*.Rmd` … `07-*.Rmd` | Capítulos del libro |
| `_bookdown.yml`, `_output.yml`, `libro.css`, `referencias.bib`, `apa.csl` | Configuración de bookdown |
| `R/preparar_datos.R` | Descarga el anexo del DANE y genera `datos/ventas_reales_minorista.csv` |
| `R/compilar.R` | Compila el libro en `docs/` (carpeta publicada con GitHub Pages) |
| `datos/` | Anexo original del DANE y serie de trabajo |

## Reproducir

Con Conda instalado, cree y active el entorno con R, Pandoc y los paquetes requeridos:

```sh
conda env create -f environment.yml
conda activate series-tiempo
Rscript R/preparar_datos.R   # opcional: la serie ya está en datos/
Rscript R/compilar.R
```

Para la propuesta de la Unidad 1 como documento independiente: `Rscript -e 'rmarkdown::render("propuesta.Rmd")'`. Para imprimirla en una página, seleccione tamaño carta y escala 100 % en el diálogo de impresión; los estilos de impresión están en `propuesta.css`.

## Datos

Fuente: Departamento Administrativo Nacional de Estadística: www.dane.gov.co

Anexo `anex-EMC-SeriesIndiceEmpalmados-ago2026.xlsx`, hoja 1.2, columna «Total comercio minorista sin otros vehículos» (base 2019 = 100, enero 2013 – agosto 2026p). Los [términos y condiciones del DANE](https://www.dane.gov.co/index.php/terminos-y-condiciones) autorizan el uso, la transformación y el análisis de la información con la cita anterior.

# Ana-lisisSeriesTiempo
Repositorio códigos R para la clase de Análisis de Series de Tiempo, PUJ CALI

## Renderizar la propuesta

Con Conda instalado, cree y active el entorno con R, Pandoc y los paquetes requeridos:

```sh
conda env create -f environment.yml
conda activate series-tiempo
Rscript -e 'rmarkdown::render("propuesta.Rmd")'
```

El documento usa `bookdown::html_document2`. Para imprimirlo en una página, seleccione tamaño carta y escala 100 % en el diálogo de impresión; los estilos de impresión están en `propuesta.css`.

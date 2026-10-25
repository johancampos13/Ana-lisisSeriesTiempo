# Compila el mini libro en docs/ (publicado con GitHub Pages).
#
# Uso: Rscript R/compilar.R
# bookdown elimina los .html de la raíz que coinciden con un .Rmd, así que el entregable
# de la Unidad 1 (propuesta.html) se respalda antes y se restaura después de compilar.

respaldo <- tempfile(fileext = ".html")
file.copy("propuesta.html", respaldo)

bookdown::render_book("index.Rmd", quiet = TRUE)

file.copy(respaldo, "propuesta.html", overwrite = TRUE)
file.copy("propuesta.html", file.path("docs", "propuesta.html"), overwrite = TRUE)
file.create(file.path("docs", ".nojekyll"))
cat("Libro compilado en docs/index.html\n")

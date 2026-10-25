# Compila el libro en docs/
# bookdown borra propuesta.html de la raíz, por eso se guarda una copia antes
copia <- tempfile()
file.copy("propuesta.html", copia)

bookdown::render_book("index.Rmd")

file.copy(copia, "propuesta.html", overwrite = TRUE)
file.copy("propuesta.html", "docs/propuesta.html", overwrite = TRUE)
file.create("docs/.nojekyll")

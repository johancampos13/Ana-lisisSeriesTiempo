# Compila el libro en docs/
# bookdown borra los .html de la raíz (propuesta.html e index.html), por eso se guarda una copia antes
raiz <- c("propuesta.html", "index.html")
copia <- file.path(tempdir(), raiz)
file.copy(raiz, copia, overwrite = TRUE)

bookdown::render_book("index.Rmd")

file.copy(copia, raiz, overwrite = TRUE)
file.copy("propuesta.html", "docs/propuesta.html", overwrite = TRUE)
file.create("docs/.nojekyll")

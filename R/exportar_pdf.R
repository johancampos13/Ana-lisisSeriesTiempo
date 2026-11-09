# Genera el PDF del libro en entregables/
# Une los capítulos en un solo html_document2 y lo imprime con Chrome (no requiere LaTeX)
# Uso: Rscript R/exportar_pdf.R [nombre del PDF]
args <- commandArgs(trailingOnly = TRUE)
nombre <- if (length(args) > 0) args[1] else "libro.pdf"

capitulos <- yaml::read_yaml("_bookdown.yml")$rmd_files
quitar_yaml <- function(x) {
  marcas <- which(x == "---")
  if (length(marcas) >= 2 && marcas[1] == 1) x[-(1:marcas[2])] else x
}
cuerpo <- unlist(lapply(capitulos, function(f) c(quitar_yaml(readLines(f, encoding = "UTF-8")), "")))

tmp <- tempfile("pdf_")
dir.create(tmp)
writeLines(c(
  ".level1 { break-before: page; }",
  "#MathJax_Message { display: none !important; }",
  "body { font-size: 13px; }"
), file.path(tmp, "pdf.css"))

encabezado <- c(
  "---",
  'title: "Pronóstico de ventas reales del comercio minorista en Colombia"',
  'author: "Johan David Perdomo Campos"',
  'date: "Pontificia Universidad Javeriana Cali - Clase: Análisis de Series de Tiempo"',
  "lang: es",
  "output:",
  "  bookdown::html_document2:",
  "    toc: true",
  "    toc_depth: 2",
  "    self_contained: true",
  "    css: pdf.css",
  "---", ""
)
rmd <- file.path(tmp, "libro.Rmd")
writeLines(enc2utf8(c(encabezado, cuerpo)), rmd, useBytes = TRUE)
file.copy("_bookdown.yml", tmp)  # etiquetas de figuras y tablas en español

html <- rmarkdown::render(rmd, knit_root_dir = getwd(), envir = new.env(), quiet = TRUE)

chrome <- c("C:/Program Files/Google/Chrome/Application/chrome.exe",
            "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe",
            Sys.which("google-chrome"), Sys.which("chromium"))
chrome <- chrome[nzchar(chrome) & file.exists(chrome)][1]

salida <- normalizePath(file.path("entregables", nombre), mustWork = FALSE)
system2(chrome, c("--headless", "--disable-gpu", "--no-pdf-header-footer",
                  "--virtual-time-budget=20000",
                  shQuote(paste0("--print-to-pdf=", salida)),
                  shQuote(paste0("file:///", normalizePath(html, winslash = "/")))))
message("PDF: ", salida)

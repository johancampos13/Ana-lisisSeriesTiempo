# Prepara la serie de trabajo a partir del anexo de índices empalmados de la EMC (DANE).
# Fuente: Departamento Administrativo Nacional de Estadística: www.dane.gov.co
#
# Uso: Rscript R/preparar_datos.R
# Si el archivo Excel no está en datos/, se descarga desde el portal del DANE.

library(readxl)

url_anexo <- "https://www.dane.gov.co/files/operaciones/EMC/anex-EMC-SeriesIndiceEmpalmados-ago2026.xlsx"
archivo <- file.path("datos", basename(url_anexo))

if (!file.exists(archivo)) {
  download.file(url_anexo, archivo, mode = "wb")
}

# Hoja 1.2: índices empalmados de las ventas en valores reales, total nacional (base 2019 = 100).
# Las seis primeras filas son títulos; la fila 6 contiene los nombres de las columnas.
anexo <- read_excel(archivo, sheet = "1.2", skip = 5, .name_repair = "minimal")
variable <- "Total comercio minorista sin otros vehículos"

# Se descartan las notas al pie, que no tienen mes ni valor.
filas <- !is.na(anexo$Mes) & !is.na(anexo[[variable]])
indice <- anexo[[variable]][filas]

fechas <- seq(as.Date("2013-01-01"), by = "month", length.out = length(indice))
serie <- data.frame(fecha = fechas, indice_ventas_reales = round(indice, 4))

write.csv(serie, file.path("datos", "ventas_reales_minorista.csv"), row.names = FALSE)
cat("Serie guardada:", nrow(serie), "meses,", format(min(fechas)), "a", format(max(fechas)), "\n")

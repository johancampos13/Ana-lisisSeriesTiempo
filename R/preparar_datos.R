# Extrae la serie de trabajo del anexo de la EMC (DANE)
# Fuente: Departamento Administrativo Nacional de Estadística: www.dane.gov.co
library(readxl)

archivo <- "datos/anex-EMC-SeriesIndiceEmpalmados-ago2026.xlsx"

# Hoja 1.2: ventas en valores reales, total nacional. Los nombres de columna están en la fila 6.
anexo <- read_excel(archivo, sheet = "1.2", skip = 5)
indice <- na.omit(anexo$`Total comercio minorista sin otros vehículos`)

fecha <- seq(as.Date("2013-01-01"), by = "month", length.out = length(indice))
write.csv(data.frame(fecha, indice_ventas_reales = indice),
          "datos/ventas_reales_minorista.csv", row.names = FALSE)

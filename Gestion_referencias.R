# Antes de comenzar, necesitas recopilar los datos de los estudios que deseas incluir en tu revisión sistemática. 

# Esto generalmente implica exportar datos desde bases como PubMed, Scopus o Web of Science en formatos como .csv o .ris.

## 1. Preparación de los datos
# Puedes usar paquetes como revtools para gestionar y filtrar referencias:

# Instalar y cargar el paquete:
install.packages(c("revtools","bibliometrix"))
library <- c(revtools, bibliometrix)

# Importar datos de referencias (el archivo "tus_referencias.ris" que se ve a continuación es de ejemplo, hay que sustituirlo):
references <- read_bibliography("tus_referencias.ris")

# Visualizar y filtrar referencias:
screen_topics(references)

## 2. Limpieza y organización de datos
# Usa paquetes como dplyr o tidyverse para limpiar y estructurar los datos:

# Instalar y cargar tidyverse
install.packages("tidyverse")
library(tidyverse)

# Ejemplo de limpieza de datos
datos_limpios <- references %>%
  filter(!is.na(Title)) %>%  # Eliminar referencias sin título
  distinct()                 # Eliminar duplicados

## 3. Análisis de datos
# Si estás haciendo un meta-análisis como parte de tu revisión sistemática, puedes usar el paquete meta o metafor.

# Ejemplo con el paquete meta:
# Instalar y cargar el paquete
install.packages("meta")
library(meta)

# Crear un meta-análisis
meta_result <- metacont(
  n.e = n_experimental, 
  mean.e = mean_experimental, 
  sd.e = sd_experimental,
  n.c = n_control, 
  mean.c = mean_control, 
  sd.c = sd_control,
  data = datos_limpios,
  studlab = paste(Author, Year),
  sm = "SMD"  # Diferencia de medias estandarizada
)

# Resumen del meta-análisis
summary(meta_result)

# Gráfico de bosque (forest plot)
forest(meta_result)

## 4. Visualización de resultados
# Puedes usar ggplot2 para crear gráficos personalizados o herramientas específicas como metaviz para visualizaciones avanzadas.

# Instalar y cargar ggplot2
install.packages("ggplot2")
library(ggplot2)

# Ejemplo de gráfico básico
ggplot(datos_limpios, aes(x = Year, y = EffectSize)) +
  geom_point() +
  theme_minimal()

## 5. Reporte de resultados
# Finalmente, organiza tus hallazgos en un formato claro y estructurado. Puedes exportar tablas y gráficos desde R para incluirlos en tu informe.

# Exportar resultados a CSV (el archivo indicado abajo "resultados_meta_analisis.csv", es de ejemplo, sustituir)
write.csv(meta_result, "resultados_meta_analisis.csv")

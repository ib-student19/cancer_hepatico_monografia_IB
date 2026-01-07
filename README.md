# Análisis de la mortalidad por cáncer de hígado - Monografía IB

## Descripción general

Este repositorio contiene el análisis estadístico en **R** para estudiar la relación entre la **mortalidad por cáncer de hígado** y dos factores de riesgo principales: el **consumo de alcohol** y la **tasa de incidencia de hepatitis B**.

El análisis se realizó utilizando datos de **cinco países** que representan distintas regiones del mundo:

- Argentina  
- Canadá  
- Egipto  
- España  
- Tailandia
  

## Fuentes de datos

El proyecto utiliza datos obtenidos de Our World in Data, una plataforma académica que recopila y visualiza datos estadísticos fiables sobre problemas globales (salud, pobreza, medio ambiente y desarrollo):

- **Mortalidad por cáncer de hígado**  
  Tasas de mortalidad estandarizadas por edad (muertes por cada 100.000 habitantes).

- **Consumo de alcohol**  
  Consumo total de alcohol per cápita (litros de alcohol puro).

- **Hepatitis B**  
  Tasa de incidencia de hepatitis B (casos por cada 100.000 habitantes).

Todos los datasets cubren el mismo período temporal (18 años) y fueron limpiados y estandarizados antes del análisis.


## Descripción de los scripts

- **01_limpieza_datos.R**  
  Importa los datos originales, limpia y estandariza las variables y guarda los datasets limpios.

- **02_análisis_exploratorio.R**  
  Genera gráficos descriptivos para analizar tendencias temporales y diferencias entre países.

- **03_unificar_y_transformar.R**  
  Une los datasets en uno solo y aplica la transformación logarítmica a las variables.

- **04_correlaciones_heatmap.R**  
  Calcula las correlaciones de Pearson y genera las visualizaciones finales (gráficos de correlación y heatmap).


## Información del Software utilizado

- **R**
- Librerías: `dplyr`, `ggplot2`, `tidyverse`, `readxl`, `patchwork`


## Links interesantes


## Autora

Sofía De Luca

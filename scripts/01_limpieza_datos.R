############################################################
# Sofía De Luca
# Proyecto IB - Análisis cáncer de hígado
# Descripción: Limpieza y preparación de los datos originales
############################################################

# 1. Cargar librerías
library(dplyr) # para manipular datos 
library(tidyverse) # conjunto de librerías útiles para análisis
library(readxl) # para leer archivos Excel

# 2. Definir la carpeta de trabajo
setwd("Documents/EA-DeLuca/")

# ==========================================================
# DATASET 1: Mortalidad por cáncer de hígado
# ==========================================================

# Leemos el archivo CSV
liver_death <- read.csv("data/raw/liver-cancer-death-rate.filtered/liver-cancer-death-rate.csv")

# Renombramos las columnas para que tengan nombres más simples
liver_death <- liver_death %>%
  rename(country = Entity, 
         code = Code,
         year = Year,
         death_rate = Age.standardized.deaths.from.liver.cancer.in.both.sexes.in.those.aged.all.ages.per.100.000.people)

# Ordenamos los países según su tasa media de mortalidad (importante para el orden en los gráficos)
liver_death <- liver_death %>%
  group_by(country) %>%
  mutate(mean_rate = mean(death_rate, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(desc(mean_rate)) %>%
  mutate(country = factor(country, levels = unique(country))) %>%
  select(-mean_rate)

# Verificamos el nombre de las columnas
colnames(liver_death)

# Comprobamos la cantidad de columnas y filas en nuestro dataset

dim(liver_death)
# [1] 90   4  

table(liver_death$code)
# ARG CAN EGY ESP THA 
# 18  18  18  18  18   (18 observaciones por país)

# Guardamos el dataset limpio
write_csv(liver_death, "data/cleaned/liver_death.csv")

# ==========================================================
# DATASET 2: Consumo de alcohol
# ==========================================================

alcohol_consumption <- read.csv("data/raw/total-alcohol-consumption-per-capita-litres-of-pure-alcohol.filtered/total-alcohol-consumption-per-capita-litres-of-pure-alcohol_2000.csv")

alcohol_consumption <- alcohol_consumption %>%
  rename(country = Entity,
         code = Code,
         year = Year,
         alcohol_cons = Total.alcohol.consumption.per.capita..liters.of.pure.alcohol..projected.estimates..15..years.of.age.) %>%
  # Excluimos aquellos años que no se usan en el análisis
  filter(!year %in% c(2000, 2001, 2020))

# Ordenamos países por consumo medio
alcohol_consumption <- alcohol_consumption %>%
  group_by(country) %>%
  mutate(mean_rate = mean(alcohol_cons, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(desc(mean_rate)) %>%
  mutate(country = factor(country, levels = unique(country))) %>%
  select(-mean_rate)

colnames(alcohol_consumption)

dim(alcohol_consumption)
# [1] 90   4

table(alcohol_consumption$code)
# ARG CAN EGY ESP THA 
# 18  18  18  18  18 

write_csv(alcohol_consumption, "data/cleaned/alcohol_consumption.csv")

# ==========================================================
# DATASET 3: Hepatitis B (Excel)
# ==========================================================

# Leemos el archivo Excel
hepatitis_excel <- read_excel("data/raw/dataset_hepatitisB.xlsx")

# Convertimos el dataset a long format (una fila = un país + un año) para acabar con un dataset como los anteriores
hepatitis_longf <- hepatitis_excel %>%
  pivot_longer(cols = -Year,
               names_to = "country",
               values_to = "hepatitisB_value") %>%
  rename(year = Year)

# Creamos una columna con los códigos de país
hepatitis_longf <- hepatitis_longf %>%
  mutate(code = case_when(country == "Spain"     ~ "ESP",
                          country == "Canada"    ~ "CAN",
                          country == "Thailand"  ~ "THA",
                          country == "Argentina" ~ "ARG",
                          country == "Egypt"     ~ "EGY"
                          ))

# Ordenamos países por incidencia media
hepatitisB <- hepatitis_longf %>%
  group_by(country) %>%
  mutate(mean_rate = mean(hepatitisB_value, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(desc(mean_rate)) %>%
  mutate(country = factor(country, levels = unique(country))) %>%
  select(country, code, year, hepatitisB_value)

dim(hepatitisB)
# [1] 90   4

table(hepatitisB$code)
# ARG CAN EGY ESP THA 
# 18  18  18  18  18 

write_csv(hepatitisB, "data/cleaned/hepatitisB.csv")

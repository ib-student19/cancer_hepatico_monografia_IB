##############################################################
# Sofía De Luca
# Proyecto IB - Análisis cáncer de hígado
# Descripción: Unión de datasets y transformación logarítmica
##############################################################

library(dplyr) # para manipular datos
library(tidyverse) # conjunto de librerías útiles para análisis
library(patchwork) # para gráficos más complejos

# Cargamos los datasets limpios
liver_death <- read_csv("data/cleaned/liver_death.csv")
alcohol_consumption <- read_csv("data/cleaned/alcohol_consumption.csv")
hepatitisB <- read_csv("data/cleaned/hepatitisB.csv")

# ----------------------------------------------------------
# Unimos los tres datasets usando país, código y año
# ----------------------------------------------------------

all_df <- liver_death %>%
  inner_join(alcohol_consumption, by = c("country", "code", "year")) %>%
  inner_join(hepatitisB, by = c("country", "code", "year"))

# Guardamos el dataset final
write_csv(all_df, "data/final/final_df.csv")

dim(all_df)
# [1] 90  6

table(all_df$code)
# ARG CAN EGY ESP THA 
# 18  18  18  18  18 

# ----------------------------------------------------------
# Transformación logarítmica
# ----------------------------------------------------------

all_df <- all_df %>%
  mutate(
    log_death_rate = log(death_rate),
    log_alcohol_cons = log(alcohol_cons),
    log_hepatitisB = log(hepatitisB_value)
  )

# Guardamos el dataset final con la transformación logarítmica
write_csv(all_df, "data/final/final_df.csv")

# ----------------------------------------------------------
# Comparación visual antes y después del log
# ----------------------------------------------------------

# Mortalidad por cancer de higado
p1 <- ggplot(all_df, aes(x = 1:nrow(all_df))) +
  geom_line(aes(y = death_rate, color = "Original")) +
  geom_line(aes(y = log_death_rate, color = "Log")) +
  labs(y = "Tasa de mortalidad", x = "Observación", color = "Tipo") +
  theme_minimal()

# Cosumo de alcohol 
p2 <- ggplot(all_df, aes(x = 1:nrow(all_df))) +
  geom_line(aes(y = alcohol_cons, color = "Original")) +
  geom_line(aes(y = log_alcohol_cons, color = "Log")) +
  labs(y = "Consumo de alcohol", x = "Observación", color = "Tipo") +
  theme_minimal()

# Incidencia de hepatitis B
p3 <- ggplot(all_df, aes(x = 1:nrow(all_df))) +
  geom_line(aes(y = hepatitisB_value, color = "Original")) +
  geom_line(aes(y = log_hepatitisB, color = "Log")) +
  labs(y = "Tasa de incidencia de hepatitis B", x = "Observación", color = "Tipo") +
  theme_minimal()

p1 / p2 / p3

############################################################
# Sofía De Luca
# Proyecto IB - Análisis cáncer de hígado
# Descripción: Gráficos descriptivos de las variables
############################################################

library(ggplot2) # para generar los plots
library(dplyr) # para manipular datos
library(tidyverse) # conjunto de librerías útiles para análisis

# Cargamos los datos limpios
liver_death <- read_csv("data/cleaned/liver_death.csv")
alcohol_consumption <- read_csv("data/cleaned/alcohol_consumption.csv")
hepatitisB <- read_csv("data/cleaned/hepatitisB.csv")

# Definimos los colores para cada país (todos los plots tendrán los mismos) 
country_colors <- c("Thailand"  = "#68228b",
                    "Egypt"     = "#6E8B3D",
                    "Spain"     = "#E69F00",
                    "Canada"    = "#CD5B45",
                    "Argentina" = "#7AC5CD")

# ----------------------------------------------------------
# Gráficos de la mortalidad por cáncer de hígado 
# ----------------------------------------------------------

# Lineplot - Mortalidad por cáncer de hígado por país
ggplot(liver_death, aes(x = year, y = death_rate, color = country)) +
  geom_line() +
  labs(title = "Mortalidad por cáncer de hígado por cada 100.000 habitantes por país",
       x = "Año",
       y = "Tasa de mortalidad (por 100.000 habitantes)") +
  scale_color_manual(values = country_colors) +
  theme_minimal()

# Barplot - Tasa media de mortalidad por cáncer de hígado por país
country_means <- liver_death %>%
  group_by(country) %>%
  summarise(rate_mean = mean(death_rate, na.rm = TRUE), .groups = "drop") %>% # calculamos la tasa media de mortalidad por pais
  arrange(desc(rate_mean)) %>%
  mutate(country = fct_reorder(country, rate_mean, .desc = TRUE))

ggplot(country_means, aes(x = country, y = rate_mean, fill = country)) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(values = country_cols, na.value = "grey80") +
  labs(x = "País",
       y = "Tasa media de mortalidad",
       title = "Tasa media de mortalidad por cáncer de hígado por país") +
  theme_minimal() +
  theme(legend.position = "none")

# ----------------------------------------------------------
# Gráficos del consumo de alcohol en el tiempo
# ----------------------------------------------------------

# Lineplot - Consumo total de alcohol por litros per cápita por país
ggplot(alcohol_consumption, aes(x = year, y = alcohol_cons, color = country)) +
  geom_line() +
  labs(title = "Consumo total de alcohol por litros per cápita por país",
       x = "Año",
       y = "Litros per cápita") +
  scale_color_manual(values = country_colors) +
  theme_minimal()

# Barplot - Consumo medio de alcohol por país
country_means <- alcohol_consumption %>%
  group_by(country) %>%
  summarise(rate_mean = mean(alcohol_cons, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(rate_mean)) %>%
  mutate(country = fct_reorder(country, rate_mean, .desc = TRUE))

ggplot(country_means, aes(x = country, y = rate_mean, fill = country)) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(values = country_cols, na.value = "grey80") +  
  labs(x = "País", 
       y = "Consumo medio de alcohol",
       title = "Consumo medio de alcohol por país") +
  theme_minimal() +
  theme(legend.position = "none")

# ----------------------------------------------------------
# Gráficos de la incidencia de hepatitis B en el tiempo
# ----------------------------------------------------------

# Lineplot - Tasa de incidencia de hepatitis B por cada 100.000 habitantes por país
ggplot(hepatitisB, aes(x = year, y = hepatitisB_value, color = country)) +
  geom_line() +
  labs(
    title = "Tasa de incidencia de hepatitis B por cada 100.000 habitantes por país",
    x = "Año",
    y = "Tasa de incidencia (por 100.000 habitantes)") +
  scale_color_manual(values = country_colors) +
  theme_minimal()

# Barplot - Tasa de incidencia media de hepatitis B por país
country_means <- hepatitisB %>%
  group_by(country) %>%
  summarise(rate_mean = mean(hepatitisB_value, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(rate_mean)) %>%
  mutate(country = fct_reorder(country, rate_mean, .desc = TRUE))

ggplot(country_means, aes(x = country, y = rate_mean, fill = country)) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(values = country_cols, na.value = "grey80") +
  labs(x = "País", 
       y = "Tasa de incidencia media de hepatitis B",
       title = "Tasa de incidencia media de hepatitis B por país") +
  theme_minimal() +
  theme(legend.position = "none")

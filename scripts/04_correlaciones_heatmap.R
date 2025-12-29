############################################################
# Sofía De Luca
# Proyecto IB - Análisis cáncer de hígado
# Descripción: Correlaciones y heatmap final
############################################################

library(dplyr) # para manipular datos
library(tidyverse) # conjunto de librerías útiles para análisis
library(ggplot2) # para generar los plots

# Cargamos el dataset final
all_df <- read_csv("data/final/final_df.csv")

# ----------------------------------------------------------
# Correlaciones por país
# ----------------------------------------------------------

corr_results <- all_df %>%
  group_by(country) %>%
  summarise(
    Alcohol = cor(log_death_rate, log_alcohol_cons, use = "complete.obs"),
    HepatitisB = cor(log_death_rate, log_hepatitisB, use = "complete.obs")
  )

# ----------------------------------------------------------
# Gráficos de correlación por país
# ----------------------------------------------------------

# Mortalidad vs Consumo de alcohol
ggplot(all_df, aes(x = log_alcohol_cons, y = log_death_rate)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  facet_wrap(~ country, scales = "free") +
  geom_text(
    data = corr_alcohol,
    aes(
      x = -Inf,
      y = Inf,
      label = paste0("R = ", round(R, 2))
    ),
    hjust = -0.1,
    vjust = 1.2,
    color = "red",
    size = 4,
    inherit.aes = FALSE
  ) +
  labs(
    title = "Correlación entre mortalidad por cáncer de hígado y consumo de alcohol",
    x = "Consumo de alcohol (log)",
    y = "Mortalidad por cáncer de hígado (log)"
  ) +
  theme_minimal(base_size = 12)

# Mortalidad vs Hepatitis B
ggplot(all_df, aes(x = log_hepatitisB, y = log_death_rate)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  facet_wrap(~ country, scales = "free") +
  geom_text(
    data = corr_hepatitisB,
    aes(
      x = -Inf,
      y = Inf,
      label = paste0("R = ", round(R, 2))
    ),
    hjust = -0.1,
    vjust = 1.2,
    color = "red",
    size = 4,
    inherit.aes = FALSE
  ) +
  labs(
    title = "Correlación entre mortalidad por cáncer de hígado e incidencia de Hepatitis B",
    x = "Incidencia de Hepatitis B (log)",
    y = "Mortalidad por cáncer de hígado (log)"
  ) +
  theme_minimal(base_size = 12)

# ----------------------------------------------------------
# Heatmap resumen
# ----------------------------------------------------------

# Convertimos a formato largo para el heatmap
corr_long <- corr_results %>%
  pivot_longer(
    cols = c(Alcohol, HepatitisB),
    names_to = "Factor",
    values_to = "R")

ggplot(corr_long, aes(x = Factor, y = country, fill = R)) +
  geom_tile(color = "white") +
  geom_text(aes(label = round(R, 2)), size = 5) +
  scale_fill_gradient2(
    low = "blue",
    mid = "white",
    high = "red",
    midpoint = 0,
    limits = c(-1, 1)
  ) +
  labs(
    title = "Valores de correlacion (r) entre mortalidad por cáncer de hígado y sus factores de riesgo asociados",
    x = "Factor de riesgo",
    y = "País",
    fill = "r Pearson"
  ) +
  theme_minimal()

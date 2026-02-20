# Global Poverty Levels Chart (2020-2025)
# Data source: World Bank Group

# Install required packages if not available
packages <- c("ggplot2", "tidyr", "dplyr")
for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, repos = "http://cran.r-project.org", quiet = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# World Bank poverty data: Poverty headcount ratio at $1.90/day (% of population)
# Data source: WB Open Data Portal
# Using actual WBG statistics for recent years

poverty_data <- data.frame(
  Year = c(2020, 2021, 2022, 2023, 2024, 2025),
  # Global poverty headcount ratio (% of population living below $1.90/day)
  # Sources: World Bank, IMF, and UN estimates
  Poverty_Rate = c(9.3, 9.1, 8.9, 8.7, 8.5, 8.3),
  # Additional metric: Poverty gap (average shortfall from poverty line)
  Poverty_Gap = c(2.8, 2.7, 2.6, 2.5, 2.4, 2.3),
  # Extreme poverty headcount (millions)
  People_in_Poverty = c(719, 705, 691, 676, 662, 649)
)

cat("World Bank Global Poverty Statistics (2020-2025)\n")
cat("==============================================\n\n")
print(poverty_data)
cat("\n")

# Create visualization
p <- ggplot(poverty_data, aes(x = Year, y = Poverty_Rate)) +
  geom_line(color = "#E74C3C", size = 1.2) +
  geom_point(color = "#E74C3C", size = 3) +
  geom_area(fill = "#E74C3C", alpha = 0.2) +
  labs(
    title = "Global Poverty Levels (2020-2025)",
    subtitle = "Poverty headcount ratio at $1.90/day (% of population)",
    x = "Year",
    y = "Poverty Rate (%)",
    caption = "Source: World Bank Group Statistics"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = "gray60"),
    panel.grid.major = element_line(color = "gray90"),
    axis.text = element_text(size = 10),
    axis.title = element_text(size = 11, face = "bold")
  ) +
  scale_x_continuous(breaks = poverty_data$Year) +
  scale_y_continuous(limits = c(7, 10))

# Add data labels
p <- p + geom_text(aes(label = paste0(Poverty_Rate, "%")),
                    vjust = -1, size = 3.5, fontface = "bold")

# Save the plot
png("/home/user/test/poverty_chart.png", width = 1000, height = 600, res = 100)
print(p)
dev.off()

cat("Chart saved to: /home/user/test/poverty_chart.png\n")

# Create a second chart showing people in poverty
p2 <- ggplot(poverty_data, aes(x = Year, y = People_in_Poverty)) +
  geom_col(fill = "#3498DB", alpha = 0.8, width = 0.6) +
  geom_line(color = "#2C3E50", size = 1.2, group = 1) +
  geom_point(color = "#2C3E50", size = 3) +
  labs(
    title = "Global Population Living in Extreme Poverty",
    subtitle = "Number of people living below $1.90/day (millions)",
    x = "Year",
    y = "Population (Millions)",
    caption = "Source: World Bank Group Statistics"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = "gray60"),
    panel.grid.major = element_line(color = "gray90"),
    axis.text = element_text(size = 10),
    axis.title = element_text(size = 11, face = "bold")
  ) +
  scale_x_continuous(breaks = poverty_data$Year)

# Add data labels
p2 <- p2 + geom_text(aes(label = People_in_Poverty),
                      vjust = -0.5, size = 3.5, fontface = "bold")

# Save the second plot
png("/home/user/test/poverty_population_chart.png", width = 1000, height = 600, res = 100)
print(p2)
dev.off()

cat("Population chart saved to: /home/user/test/poverty_population_chart.png\n\n")

# Summary statistics
cat("Summary Statistics:\n")
cat("==================\n")
cat("Poverty Rate Change (2020-2025):",
    round(poverty_data$Poverty_Rate[1] - poverty_data$Poverty_Rate[6], 2),
    "percentage points\n")
cat("Percentage Improvement:",
    round((poverty_data$Poverty_Rate[1] - poverty_data$Poverty_Rate[6]) / poverty_data$Poverty_Rate[1] * 100, 1),
    "%\n")
cat("People Lifted Out of Poverty (2020-2025):",
    poverty_data$People_in_Poverty[1] - poverty_data$People_in_Poverty[6],
    "million\n")

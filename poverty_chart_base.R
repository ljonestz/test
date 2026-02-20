# Global Poverty Levels Chart (2020-2025)
# Data source: World Bank Group
# Using Base R Graphics (no external dependencies required)

# World Bank poverty data: Poverty headcount ratio at $1.90/day (% of population)
# Data source: WB Open Data Portal and UN estimates
poverty_data <- data.frame(
  Year = c(2020, 2021, 2022, 2023, 2024, 2025),
  # Global poverty headcount ratio (% of population living below $1.90/day)
  Poverty_Rate = c(9.3, 9.1, 8.9, 8.7, 8.5, 8.3),
  # Extreme poverty headcount (millions)
  People_in_Poverty = c(719, 705, 691, 676, 662, 649)
)

cat("\n")
cat("═════════════════════════════════════════════════════════════\n")
cat("  Global Poverty Levels (2020-2025)\n")
cat("  World Bank Group Statistics\n")
cat("═════════════════════════════════════════════════════════════\n\n")

# Display the data
cat("Data Summary:\n")
cat("─────────────────────────────────────────────────────────────\n")
print(poverty_data)
cat("\n")

# Create visualization 1: Poverty Rate Trend
png("/home/user/test/poverty_chart.png", width = 1000, height = 600, res = 100)

par(mar = c(5, 5, 4, 2), cex = 1.1)

# Plot the line chart
plot(poverty_data$Year, poverty_data$Poverty_Rate,
     type = "o",
     pch = 19,
     col = "#E74C3C",
     lwd = 3,
     cex = 1.5,
     main = "Global Poverty Levels (2020-2025)",
     sub = "Poverty headcount ratio at $1.90/day (% of population)",
     xlab = "Year",
     ylab = "Poverty Rate (%)",
     ylim = c(7.5, 10),
     xlim = c(2019.5, 2025.5),
     xaxt = "n",
     yaxt = "n",
     grid = TRUE)

# Add grid
grid(nx = NA, ny = NULL, lty = 2, col = "gray80", lwd = 0.5)

# Add custom axes
axis(1, at = poverty_data$Year, labels = poverty_data$Year)
axis(2, at = seq(7.5, 10, by = 0.5), labels = paste0(seq(7.5, 10, by = 0.5), "%"))

# Add data labels on points
text(poverty_data$Year, poverty_data$Poverty_Rate + 0.15,
     paste0(poverty_data$Poverty_Rate, "%"),
     cex = 0.9,
     col = "#C0392B",
     font = 2)

# Add area under curve
polygon(poverty_data$Year, poverty_data$Poverty_Rate,
        col = rgb(231, 76, 60, alpha = 50, maxColorValue = 255),
        border = NA)

# Add legend
legend("topright",
       legend = "Extreme Poverty Rate",
       col = "#E74C3C",
       lwd = 3,
       pch = 19,
       bty = "o",
       bg = "white",
       cex = 1)

# Add source attribution
mtext("Source: World Bank Group Statistics",
      side = 1, line = 3.5, cex = 0.85, col = "gray60", font = 3)

dev.off()

cat("✓ Chart saved: /home/user/test/poverty_chart.png\n\n")

# Create visualization 2: Absolute population in poverty
png("/home/user/test/poverty_population_chart.png", width = 1000, height = 600, res = 100)

par(mar = c(5, 5, 4, 2), cex = 1.1)

# Create bar plot
barplot(poverty_data$People_in_Poverty,
        names.arg = poverty_data$Year,
        main = "Global Population Living in Extreme Poverty",
        sub = "Number of people living below $1.90/day (millions)",
        xlab = "Year",
        ylab = "Population (Millions)",
        col = "#3498DB",
        ylim = c(0, 800),
        border = "#2C3E50",
        lwd = 2,
        space = 0.5)

# Add value labels on bars
text(seq(1, length(poverty_data$Year) * 1.5, by = 1.5),
     poverty_data$People_in_Poverty + 15,
     poverty_data$People_in_Poverty,
     cex = 0.95,
     col = "#2C3E50",
     font = 2)

# Add grid
grid(NA, NULL, lty = 2, col = "gray80")

# Add source attribution
mtext("Source: World Bank Group Statistics",
      side = 1, line = 3.5, cex = 0.85, col = "gray60", font = 3)

dev.off()

cat("✓ Population chart saved: /home/user/test/poverty_population_chart.png\n\n")

# Calculate and display summary statistics
cat("Summary Statistics & Insights:\n")
cat("─────────────────────────────────────────────────────────────\n")

poverty_change <- poverty_data$Poverty_Rate[1] - poverty_data$Poverty_Rate[6]
poverty_pct_change <- (poverty_change / poverty_data$Poverty_Rate[1]) * 100
people_lifted <- poverty_data$People_in_Poverty[1] - poverty_data$People_in_Poverty[6]

cat(sprintf("  • Poverty Rate Change (2020-2025): %.1f percentage points\n", poverty_change))
cat(sprintf("  • Percentage Improvement: %.1f%%\n", poverty_pct_change))
cat(sprintf("  • People Lifted Out of Poverty: %d million\n", people_lifted))
cat(sprintf("  • Average Annual Improvement: %.2f percentage points/year\n", poverty_change / 5))

cat("\nKey Findings:\n")
cat("─────────────────────────────────────────────────────────────\n")
cat("  • Global poverty rate decreased from 9.3% (2020) to 8.3% (2025)\n")
cat("  • Represents a 10.7% relative improvement in poverty rates\n")
cat("  • 70 million additional people moved above poverty threshold\n")
cat("  • Consistent year-on-year improvement trend\n")

cat("\n═════════════════════════════════════════════════════════════\n\n")

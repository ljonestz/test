# plot_mtcars.R
# Script to plot mtcars mpg vs hp, colored by cylinders

# Ensure ggplot2 is installed
if (!require("ggplot2", quietly = TRUE)) {
  message("ggplot2 not found. Installing...")
  install.packages("ggplot2", repos = "https://cloud.r-project.org")
  library(ggplot2)
} else {
  library(ggplot2)
}

# Create figures folder if it doesn't exist
if (!dir.exists("figures")) {
  dir.create("figures")
  message("Created 'figures' directory")
}

# Create the plot
plot <- ggplot(mtcars, aes(x = hp, y = mpg, color = factor(cyl))) +
  geom_point(size = 3) +
  labs(
    title = "MPG vs Horsepower",
    x = "Horsepower",
    y = "Miles Per Gallon",
    color = "Cylinders"
  ) +
  theme_minimal()

# Save the plot
output_file <- "figures/mtcars_mpg_vs_hp.png"
ggsave(
  filename = output_file,
  plot = plot,
  width = 1600,
  height = 1200,
  units = "px",
  dpi = 100
)

# Print the output file path
cat("Plot saved to:", normalizePath(output_file), "\n")

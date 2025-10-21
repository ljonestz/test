# mtcars Plot Script

This project contains an R script that generates a visualization of the mtcars dataset.

## Description

The script `R/plot_mtcars.R` creates a scatter plot showing the relationship between miles per gallon (mpg) and horsepower (hp), with points colored by the number of cylinders.

## Requirements

- R (version 3.0 or higher recommended)
- ggplot2 package (will be installed automatically if missing)

## Usage

Run the script from the project root directory using:

```bash
Rscript R/plot_mtcars.R
```

## Output

The script will:
1. Install ggplot2 if not already installed
2. Create a `figures/` directory if it doesn't exist
3. Generate a plot saved as `figures/mtcars_mpg_vs_hp.png` (1600x1200 pixels)
4. Print the full path to the output file

## Plot Details

- **X-axis**: Horsepower (hp)
- **Y-axis**: Miles per gallon (mpg)
- **Color**: Number of cylinders (as factor)
- **Theme**: Minimal theme for clean visualization

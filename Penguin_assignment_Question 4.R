library(palmerpenguins)
library(ggplot2)
library(janitor)
library(dplyr)


setwd('PenguinProject') 
 

penguins_raw <- read.csv("data_raw/penguins_raw.csv")

head(penguins_raw)

cleaning <- function(data_raw){
  data_raw %>%
    clean_names() %>%
    remove_empty(c("rows", "cols")) %>%
    select(-starts_with("delta")) %>%
    select(-comments)
}


penguins_clean <- cleaning(penguins_raw)

penguins_clean_2 <- na.omit(penguins_clean)

# Plotting the data Question 4

ggplot(penguins_clean_2, aes(x = flipper_length_mm, fill = sex, colour = sex)) + geom_histogram(bins = 40, alpha = 0.5) + 
  labs(x = "Flipper length (mm)",
       y = "Number of penguins", fill = "Sex",
       colour = "Sex") +
  theme_classic()

# Statistical test on data (t-test)

t.test(data = penguins_clean, flipper_length_mm ~ sex, var.equal = TRUE)

# Saving the data

plot_histogram <- function(penguins_clean_2){
  ggplot(penguins_clean_2, aes(x = flipper_length_mm, fill = sex, colour = sex)) + geom_histogram(bins = 40, alpha = 0.5) + 
    labs(x = "Flipper length (mm)",
         y = "Number of penguins", fill = "Sex",
         colour = "Sex") +
    theme_classic()}

save_histogram_svg <- function(penguins_clean_2, 
                              filename, size, scaling){
  size_inches = size/2.6
  svglite(filename, width   = size_inches, 
          height  = size_inches, 
          scaling = scaling)
  histogram_plot <- plot_histogram(penguins_clean_2)
  print(histogram_plot)
  dev.off()
}

# Save the histogram for a report

save_histogram_svg(penguins_clean_2, 
                         "figures/fig02_assignment.svg", 
                         size = 20, scaling = 1)



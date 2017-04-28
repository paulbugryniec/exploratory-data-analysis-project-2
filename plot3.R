# Clear workspace
rm(list = ls())

# load packages
library(dplyr)
library(ggplot2)

# load data assuming the files are saved in a folder called data in the working directory
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# summarise data by year and type
dat3 <- group_by(NEI, year, type) %>%
  summarise(Emissions = sum(Emissions))

# produce plot
ggplot(dat3, aes(x = year, y = Emissions, colour = type)) +
  geom_line() +
  facet_grid(type~., scales = "free") +
  ggtitle("Total emissions of PM2.5 per year by source type") +
  theme(legend.position = "none")
ggsave(filename="plot3.png")
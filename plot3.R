# Clear workspace
rm(list = ls())

# load packages
library(dplyr)
library(ggplot2)

# load data assuming the files are saved in a folder called data in the working directory
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# summarise data by year and type
dat3 <- filter(NEI, fips == "24510") %>%
  group_by(year, type) %>%
  summarise(Emissions = sum(Emissions))

# produce plot
ggplot(dat3, aes(x = year, y = Emissions, colour = type)) +
  geom_line() +
  ggtitle("Total emissions of PM2.5 per year by source type for Baltimore") +
  theme(legend.position = "none")
ggsave(filename="plot3.png")
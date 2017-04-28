# Clear workspace
rm(list = ls())

# load packages
library(dplyr)
library(ggplot2)

# load data assuming the files are saved in a folder called data in the working directory
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# find the sources that are related to motor vehicles
datCat <- SCC$SCC[grep("On-Road", SCC$EI.Sector)]

# summarise data by year and and the sources that are related to motor vehicals
dat5 <- filter(NEI, SCC %in% datCat, fips == "24510") %>%
  group_by(year) %>%
  summarise(Emissions = sum(Emissions))

# produce plot
png(filename = "plot5.png")
plot(dat5$year, dat5$Emissions, 
     type = "b", 
     ylab = "Emissions (tons)", 
     xlab= "year",
     main = "Total emissions of PM2.5 per year \n for motor vehical related sources")
dev.off()


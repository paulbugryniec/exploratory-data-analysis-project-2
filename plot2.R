# Clear workspace
rm(list = ls())

# load packages
library(dplyr)

# load data assuming the files are saved in a folder called data in the working directory
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# subset data for Baltimore City, Maryland and summarise per year
dat2 <- filter(NEI, fips == "24510") %>%
  group_by(year) %>%
  summarise(Emissions = sum(Emissions))

# produce plot
png(filename = "plot2.png")
plot(dat2$year, dat2$Emissions, 
     type = "b", 
     ylab = "Emissions (tons)", 
     xlab= "year",
     main = "Total emissions of PM2.5 per year for Baltimore City, Maryland")
dev.off()
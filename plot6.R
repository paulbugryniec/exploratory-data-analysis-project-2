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
dat6 <- filter(NEI, SCC %in% datCat, fips == "24510" | fips == "06037") %>%
  group_by(year, fips) %>%
  summarise(Emissions = sum(Emissions))

# create an index vs 1999 to see which area has had the greatest changes over time
datLA <- filter(dat6, fips == "06037")
datLA$index <- c(0)
for(i in 1:nrow(datLA)){
  datLA$index[i] <- datLA$Emissions[i] / datLA$Emissions[1]
}

datBalt <- filter(dat6, fips == "24510")
datBalt$index <- c(0)
for(i in 1:nrow(datBalt)){
  datBalt$index[i] <- datBalt$Emissions[i] / datBalt$Emissions[1]
}

# Join indexed data togther and rename the fips for easier reading
dat6b <- rbind(datLA, datBalt)
dat6b$fips <- sub("06037", "LA County", dat6b$fips)
dat6b$fips <- sub("24510", "Baltimore City", dat6b$fips)

# produce plot
ggplot(dat6b, aes(x = year, y = index, colour = fips)) +
  geom_line() +
  ggtitle("Changes in emissions of PM2.5 per year (indexed vs 1999) for motor vehicles \n  Baltimore City vs Los Angeles County")
ggsave(filename="plot6.png")



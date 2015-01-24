library(dplyr)
library(ggplot2)

if(!file.exists("./data")) {
  dir.create("./data")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./data/exdata-data-NEI_data.zip", method = "curl")
  unzip("./data/exdata-data-NEI_data.zip", exdir = "./data")
}

## Using readRDS(), unserialize the R objects
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

total_emissions_in_baltimore_by_year <- NEI %>% 
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarise(Total.Emissions = sum(Emissions))

png("plot3.png", width = 1024, height = 768)

p <- qplot(year, Total.Emissions, data = total_emissions_in_baltimore_by_year, facets = .~type, color = type)
p <- p + geom_smooth(method=lm)
print(p)

dev.off()
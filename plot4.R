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

total_emissions_from_coal_by_year <- merge(NEI, SCC) %>% 
  filter(grepl("Comb.*[Cc]oal", EI.Sector)) %>%
  group_by(year) %>%
  summarise(Total.Emissions = sum(Emissions))

png("plot4.png")

p <- qplot(year, Total.Emissions, data = total_emissions_from_coal_by_year)
p <- p + geom_smooth(method=lm)
print(p)

dev.off()
library(dplyr)

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
  group_by(year) %>%
  summarise(Total.Emissions = sum(Emissions))

png("plot2.png")

with(total_emissions_in_baltimore_by_year, {
  plot(Total.Emissions ~ year);
  regression_of_emissions_on_year <- lm(Total.Emissions ~ year);
  abline(regression_of_emissions_on_year, col = "red");
  })

dev.off()
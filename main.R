require(dplyr)
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if(!file.exists('./Data')){
    dir.create('./Data')
}

if(!file.exists('./Data/pmdata.zip')){
    osname <- Sys.info()[1]
    if(osname == "windows"){
        download.file(url = dataURL, 
                      './Data/pmdata.zip')
    }else{
        download.file(url = dataURL, 
                      './Data/pmdata.zip',
                      method="curl")
    }
}

if(!file.exists('./Data/Source_Classification_Code.rds')){
    unzip(zipfile = "Data/pmdata.zip",files ="Source_Classification_Code.rds", exdir="./Data")
}

if(!file.exists('./Data/summarySCC_PM25.rds')){
    unzip(zipfile = "Data/pmdata.zip",files ="summarySCC_PM25.rds", exdir="./Data")
}

#NEI <- readRDS("./Data/summarySCC_PM25.rds")
#SCC <- readRDS("./Data/Source_Classification_Code.rds")

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base 
# plotting system, make a plot showing the total PM2.5 emission from all sources for each of the 
# years 1999, 2002, 2005, and 2008.

total_pm25 <- NEI %>%
    select(Pollutant, Emissions, year) %>%
    filter(year >= 1999 & year <= 2008) %>%
    group_by(year) %>%
    summarize(Emissions = sum(Emissions))

plot(total_pm25$year, total_pm25$Emissions, type="l")
    
# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 
# 1999 to 2008? Use the base plotting system to make a plot answering this question.

balt_pm25 <- NEI %>%
    filter(fips == "24510") %>%
    select(Pollutant, Emissions, year) %>%
    filter(year >= 1999 & year <= 2008) %>%
    group_by(year) %>%
    summarize(Emissions = sum(Emissions))

plot(balt_pm25$year, balt_pm25$Emissions, type="l")

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a
# plot answer this question.

require(ggplot2)
fourpoll <- NEI %>%
    filter(fips == "24510") %>%
    filter(year >= 1999 & year <= 2008) %>%
    group_by(type, year) %>%
    summarize(Emissions = sum(Emissions))
ggplot(fourpoll, aes(x=year, y=Emissions)) + geom_point() + geom_smooth(method=lm) + facet_grid(.~type)
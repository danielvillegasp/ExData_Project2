this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

require(dplyr)
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if(!file.exists('./Data')){
    dir.create('./Data')
}
if(!file.exists('./img')){
    dir.create('./img')
}
if(!file.exists('./Data/pmdata.zip')){
    osname <- Sys.info()[1]
    if(osname == "Windows"){
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

if(!exists("NEI")){
    NEI <- readRDS("./Data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("./Data/Source_Classification_Code.rds")
}


# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base 
# plotting system, make a plot showing the total PM2.5 emission from all sources for each of the 
# years 1999, 2002, 2005, and 2008.

png("./img/plt1.png", width = 800, height = 600)
source("plot1.R")
dev.off()

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 
# 1999 to 2008? Use the base plotting system to make a plot answering this question.

png("./img/plt2.png", width = 800, height = 600)
source("plot2.R")
dev.off()

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a
# plot answer this question.

png("./img/plt3.png", width = 800, height = 600)
source("plot3.R")
dev.off()

# 4. Across the United States, how have emissions from coal combustion-related sources changed from
# 1999–2008?

png("./img/plt4.png", width = 800, height = 600)
source("plot4.R")
dev.off()

# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

png("./img/plt5.png", width = 800, height = 600)
source("plot5.R")
dev.off()

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen
# greater changes over time in motor vehicle emissions?

png("./img/plt6.png", width = 800, height = 600)
source("plot6.R")
dev.off()
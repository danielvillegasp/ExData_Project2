# Plot 2

plot2 <- function(NEI){
    balt_pm25 <- NEI %>%
        filter(fips == "24510") %>%
        select(Pollutant, Emissions, year) %>%
        filter(year >= 1999 & year <= 2008) %>%
        group_by(year) %>%
        summarize(Emissions = sum(Emissions))
    plot(balt_pm25$year, balt_pm25$Emissions, type="l", 
         xlab="Year", ylab=expression("Total Emissions of PM"[2.5]),
         main="Emissions in Baltimore")
}

if(!exists("NEI")){
    NEI <- readRDS("./Data/summarySCC_PM25.rds")
}

plot2(NEI)
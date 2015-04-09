# Plot 1

plot1 <- function(NEI){
    total_pm25 <- NEI %>%
    select(Pollutant, Emissions, year) %>%
    filter(year >= 1999 & year <= 2008) %>%
    group_by(year) %>%
    summarize(Emissions = sum(Emissions))
    plot(total_pm25$year, total_pm25$Emissions, type="l", 
         xlab = "Year", ylab=expression("Total Emissions of PM"[2.5]))
}

if(!exists("NEI")){
    NEI <- readRDS("./Data/summarySCC_PM25.rds")
}


plot1(NEI)
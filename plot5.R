require(ggplot2)

plot5 <- function(NEI, SCC){
    motorVehicleCodes <- SCC %>%
        filter(SCC.Level.One == "Mobile Sources" &
                   SCC.Level.Two != "Aircraft" & 
                   !grepl("Marine Vessels", SCC.Level.Two, ignore.case=T) &
                   !grepl("Railroad", SCC.Level.Two, ignore.case=T) &
                   SCC.Level.Two != "Pleasure Craft" & 
                   SCC.Level.Two != "Paved Roads" & 
                   SCC.Level.Two != "Unpaved Roads" & 
                   SCC.Level.Two != "unknown non-US source") %>%
        select(SCC)
    motorVehicleNEI <- NEI %>%
        filter(SCC %in% motorVehicleCodes$SCC) %>%
        filter(fips == "24510") %>%
        group_by(year) %>%
        summarize(Emissions=sum(Emissions))
    g<-ggplot(motorVehicleNEI, aes(x=year, y=Emissions)) + 
        geom_point() + 
        geom_smooth(method=lm) +
        xlab("Year") +
        ylab(expression("Total Emissions of PM"[2.5])) + 
        ggtitle("Motor Vehicle PM2.5 Emissions in Baltimore")
    print(g)
}

if(!exists("NEI")){
    NEI <- readRDS("./Data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("./Data/Source_Classification_Code.rds")
}

plot5(NEI, SCC)
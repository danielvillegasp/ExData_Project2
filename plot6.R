require(ggplot2)

plot6 <- function(NEI, SCC){
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
    ByCmotorVehicleNEI <- NEI %>%
        filter(SCC %in% motorVehicleCodes$SCC) %>%
        filter(fips == "24510" | fips == "06037") %>%
        group_by(year, fips) %>%
        summarize(Emissions=sum(Emissions)) %>%
        mutate(place=ifelse(fips=="24510", "Baltimore", "LA"))
    g<-ggplot(ByCmotorVehicleNEI, aes(x=year, y=Emissions, color=place)) + 
        geom_point() + 
        geom_smooth(method=lm) + 
        xlab("Year") +
        ylab(expression("Total Emissions of PM"[2.5])) + 
        ggtitle("Motor Vehicles PM2.5 Emissions in Baltimore and LA")
    print(g)
}

if(!exists("NEI")){
    NEI <- readRDS("./Data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("./Data/Source_Classification_Code.rds")
}

plot6(NEI, SCC)
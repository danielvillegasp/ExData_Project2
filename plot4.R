require(ggplot2)

plot4 <- function(NEI, SCC){
    combustionCodes <- SCC %>%
        filter(grepl("comb", Short.Name, ignore.case = T) &
                   grepl("coal", Short.Name, ignore.case = T)) %>%
        select(SCC)
    combustionNEI <- NEI %>%
        filter(SCC %in% combustionCodes$SCC) %>%
        group_by(year) %>%
        summarize(Emissions=sum(Emissions))
    
    g<-ggplot(combustionNEI, aes(x=year, y=Emissions)) + 
        geom_point() + 
        geom_smooth(method=lm) +
        xlab("Year") +
        ylab(expression("Total Emissions of PM"[2.5])) + 
        ggtitle("Total PM2.5 Emissions due to coal combustion")
    print(g)
}

if(!exists("NEI")){
    NEI <- readRDS("./Data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("./Data/Source_Classification_Code.rds")
}

plot4(NEI, SCC)
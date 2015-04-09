require(ggplot2)

plot3 <- function(NEI){
    fourpoll <- NEI %>%
        filter(fips == "24510") %>%
        filter(year >= 1999 & year <= 2008) %>%
        group_by(type, year) %>%
        summarize(Emissions = sum(Emissions))
        g<-ggplot(fourpoll, aes(x=year, y=Emissions, color=type)) + 
            geom_point() + 
            geom_path() +
            xlab("Year") +
            ylab(expression("Total Emissions of PM"[2.5])) + 
            ggtitle("Baltimore PM2.5 Emissions by Type")
        print(g)
}

if(!exists("NEI")){
    NEI <- readRDS("./Data/summarySCC_PM25.rds")
}

plot3(NEI)
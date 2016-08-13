if (!exists("NEI")) {
        NEI <-readRDS("summarySCC_PM25.rds")
        
}

if (!exists("SCC")) {
        SCC <-readRDS("Source_Classification_Code.rds")
}

BaltimoreSet <-subset(NEI, fips ==24510)

BaltimoreAggYearType <- aggregate(Emissions ~ year + type, BaltimoreSet,sum)

png("plot3.png",width=640, height=480,units='px')

library(ggplot2)

g<-ggplot(BaltimoreAggYearType, aes(year, Emissions, color = type))
g<-   g + geom_line() + 
        xlab("Year") + 
        ylab(expression("Total PM" [2.5]*" Emissions in Tons")) + 
        labs(title=expression("PM"[2.5]*" Emissions in Baltimore 1999 - 2008 by type"))
print(g)
dev.off()
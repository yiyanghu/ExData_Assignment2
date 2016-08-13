if (!exists("NEI")) {
        NEI <-readRDS("summarySCC_PM25.rds")
        
}

if (!exists("SCC")) {
        SCC <-readRDS("Source_Classification_Code.rds")
}

BaltimoreSet <-subset(NEI, fips ==24510)

BaltimoreAggTotal <- aggregate(Emissions ~ year, BaltimoreSet,sum)

png("plot2.png")
barplot(height=BaltimoreAggTotal$Emissions,
         names.arg=BaltimoreAggTotal$year,
         xlab="years",
         ylab=expression(" PM"[2.5]*" Emission"),
         main = expression ("Total PM"[2.5]*" Emission in Baltimore by Year"),
         ylim=c(0,3500)
)

dev.off()
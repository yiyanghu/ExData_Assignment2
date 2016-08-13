if (!exists("NEI")) {
        NEI <-readRDS("summarySCC_PM25.rds")
        
}

if (!exists("SCC")) {
        SCC <-readRDS("Source_Classification_Code.rds")
}

# Filter subsets for motor vehicles

motor <- NEI[(NEI$fips=="24510"| NEI$fips=="06037") & NEI$type == "ON-ROAD",]

aggregatedMotor <-aggregate(Emissions ~ year + fips, motor , sum)
aggregatedMotor$fips[aggregatedMotor$fips=="24510"] <-"Baltimore"
aggregatedMotor$fips[aggregatedMotor$fips=="06037"] <-"Los Angeles"



library(ggplot2)
png("plot6.png", width=640, height=480)

g<-ggplot(aggregatedMotor, aes(year, Emissions, color = fips))

g<-   g + geom_line() + 
        xlab("Year") + 
        ylab(expression("Total PM" [2.5]*" Emissions in Tons")) + 
        labs(title=expression("PM"[2.5]*" Emissions from Motor Vehicles in Baltimore and Los Angeles 1999 - 2008"))
print(g)
dev.off()


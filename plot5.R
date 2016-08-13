if (!exists("NEI")) {
        NEI <-readRDS("summarySCC_PM25.rds")
        
}

if (!exists("SCC")) {
        SCC <-readRDS("Source_Classification_Code.rds")
}

# Filter subsets for motor vehicles

motor <- NEI[NEI$fips=="24510" & NEI$type == "ON-ROAD",]

aggregatedMotor <-aggregate(Emissions ~ year, motor , sum)
colnames(aggregatedMotor) <- c("year","Emissions")

library(ggplot2)
png("plot5.png", width=640, height=480)

qplot(year,Emissions,data=aggregatedMotor,geom="line") +
        ggtitle(expression("PM"[2.5]*" Emissions from Motor Vehicles in Maryland 1999 - 2008 ")) +
        xlab("Year") +
        ylab(expression("Total PM" [2.5]*" Emissions in Tons"))

dev.off()
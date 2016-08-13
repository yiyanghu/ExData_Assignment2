if (!exists("NEI")) {
        NEI <-readRDS("summarySCC_PM25.rds")
        
}

if (!exists("SCC")) {
        SCC <-readRDS("Source_Classification_Code.rds")
}

# Merge two data sets by SCC

NEISCC <-merge(NEI,SCC,by="SCC")


# Filter in SCC for coal combustion-related sources

combust <- grepl("comb",NEISCC$SCC.Level.One,ignore.case=TRUE)
coal <- grepl("coal",NEISCC$Short.Name,ignore.case=TRUE)
coalCombust <-(combust & coal)


coalCombustNEISCC <-NEISCC[coalCombust,]
aggregatedTotalbyYear <- aggregate(Emissions ~  year, coalCombustNEISCC, sum)


png("plot4.png", width=640, height=480)

g <- ggplot(aggregatedTotalbyYear,aes(factor(year), Emissions))
g<-   g + geom_bar(stat="identity") + 
        xlab("Year") + 
        ylab(expression("Total PM" [2.5]*" Emissions in Tons")) + 
        labs(title=expression("PM"[2.5]*" Emissions from coal combustion-related sources 1999 - 2008 "))


print(g)
dev.off()


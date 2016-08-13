
#Download the archived file if not exists

archive <- "NEI_data.zip"

if(!file.exists(archive)) {
        archiveURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        retval=download.file(url=archiveURL,destfile = archive,method="curl")
}

if(!(file.exists("summarySCC_PM25.rds") && file.exists("Source_Classification_Code.rds"))) {
        unzip(archive)
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

aggTotal <-aggregate(Emissions ~ year,NEI,sum)

png("plot1.png")
barplot( height=aggTotal$Emissions/10^6,
         names.arg=aggTotal$year,
         xlab="years",
         ylab=expression(" PM"[2.5]*" Emission (10^6 Tons)"),
         main = expression ("Total PM"[2.5]*" Emission by Year")
)
dev.off()



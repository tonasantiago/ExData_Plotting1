library(data.table)
library(dplyr)


# Get files and timestamp-----------------------------------------------------------

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
targetfile <- "exdata Fdata Fhousehold_power_consumption.zip"
if (!file.exists(targetfile)){
  download.file(URL, destfile = targetfile)
}
if (!file.exists("./exdata Fdata Fhousehold_power_consumption")){
  unzip(targetfile)
}
rm(targetfile)
rm(URL)

project_time_stamp <- date()
temporal<-file("project_time_stamp.txt")
writeLines(project_time_stamp, temporal)
close(temporal)
rm(project_time_stamp)
rm(temporal)


# Data reading  and cleaning for plot 1-------------------------------------------------------

bdd <- fread("household_power_consumption.txt")[Date == "1/2/2007"| Date == "2/2/2007"]
bdd[bdd == "?"] <- NA
bdd$Date <- as.Date(bdd$Date, format="%d/%m/%Y")
bdd$Time <- as.POSIXct(bdd$Time,format="%H:%M:%S")
bdd$Global_active_power <- as.numeric(bdd$Global_active_power)

# #Plot 1 ----------------------------------------------------------------

png(file = "plot1.png", width = 480, height = 480)
hist(bdd$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()

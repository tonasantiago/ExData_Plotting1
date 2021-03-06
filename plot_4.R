library(data.table)
library(dplyr)


# Get files and timestamp-----------------------------------------------------------

# URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# targetfile <- "exdata Fdata Fhousehold_power_consumption.zip"
# if (!file.exists(targetfile)){
#   download.file(URL, destfile = targetfile)
# }
# if (!file.exists("./exdata Fdata Fhousehold_power_consumption")){
#   unzip(targetfile)
# }
# rm(targetfile)
# rm(URL)
# 
# project_time_stamp <- date()
# temporal<-file("project_time_stamp.txt")
# writeLines(project_time_stamp, temporal)
# close(temporal)
# rm(project_time_stamp)
# rm(temporal)



# Data reading  and cleaning for plot 4------------------------------------

bdd <- fread("household_power_consumption.txt")[Date == "1/2/2007"| Date == "2/2/2007"]
bdd[bdd == "?"] <- NA
bdd$Date <- as.Date(bdd$Date, format="%d/%m/%Y")
bdd$Global_active_power <- as.numeric(bdd$Global_active_power)
bdd$weekday <- as.POSIXct(strptime(paste(bdd$Date, bdd$Time, sep = " "),
                                format = "%Y-%m-%d %H:%M:%S"))


# #Plot 4 ----------------------------------------------------------------

png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

## Graph 1
with(bdd,
     plot(weekday,
          Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power"))

## Graph 2
with(bdd,
     plot(weekday,
          Voltage,
          type = "l",
          xlab = "datetime",
          ylab = "Voltage"))

## Graph 3
with(bdd,
     plot(weekday,
          Sub_metering_1,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))
with(bdd,
     points(weekday,
            type = "l",
            Sub_metering_2,
            col = "red")
)
with(bdd,
     points(weekday,
            type = "l",
            Sub_metering_3,
            col = "blue")
)
legend("topright", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)

## Graph 4
with(bdd,
     plot(weekday,
          Global_reactive_power,
          type = "l",
          xlab = "datetime",
          ylab = "Global_reactive_power"))

dev.off()

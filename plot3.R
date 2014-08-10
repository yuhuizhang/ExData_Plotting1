## read the data
myData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c(Date = "character", Time = "character", rep("numeric", 7)), stringsAsFactors = FALSE, na.strings = '?')
## add a column of the time (time format)
TimeFormat <- strptime(paste(myData[,"Date"], myData[,"Time"], sep = ", "), format = "%d/%m/%Y, %H:%M:%S")
myData <- cbind(myData, TimeFormat)
## subset the two days of the whole data
myData <- myData[myData$TimeFormat >= as.POSIXct("2007-02-01 00:00:00") & myData$TimeFormat < as.POSIXct("2007-02-03 00:00:00"), ]
## plot
png(filename = 'plot3.png', width = 480, height = 480, units = 'px')
with(myData, plot(TimeFormat, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black"))
with(myData, lines(TimeFormat, Sub_metering_2, col = "red"))
with(myData, lines(TimeFormat, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red",  "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = '-', lty = 1)
dev.off()

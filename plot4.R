if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power.zip")
  unzip("power.zip")
  file.remove("power.zip")
}

power <- read.csv("household_power_consumption.txt", na.strings = "?", sep= ";")
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power <- subset(power, Date >= "2007-02-01" & Date <= "2007-02-02")
dateTimes <- paste(power$Date, power$Time)
dateTimes <- as.POSIXct(dateTimes)
power$dateTime <- dateTimes
rm(dateTimes)

# Plot 4
png("Plot4.png")

#4.1
par(mfrow=c(2,2))
plot(power$dateTime, power$Global_active_power, type="n", xlab="", ylab="Global Active Power")
lines(power$dateTime, power$Global_active_power)
#4.2
plot(power$dateTime, power$Voltage, type="n", xlab="datetime", ylab="voltage")
lines(power$dateTime, power$Voltage)
#4.3
plot(power$dateTime, power$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(power$dateTime, power$Sub_metering_1)
lines(power$dateTime, power$Sub_metering_2, col="red")
lines(power$dateTime, power$Sub_metering_3, col="blue")
legend(x="topright", col=c("black","red","blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#4.4
plot(power$dateTime, power$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(power$dateTime, power$Global_reactive_power)

dev.off()
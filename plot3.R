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

# Plot 3
png("Plot3.png")
plot(power$dateTime, power$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(power$dateTime, power$Sub_metering_1)
lines(power$dateTime, power$Sub_metering_2, col="red")
lines(power$dateTime, power$Sub_metering_3, col="blue")
legend(x="topright", col=c("black","red","blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

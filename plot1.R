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
# Plot 1
png("Plot1.png")
hist(power$Global_active_power, xlab= "Global Active Power (kilowatts)", col="red", main = "Global Active Power")
dev.off()

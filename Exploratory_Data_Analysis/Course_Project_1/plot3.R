## Plot 3

data <- fread("household_power_consumption.txt")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data1$Time <- chron(times. = data1$Time)

DT <- as.POSIXct(paste(data1$Date, data1$Time), format="%Y-%m-%d %H:%M:%S")
data1 <- cbind(data1, DT)


plot(data1$DT, data1$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data1$DT, data1$Sub_metering_2, type = "l", col = "red")
lines(data1$DT, data1$Sub_metering_3, type = "l", col = "blue")
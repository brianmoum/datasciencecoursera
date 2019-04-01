## Plot 1

data <- fread("household_power_consumption.txt")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data1$Time <- chron(times. = data1$Time)

DT <- as.POSIXct(paste(data1$Date, data1$Time), format="%Y-%m-%d %H:%M:%S")
data1 <- cbind(data1, DT)


hist(data1$Global_active_power, main = "Global Active Power (kilowatts)", 
     col = "red", xlab = "Global Active Power", ylab = "Frequency")

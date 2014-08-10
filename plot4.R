# Read & Clean - function to read in the data file and apply any transformations
# assumes the file household_power_consumption.txt is in the working directory
readAndClean <- function() {
  hpc_file <- file("household_power_consumption.txt")
  #read in file
  hpc_data <- read.delim(hpc_file, sep = ";", stringsAsFactors = FALSE)
  #subset to the required days
  hpc      <- subset(hpc_data, Date == "1/2/2007" | Date == "2/2/2007")
  #transform the Date column to the Date/Time format
  hpc$Date <- strptime(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")
  hpc
}

#Code to produce the plot and write it to the working directory
hpc <- readAndClean()

png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

par(mfcol = c(2,2))

# 1st plot
plot(hpc$Date, hpc$Global_active_power, type="l", ylab = "Global Active Power", xlab="")

# 2nd plot
plot(hpc$Date, hpc$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
points(hpc$Date, hpc$Sub_metering_2, type="l", col="Red")
points(hpc$Date, hpc$Sub_metering_3, type="l", col="Blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), lwd=c(2.5,2.5),
       col=c("black","red", "blue"),
       bty="n")

# 3rd plot
plot(hpc$Date, hpc$Voltage, type="l", xlab="datetime", ylab="Voltage")

# 4th plot
plot(hpc$Date, hpc$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()

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
  # convert the sub metering columns to numeric - except #3 which default reads as numeric
  hpc$Sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
  hpc$Sub_metering_2 <- as.numeric(hpc$Sub_metering_2)
  hpc
}

#Code to produce the plot and write it to the working directory
hpc <- readAndClean()

png(filename = "plot3.png",
    width = 480, height = 480, units = "px")

plot(hpc$Date, hpc$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
points(hpc$Date, hpc$Sub_metering_2, type="l", col="Red")
points(hpc$Date, hpc$Sub_metering_3, type="l", col="Blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), lwd=c(2.5,2.5),
       col=c("black","red", "blue"))

dev.off()

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
  # convert global active power column to numeric
  hpc$Global_active_power <- as.numeric(hpc$Global_active_power)
  hpc
}

#Code to produce the plot and write it to the working directory
hpc <- readAndClean()

png(filename = "plot2.png",
    width = 480, height = 480, units = "px")

plot(hpc$Date, hpc$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab="")

dev.off()

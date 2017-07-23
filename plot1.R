# Exploratory Data Analysis Week1 Project
# Plot 1
#

# Required libraries
library(dplyr)
library(data.table)

# Initializing working space.
rm(list = ls())

# Downloading zip file if necessary.
urlZipFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "exdata_data_household_power_consumption.zip"
filename <- "household_power_consumption.txt"

if (!file.exists(zipFile)) {
  download.file(urlZipFile, zipFile, method = "curl")
}

if (!file.exists(filename)) {
  unzip(zipFile)
}

# Loading fullSet table with all data.
fullSet <- read.table(file = filename, header = TRUE, sep = ";", na.strings = "?")

# Loading project set with filtered data.
projectSet <- filter(fullSet, grepl("^1/2/2007|^2/2/2007", Date))

# Assigning columns types.
projectSet$Date <- as.Date(projectSet$Date, format="%d/%m/%Y")
projectSet$Time <- format(projectSet$Time, format="%H:%M:%S")
projectSet$Global_active_power <- as.numeric(projectSet$Global_active_power)
projectSet$Global_reactive_power <- as.numeric(projectSet$Global_reactive_power)
projectSet$Voltage <- as.numeric(projectSet$Voltage)
projectSet$Global_intensity <- as.numeric(projectSet$Global_intensity)
projectSet$Sub_metering_1 <- as.numeric(projectSet$Sub_metering_1)
projectSet$Sub_metering_2 <- as.numeric(projectSet$Sub_metering_2)
projectSet$Sub_metering_3 <- as.numeric(projectSet$Sub_metering_3)

# Building Plot 1 and saving it in a 480 x 480 png file.
png("./plot1.png", width=480, height=480)
par(mfrow=c(1,1))
hist(projectSet$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
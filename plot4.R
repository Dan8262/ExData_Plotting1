# Exploratory Data Analysis Week1 Project
# Plot 4
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

datetime <- strptime(paste(projectSet$Date, projectSet$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
projectSet <- cbind(projectSet, datetime)
setnames(projectSet, "datetime", "Date_time")

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

# Building Plot 3 and saving it in a 480 x 480 png file.
par(mfrow=c(1,1))
png("./plot3.png", width=480, height=480)
# Due to locale settings, week days are displayed in french ("jeu", "ven", "sam").
with(projectSet, plot(Date_time, Sub_metering_1, type="l", xlab = "", ylab="Energy sub metering"))
# Exploratory Data Analysis Week1 Project
# Plot 2
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

# Creating new Date_time column.
datetime <- strptime(paste(projectSet$Date, projectSet$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
projectSet <- cbind(projectSet, datetime)
setnames(projectSet, "datetime", "Date_time")

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

# Building Plot 4 and saving it in a 480 x 480 png file.
png("./plot4.png", width=480, height=480)
par(mfrow=c(2,2))
# Due to locale settings, week days are displayed in french ("jeu", "ven", "sam").
with(projectSet, plot(Date_time, Global_active_power, type="l", col = "black", xlab = "", ylab="Global Active Power"))
with(projectSet, plot(Date_time, Voltage, type="l", col = "black", xlab = "datetime", ylab="Voltage"))
with(projectSet, plot(Date_time, projectSet$Sub_metering_1, type="l", col = "black", xlab = "", ylab="Energy sub metering", fill = NULL))
lines(projectSet$Date_time, projectSet$Sub_metering_2, type="l", col ="red")
lines(projectSet$Date_time, projectSet$Sub_metering_3, type="l", col ="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")
with(projectSet, plot(Date_time, Global_reactive_power, type="l", col = "black", xlab = "datetime", ylab="Global_reactive_power"))
dev.off()
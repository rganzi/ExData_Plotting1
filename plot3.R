#Exploratory Data Analysis, Course Project 1: plot3

#read in first five rows of data
tab5rows <- read.table("household_power_consumption.txt", header=TRUE, nrows = 5, sep=";")
tab5rows$Date <- as.character(tab5rows$Date)
tab5rows$Time <- as.character(tab5rows$Time)

#list of classes for read.table colClasses argument and read in all data
classes <- sapply(tab5rows, class)
tabAll <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?", colClasses = classes)

#select out specified two days in February 2007
tabAll$Date <- as.Date(tabAll$Date, "%d/%m/%Y")
selectOut <- tabAll$Date >= as.Date("2007-02-01") & tabAll$Date <= as.Date("2007-02-02")
tabAll <- tabAll[selectOut, ]

#create DateTime var for strptime()
tabAll$DateTime <- paste(as.character(tabAll$Date), tabAll$Time)
tabAll$DateTime <- strptime(tabAll$DateTime, "%Y-%m-%d %X")

#set up group-form data frame
tabAll$DateTime <- as.character(tabAll$DateTime)
DateTime <- rep(tabAll$DateTime, 3)
Sub_meterID <- c(rep(1, 2880), rep(2, 2880), rep(3, 2880))
Sub_metering <- c(tabAll$Sub_metering_1, tabAll$Sub_metering_2, tabAll$Sub_metering_3)
sub <- as.data.frame(cbind(DateTime, Sub_meterID, Sub_metering))
sub$DateTime <- strptime(sub$DateTime, "%Y-%m-%d %X")
sub$Sub_metering <- as.character(sub$Sub_metering)
sub$Sub_metering <- as.numeric(sub$Sub_metering)

#plot3 as png file
png(file = "plot3.png")
plot(sub$DateTime, sub$Sub_metering, type = "n", xlab = "", ylab = "Energy sub metering")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
points(sub$DateTime[sub$Sub_meterID == "1"], sub$Sub_metering[sub$Sub_meterID == "1"], type = "l")
points(sub$DateTime[sub$Sub_meterID == "2"], sub$Sub_metering[sub$Sub_meterID == "2"], type = "l", col = "red")
points(sub$DateTime[sub$Sub_meterID == "3"], sub$Sub_metering[sub$Sub_meterID == "3"], type = "l", col = "blue")
dev.off()
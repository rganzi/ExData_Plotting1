#Exploratory Data Analysis, Course Project 1: plot1

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

#plot1 as png file
png(file="plot1.png")
hist(tabAll$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
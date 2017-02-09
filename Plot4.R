### Step 1: Download data
if (!file.exists("./data")) dir.create("./data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data.dir <- file.path(getwd(), "data/")
download.file(url, destfile = file.path(data.dir, basename(url)))

### Step 2: Unzip the file
unzip(zipfile = file.path(data.dir, basename(url)), exdir = "./data")


### Step 3: Read the file 
### Get row id of date 2007-02-01 and 2007-02-02, retrieve the data and convert the format
rowno <- grep("(^1|^2)\\/2\\/2007", readLines("./data/household_power_consumption.txt"))
data <- read.table(file.path(data.dir, "household_power_consumption.txt"), header = TRUE,sep = ";",
                   na.string = "?", colClasses = c("character", "character", NA))[rowno,]
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")


### Step 4: Plot 4
png(filename = "./data/plot4.png", width = 480, height = 480, units = "px")
## Set the nr-by-nc array that Subsequent figures will be drawn in  
par(mfcol=c(2,2))
## Plot plot2 (global active power time series)
with(data,plot(x=DateTime, y=Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowattz)"))
## Plot plot3 without border (engergy sub metering time-series)
with(data,plot(x=DateTime, y=Sub_metering_1, type="l", col="black", xlab="", ylab = "Energy Sub metering"))
with(data, points(x=DateTime, y=Sub_metering_2, type = "l", col="red"))
with(data, points(x=DateTime, y=Sub_metering_3, type = "l", col="blue"))
legend("topright",  lty = 1,col = c("black","blue","red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_2"), bty = "n")
## Plot topright plot (voltage time-series)
with(data,plot(x=DateTime, y=Voltage, type="l", xlab="datetime", ylab = "Voltage"))
## Plot bottomleft plot (global reactive power time-series)
with(data,plot(x=DateTime, y=Global_reactive_power, type="l", xlab="datetime"))
dev.off()

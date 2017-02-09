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


### Step 4: Plot 2
png(filename = "./data/plot2.png", width = 480, height = 480, units = "px")
with(data,plot(x=DateTime, y=Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowattz)"))
dev.off()

#Set directory to work in
setwd("/Users/lloyd/Documents/lloyd_2016/coursera/DataScience/Course4_exploratory_data_analysis/assignment/data/ExData_Plotting1")

#Download and unzip dataset - Electric power consumption
if(!file.exists("data")) dir.create("data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./data/electricPower.zip", method = "curl")
unzip("./data/electricPower.zip",exdir = "./data")

#Read in dataset
power.df <- read.table("data/household_power_consumption.txt",header = TRUE, sep = ";")
#subset the dataframe to only day1 and day2, save it as power2.df
day1 <- as.Date("2007-02-01")
day2 <- as.Date("2007-02-02")
Date <- power.df$Date
newDate <- as.Date(Date,"%d/%m/%Y")
selecDay <- newDate == day1 | newDate == day2
power2.df <- power.df[selecDay,]
#common code above
subMeter1 <- as.character(power2.df$Sub_metering_1)
table(subMeter1 == "?") #found no missing values
subMeter1 <- as.numeric(subMeter1)

subMeter2 <- as.character(power2.df$Sub_metering_2)
table(subMeter2 == "?") #found no missing values
subMeter2 <- as.numeric(subMeter2)

subMeter3 <- as.character(power2.df$Sub_metering_3)
table(subMeter3 == "?") #found no missing values
subMeter3 <- as.numeric(subMeter3)

xvalue <- c(1:2880)

Allmeters <- c(subMeter1,subMeter2,subMeter3)
xrange <- range(xvalue)
yrange <- range(Allmeters)

png(filename = "plot3.png")
plot(xrange,yrange, type = "n", ylab="Energy sub metering",
     xlab="",xaxt="n")
axis(1, at=c(1, 1440.5, 2880), labels=c("Thu", "Fri", "Sat"))
lines(xvalue,subMeter1,col = "black")
lines(xvalue,subMeter2,col = "red")
lines(xvalue,subMeter3,col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), col = c("black","red","blue"))
dev.off()
#end of plot3.R
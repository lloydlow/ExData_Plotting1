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
GAP <- as.character(power2.df$Global_active_power)
table(GAP == "?") #found no missing values
GAP <- as.numeric(GAP)

subMeter1 <- as.character(power2.df$Sub_metering_1)
table(subMeter1 == "?") #found no missing values
subMeter1 <- as.numeric(subMeter1)

subMeter2 <- as.character(power2.df$Sub_metering_2)
table(subMeter2 == "?") #found no missing values
subMeter2 <- as.numeric(subMeter2)

subMeter3 <- as.character(power2.df$Sub_metering_3)
table(subMeter3 == "?") #found no missing values
subMeter3 <- as.numeric(subMeter3)

Allmeters <- c(subMeter1,subMeter2,subMeter3)
xrange <- range(xvalue)
yrange <- range(Allmeters)

Voltage <- as.character(power2.df$Voltage)
table(Voltage == "?")
Voltage <- as.numeric(Voltage)

GRP <- as.character(power2.df$Global_reactive_power)
table(GRP == "?")
GRP <- as.numeric(GRP)

xvalue <- c(1:2880)

png(filename = "plot4.png")
par(mfrow = c(2,2))
#GAP
plot(xvalue,GAP, type = "l", ylab="Global Active Power",xlab="",xaxt="n")
axis(1, at=c(1, 1440.5, 2880), labels=c("Thu", "Fri", "Sat"))


#Voltage
plot(xvalue,Voltage, type = "l", ylab="Voltage",xlab="datetime",xaxt="n")
axis(1, at=c(1, 1440.5, 2880), labels=c("Thu", "Fri", "Sat"))

#Energy sub metering
plot(xrange,yrange, type = "n", ylab="Energy sub metering",
     xlab="",xaxt="n")
axis(1, at=c(1, 1440.5, 2880), labels=c("Thu", "Fri", "Sat"))
lines(xvalue,subMeter1,col = "black")
lines(xvalue,subMeter2,col = "red")
lines(xvalue,subMeter3,col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), col = c("black","red","blue"))

#GRP
plot(xvalue,GRP, type = "l", ylab="Global_reactive_power",xlab="datetime",xaxt="n")
axis(1, at=c(1, 1440.5, 2880), labels=c("Thu", "Fri", "Sat"))

dev.off()
#end of plot4.R
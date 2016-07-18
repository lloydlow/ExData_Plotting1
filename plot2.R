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
#As indicated in the instruction, each value is 1 minute apart
xvalue <- c(1:2880)
png(filename = "plot2.png")
plot(xvalue,GAP, type = "l", ylab="Global Active Power (kilowatts)",xlab="",xaxt="n")
axis(1, at=c(1, 1440.5, 2880), labels=c("Thu", "Fri", "Sat"))
dev.off()
#end of plot2.R
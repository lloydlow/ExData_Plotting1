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
#filter "?" from the Global_active_power variable
GAP <- as.character(power2.df$Global_active_power)
#Check for missing values "?"
table(GAP == "?") #found no missing values

#Turn Global_active_power to numeric and plot a hist and save it as png
GAP <- as.numeric(GAP)
png(filename = "plot1.png")
hist(GAP, ylim=c(0,1200),xlim=c(0,6),col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()
#end of plot1.R
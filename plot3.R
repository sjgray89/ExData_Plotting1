#Read in file, convert to date using lubridate package, subset appropriately

library(lubridate)

#download and unzip file if not in current working directory
if(!file.exists("household_power_consumption.txt")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip")
        unzip("household_power_consumption.zip")
}

dat <- read.table("household_power_consumption.txt", header=TRUE, sep = ";",stringsAsFactors = F)
dat$Date <- dmy(dat$Date)
dat <- subset(dat, Date >= "2007-02-01" & Date <= "2007-02-02")

#convert to numeric
for(i in 3:length(dat)){
        dat[,i] <- as.numeric(dat[,i])
}


#combine date and time columns into one giant date-time object
dat$dt <- paste(as.character(dat$Date),dat$Time)
dat$dt <- ymd_hms(dat$dt)

#Make Plot 3 using base R package
png("plot3.png", width=480, height=480) #create png device
plot(dat$dt, dat$Sub_metering_1, xlab ="", ylab="Energy sub metering", type = "n")
lines(dat$dt, dat$Sub_metering_1)
lines(dat$dt, dat$Sub_metering_2, col="red")
lines(dat$dt, dat$Sub_metering_3, col="blue")
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, col=c("black","red","blue"))
dev.off()
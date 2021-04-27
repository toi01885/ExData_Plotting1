#Get the data
library(downloader)
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip "
download(url, destfile = "C:/Users/User/Documents/R/eda.zip",mode = "wb")
unzip("C:/Users/User/Documents/R/eda.zip", exdir = "C:/Users/User/Documents/R/eda")

#Read the data into R, examine it, change the date format and subset it for the assignment
setwd("C:/Users/User/Documents/R/eda")
df<-read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")
head(df)
df[,"Date"] <- as.Date(df[,"Date"],format = "%y/%m/%d")
df1<-subset(df,Date == "2007-02-01" | Date == "2007-02-02")

#Get the data for plot 1 in the correct format
df1[,"Global_active_power"]<-as.numeric(df1[,"Global_active_power"])
df1[,"Global_reactive_power"]<-as.numeric(df1[,"Global_reactive_power"])
df1[,"Sub_metering_1"]<-as.numeric(df1[ ,"Sub_metering_1"])
df1[,"Sub_metering_2"]<-as.numeric(df1[ ,"Sub_metering_2"])
df1[,"Sub_metering_3"]<-as.numeric(df1[ ,"Sub_metering_3"])
DateTime <- (paste(df1$Date, df1$Time, sep=" "))
library(lubridate)
DateTime1<- parse_date_time(DateTime, "ymd_HMS") 
df1 <- cbind(df1, DateTime1)



#Create the plot
png("plot4.png",width = 480, height = 480)
par(mfrow = c(2, 2),mar = c(4, 4, 2, 1))
with(df1,  {
  
  plot(DateTime1, Global_active_power, type = "l", lty = 1,lwd = 1, pch = "1", xlab = "", ylab = "Global Active Power (kilowatts)")
  
  plot(DateTime1, Voltage, type = "l", lty = 1,lwd = 1, pch = "1", xlab = "datetime", ylab = "Voltage")
  
  plot(DateTime1, Sub_metering_1, type = "l", lty = 1,lwd = 1, pch = "1", xlab = "", ylab = "Energy sub metering")
    with(df1,lines(DateTime1, Sub_metering_2, col = "red"))
    with(df1, lines(DateTime1, Sub_metering_3, col = "blue"))
    legend("topright",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = c(1,1,1), col = c("black","red","blue"))

  
    
  plot(DateTime1, Global_reactive_power, type = "l", lty = 1,lwd = 1, pch = "1", xlab = "datetime", ylab = "Global_reactive_power")
  
})
dev.off()
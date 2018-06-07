#plot 4
#Plot 1
#Data manipulation
setwd("C:\\Users\\ssopic\\Desktop\\Coursera\\4. Exploratory data analysis\\first assignment")
data <- read.csv("C:\\Users\\ssopic\\Desktop\\Coursera\\4. Exploratory data analysis\\first assignment\\household_power_consumption.txt", sep=";")
names(data)
#Changing the variables into their appropriate format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
#Creating the subsets and merging them
subset <- subset(data, Date=="2007-02-01")
head(subset)
subset2 <- subset(data, Date=="2007-02-02")
total <- rbind(subset, subset2)
head(total)
#creating backup
write.csv(total, file="C:\\Users\\ssopic\\Desktop\\Coursera\\4. Exploratory data analysis\\first assignment\\total.csv")
#loading and checking the backup
total <- read.csv("C:\\Users\\ssopic\\Desktop\\Coursera\\4. Exploratory data analysis\\first assignment\\total.csv")
head(total)
#removing the first collumn as it contains only the order
total <- total[,2:10]
#defining the NA's
total[total=="?"] <- NA
#Creating the data and time combination 
total$TimeCombination <- as.POSIXct(strptime(paste(total$Date, total$Time, sep=" "), format="%Y-%m-%d %H:%M:%S"))
head(total)
#Changing the Global active power to correct format
data$Global_active_power <- as.numeric(data$Global_active_power)


#Changing the time to "english" as The graphs show the names of the days in Croatian
Sys.setlocale("LC_TIME","English")


#Changing the parameters
par(mfcol=c(2,2))

#plot 1
with(total, plot(TimeCombination, Global_active_power, type = "l", xlab="", ylab="Global Active Power"))

#plot2
with(total, plot(TimeCombination,Sub_metering_1,  type="l", xlab="", ylab="Energy sub metering" ))
with(total,lines(TimeCombination, Sub_metering_2, col="red"))
with(total, lines(TimeCombination, Sub_metering_3, col="blue"))
legend("topright", cex=0.30,text.width = 10000, lwd=1,col=c("black", "red", "blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ))
?legend

#plot3
with(total, plot(TimeCombination,Voltage,  type="l",xlab="datetime"))
#plot4
with(total, plot(TimeCombination,Global_reactive_power,  type = "l", xlab="datetime"))

dev.copy(png, "plot4.png", height=480, width=480)
dev.off()

#Plot 3
#Data manipulation

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


#Creating the plot
#Initial plot
with(total, plot(TimeCombination,Sub_metering_1,  type="l", xlab="", ylab="Energy sub metering" ))
#adding line 
with(total,lines(TimeCombination, Sub_metering_2, col="red"))
#Adding line
with(total, lines(TimeCombination, Sub_metering_3, col="blue"))
#adding the legend
legend("topright", lwd=1,col=c("black", "red", "blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ))

dev.copy(png, "plot3.png", height=480, width=480)
dev.off()

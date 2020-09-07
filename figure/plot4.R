library(dplyr)

data <- read.table("household_power_consumption.txt", na.strings = "?",
                   header = TRUE, sep = ";")

sub_data <- data %>%
        filter(Date == "1/2/2007"
               | Date == "2/2/2007") %>%
        mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
        mutate(Time = format(strptime(Time, format = "%H:%M:%S"), 
                             "%H:%M:%S"))

png(filename = "plot1.png", width = 480, height = 480, units = "px")

par(mfcol = c(2,2), mar = c(4,4,1,1), oma = c(1,1,1,0))
with(sub_data, {
        plot(as.numeric(as.character(sub_data$Global_active_power)), type = "l",
             ylab = "Global Active Power", 
             xlab = "", xaxt="n", yaxt="n", cex.lab = 0.75)
        axis(side = 1, tick = T, at = c(0, 1440, 2880), 
             labels = c("Thu", "Fri", "Sat"), cex.axis = 0.75)
        axis(side = 2, cex.axis = 0.75)
        
        plot(Sub_metering_1, type = "l", col = "gray48", xaxt="n", yaxt="n",
             ylab = "Energy sub metering", xlab = "", cex.lab = 0.75)
        points(Sub_metering_2, type = "l", col = "red")
        points(Sub_metering_3, type = "l", col = "blue")
        axis(side = 1, tick = T, at = c(0, 1440, 2880), 
             labels = c("Thu", "Fri", "Sat"), cex.axis = 0.75)
        axis(side = 2, cex.axis = 0.75)
        legend("topright", col = c("gray48", "red", "blue"), 
               lty=c(1,1,1), cex = 0.5,
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        plot(as.numeric(as.character(sub_data$Voltage)), type = "l",
             ylab = "Voltage", 
             xlab = "datetime", xaxt="n", yaxt="n", cex.lab = 0.75)
        axis(side = 1, tick = T, at = c(0, 1440, 2880), 
             labels = c("Thu", "Fri", "Sat"), cex.axis = 0.75)
        axis(side = 2, cex.axis = 0.75)
        
        plot(as.numeric(as.character(sub_data$Global_reactive_power)), 
             type = "l", ylab = "Global_reactive_power", 
             xlab = "datetime", xaxt="n", yaxt="n", cex.lab = 0.75)
        axis(side = 1, tick = T, at = c(0, 1440, 2880), 
             labels = c("Thu", "Fri", "Sat"), cex.axis = 0.75)
        axis(side = 2, cex.axis = 0.75)
})

dev.off()
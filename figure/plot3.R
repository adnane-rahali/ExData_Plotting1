library(dplyr)

data <- read.table("household_power_consumption.txt", na.strings = "?",
                   header = TRUE, sep = ";")

sub_data <- data %>%
        filter(Date == "1/2/2007"
               | Date == "2/2/2007") %>%
        mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
        mutate(Time = format(strptime(Time, format = "%H:%M:%S"), 
                             "%H:%M:%S"))

png(filename = "plot3.png", width = 480, height = 480, units = "px")

with(sub_data, {
        plot(Sub_metering_1, type = "l", col = "gray48", xaxt="n", 
             ylab = "Energy sub metering")
        points(Sub_metering_2, type = "l", col = "red")
        points(Sub_metering_3, type = "l", col = "blue")
        axis(side = 1, tick = T, at = c(0, 1440, 2880), 
             labels = c("Thu", "Fri", "Sat"))
        legend("topright", col = c("gray48", "red", "blue"), lty=c(1,1,1),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

dev.off()
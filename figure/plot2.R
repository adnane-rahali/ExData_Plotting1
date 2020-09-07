library(dplyr)

data <- read.table("household_power_consumption.txt", na.strings = "?",
                   header = TRUE, sep = ";")

sub_data <- data %>%
        filter(Date == "1/2/2007"
               | Date == "2/2/2007") %>%
        mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
        mutate(Time = strptime(Time, format = "%H:%M:%S"))

png(filename = "plot2.png", width = 480, height = 480, units = "px")

plot(as.numeric(as.character(sub_data$Global_active_power)), type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "", xaxt="n")
axis(side = 1, tick = T, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

dev.off()
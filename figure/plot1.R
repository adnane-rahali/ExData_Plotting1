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

hist(sub_data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()

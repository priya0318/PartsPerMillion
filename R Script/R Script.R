# FirstYes
for(i in 1:nrow(data)){
  if(data$First_Yes_Sample_Size[i] == 0 & data$Last_Yes_Sample_Size[i] > 0) {
    data$First_Yes_Sample_Size[i] <- data$Last_Yes_Sample_Size[i]
    data$First_Yes_Year[i] <- data$Last_Yes_Year[i]
    data$FirstYes[i] <- data$LastYes[i]
    data$NumLastNo[i] <- 0
  }
}

#FirstNo
for(i in 1:nrow(data)){
  if(data$Last_Yes_Sample_Size[i] == 0 & data$First_Yes_Sample_Size[i] > 0) {
    data$Last_Yes_Sample_Size[i] <- data$First_Yes_Sample_Size[i]
    data$Last_Yes_Year[i] <- data$First_Yes_Year[i]
    data$LastYes[i] <- data$FirstYes[i]
    data$NumFirstNo[i] <- 0
  }
}

# Rename Column
library(dplyr)
data <- data %>% rename(Year = First_Yes_Year)

# Select Columns
cols <- c('SiteID', 'SiteName', 'Latitude', 'Longitude', 'SpeciesID', 
          'SpeciesDesc', 'Kingdom', 'SpeciesType', 'PhenophaseID', 'PhenophaseCategory', 'PhenophaseDesc',
          'Year', 'FirstYes', 'LastYes', 'NumLastNo', 'NumFirstNo')
data <- data[cols]

# Last No and First No
data['LastNo'] <- data$FirstYes - data$NumLastNo
data['FirstNo'] <- data$LastYes + data$NumFirstNo

# Deselect  rows
data <- data %>% filter(data$LastNo <= data$FirstYes &
                          data$FirstYes <= data$LastYes &
                          data$LastYes <= data$FirstNo)

# Total days
data['TotDays'] <- (data$FirstNo - data$LastNo)+1

# Average Days
for(i in 1:nrow(data)){
  data$aveDays[i] <- ceiling((median(data$LastYes[i]:data$FirstNo[i])-median(data$LastNo[i]:data$FirstYes[i]))+1)
}

# YesDays
data['YesDays'] <- (data$LastYes - data$FirstYes)+1

# Yes Group duration
data['YesDurationGroup'] <- NA
for(i in 1:nrow(data)){
  if(data$YesDays[i] <= 1){
    data$YesDurationGroup[i] <- "A. One Day"
  } else if (data$YesDays[i] <= 20){
    data$YesDurationGroup[i] <- "B. 2-20 Days"
  } else if (data$YesDays[i] <= 50){
    data$YesDurationGroup[i] <- "C. 21-50 Days"
  } else if (data$YesDays[i] <= 100){
    data$YesDurationGroup[i] <- "D. 51-100 Days"
  } else if (data$YesDays[i] <= 200){
    data$YesDurationGroup[i] <- "E. 101-200 Days"
  } else {
    data$YesDurationGroup[i] <- "F. 201+ Days"
  }
}

# Descriptive statistics
library(pastecs)
stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Breaking leaf buds")%>%select(FirstYes))

stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Breaking leaf buds")%>%select(TotDays))

stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Breaking leaf buds")%>%select(YesDays))

stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Falling leaves")%>%select(FirstYes))

stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Falling leaves")%>%select(TotDays))

stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Falling leaves")%>%select(YesDays))

stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Colored leaves")%>%select(FirstYes))

stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Colored leaves")%>%select(TotDays))

stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Colored leaves")%>%select(YesDays))

stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Open flowers")%>%select(FirstYes))

stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Open flowers")%>%select(TotDays))

stat.desc(data %>% filter(SpeciesType == "Deciduous broadleaf" & PhenophaseDesc == "Open flowers")%>%select(YesDays))

# Skewness 

library(e1071)
skewness(data$FirstYes)


library(e1071)
skewness(data$YesDays)

library(e1071)
skewness(data$TotDays)

# Write to csv
write.csv(data, file = "JeanFinalDataSet.csv",row.names=FALSE)

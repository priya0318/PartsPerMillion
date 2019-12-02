# prepare the environment
library(tidyverse)
library(readr)
# read in the working dataset
working_phenometrics_data <- read_csv("ISQA8086 Special Topics/Data/working_phenometrics_data.csv")
df <- JeanFinalDataSet
attach(df)
# Use only 4 Phenophases for this stage
workdf <- filter(df, PhenophaseDesc=="Open flowers" | PhenophaseDesc=="Colored leaves" | PhenophaseDesc=="Falling leaves" | PhenophaseDesc=="Breaking leaf buds")
# Select only columns to be used for plotting
workdf <- select(workdf,SiteName,PhenophaseDesc,Year,FirstYes,TotDays,YesDays)
# Eliminate spring observation of fall events, and fall observation of spring events
workdf <- workdf[ !(workdf$PhenophaseDesc=="Falling leaves" & workdf$Year==2019), ]
workdf <- workdf[ !(workdf$PhenophaseDesc=="Colored leaves" & workdf$Year==2019), ]
workdf <- workdf[ !(workdf$PhenophaseDesc=="Open flowers" & workdf$Year==2017), ]
workdf <- workdf[ !(workdf$PhenophaseDesc=="Breaking leaf buds" & workdf$Year==2017), ]
arrange(workdf,PhenophaseDesc,SiteName,Year)
# create a new dataframe with grouped mean data
workdf %>% group_by(PhenophaseDesc,SiteName) %>% summarise(StartDay=mean(FirstYes),TotDur=mean(TotDays),PosDur=mean(TotDays))
ggreadydata <- workdf %>% group_by(PhenophaseDesc,SiteName) %>% summarise(StartDay=mean(FirstYes),TotDur=mean(TotDays),PosDur=mean(TotDays))
# create bar chart of total duration
ggplot(ggreadydata, aes(fill=SiteName, y=TotDur, x=PhenophaseDesc)) +
geom_bar(position="dodge", stat="identity")+
labs(title="Mean Total Duration - All Species", x="Phenophase Event", y="Number of Days")
# create bar chart of positive duration
ggplot(ggreadydata, aes(fill=SiteName, y=PosDur, x=PhenophaseDesc)) +
  geom_bar(position="dodge", stat="identity")+
  labs(title="Mean Positive Duration - All Species", x="Phenophase Event", y="Number of Days")
# create bar chart of starting day of year
ggplot(ggreadydata, aes(fill=SiteName, y=StartDay, x=PhenophaseDesc)) +
  geom_bar(position="dodge", stat="identity")+
  labs(title="Mean Starting Day of Year - All Species", x="Phenophase Event", y="Day of Year")
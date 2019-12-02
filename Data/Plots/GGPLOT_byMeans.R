ggplot(df, aes(fill=Site, y=MeanTotDur, x=PhenoEvent)) +
geom_bar(position="dodge", stat="identity")+
labs(title="Mean Total Duration - All Species", x="Phenophase Event", y="Number of Days")

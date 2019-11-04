PlotData <- filter(working_phenometrics_data, SpeciesDesc == "live oak")
ggplot(PlotData,aes(x=FirstNo, y=PhenoDesc, color=SiteName)) +
geom_point(aes(x=LastNo, y=PhenoDesc)) +
geom_point(aes(x=FirstNo, y=PhenoDesc)) +
geom_segment(aes(x=FirstYes, xend=LastYes, yend=PhenoDesc)) +
facet_grid(rows=vars(Year)) +
labs(x="Day of Year",y="Live Oak",title="Phenophase Observations") +
theme(legend.position="bottom")





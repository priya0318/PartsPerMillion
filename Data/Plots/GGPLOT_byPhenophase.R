PlotData <- filter(working_phenometrics_data, PhenoDesc == "Colored leaves")
ggplot(PlotData,aes(x=FirstNo, y=SpeciesDesc, color=SiteName)) +
geom_point(aes(x=LastNo, y=SpeciesDesc)) +
geom_point(aes(x=FirstNo, y=SpeciesDesc)) +
geom_segment(aes(x=FirstYes, xend=LastYes, yend=SpeciesDesc)) +
facet_grid(rows=vars(Year)) +
labs(x="Day of Year",y="Colored Leaves",title="Phenophase Observations") +
theme(legend.position="bottom")





Data Cleaning Documentation
================
Priyanka Choudhary <br /> Mike Rouw <br /> Pratheeba Nalligounder Palanisami <br />
October 24, 2019

-   [The Data](#the-data)
-   [Licensing](#licensing)
-   [The Metadata](#the-metadata)
-   [Issues you have encountered with the data](#issues-you-have-encountered-with-the-data)
-   [Description of rationale for the steps taken to remediate data](#description-of-rationale-for-the-steps-taken-to-remediate-data)
-   [Data cleaning steps](#data-cleaning-steps)

------------------------------------------------------------------------

The Data
========

The data for the Jean Lafitte National Historical Park and Preserve project collected in the *'site_phenometrics_data'* dataset. Our professor Dr. Andrea Wiggins acquired this data for us from authorities at Jean Lafitte National Historical Park and Preserve, Louisiana. 

The data in 'site_phenometrics_data' dataset is downloaded from Phenology Observation Portal, which contains observations on the plants or animal species at site over three years of period 2017, 2018, and 2019 to understand the effect of climate change on plants and animals. The data set contains 47 columns including - *Partner_Group, Site_ID, Site_Name, Latitude, Longitude, Elevation_in_Meters, State, Species_ID, Genus, Species, Common_Name, Kingdom, Species_Functional_Type, Species_Category, USDA_PLANTS_Symbol, ITIS_Number, Phenophase_ID, Phenophase_Category, Phenophase_Description, First_Yes_Sample_Size, Mean_First_Yes_Year, Mean_First_Yes_DOY, Mean_First_Yes_Julian_Date, SE_First_Yes_In_Days, SD_First_Yes_In_Days, Min_First_Yes_DOY,  Max_First_Yes_DOY, Median_First_Yes_DOY, Mean_NumDays_Since_Prior_No, SE_NumDays_Since_Prior_No, SD_NumDays_Since_Prior_No, Last_Yes_Sample_Size, Mean_Last_Yes_Year, Mean_Last_Yes_DOY, Mean_Last_Yes_Julian_Date, SE_Last_Yes_in_Days, SD_Last_Yes_in_Days, Min_Last_Yes_DOY, Max_Last_Yes_DOY, Median_Last_Yes_DOY, Mean_NumDays_Until_Next_No, SE_NumDays_Until_Next_No, SD_NumDays_Until_Next_No, Num_Individuals_with_Multiple_FirstY, Multiple_FirstY_Individual_IDs, Observed_Status_Conflict_Flag, Observed_Status_Conflict_Flag_Individual_IDs* with 768 rows of data information.

The description of all variables included in the *'site_phenometrics_data'* data file is in *'site_phenometrics_datafield_description'* dataset.

Licensing
=========

This data analysis project uses the MIT License. We are using the data with the permission from the Jean Lafitte National Historical Park and Preserve. *Dr. Elizabeth (Liz) Marchio*, Citizen Science Coordinator at Jean Lafitte National Historical Park and Barataria Preserve have to be consulted for more information on the data. 

The Metadata
============

**We have the following metadata regarding the water quality data set:**

**Note** : A value of "-9999" indicates the organism being monitored is not associated with a partner group.

* Partner_Group: The name of the partner group with which the data are associated (Barataria Phenology Trail).	  
* Site_ID: The unique identifier of the site at which the data were recorded.
* Site_Name: The user-defined name of the site at which the data were recorded.	  
* Latitude: The latitude of the site at which the data were recorded.
* Longitude: The longitude of the site at which the data were recorded.   
* Elevation_in_Meters:The elevation (in meters) of the site (0)
* State: The U.S. state or territory, Mexican state or Canadian province in which the site is located (LA).
* Species_ID: The unique identifier of the species.
* Genus: The taxonomic genus of the organism.
* Species: The taxonomic species of the organism.
* Common_Name: The common name of the species.
* Kingdom:  The taxonomic kingdom of the organism (Plantae|Animalia)	  
* Species_Functional_Type: The plant ecological type or animal guild of the species. 
* Species_Category: The categories to which the species has been assigned.	 
* USDA_PLANTS_Symbol: The USDA PLANTS Database symbol of the species.	  
* ITIS_Number: The Integrated Taxonomic Information System taxonomic serial number of the species. 
* Phenophase_ID: The unique identifier of the phenophase.	 
* Phenophase_Category: Each category includes all phenophases across all plant or animal taxa that target that life stage.
* Phenophase_Description: The descriptive title of the phenophase. 
* First_Yes_Sample_Size: The number of individual organisms that contribute a first "yes" record to the calculation of Mean_First_Yes_DOY and Mean_First_Yes_Julian_Date (This value will always be '1' for animal species)	 
* Mean_First_Yes_Year: The year of the calculated Mean_First_Yes_DOY.	  
* Mean_First_Yes_DOY: The mean day of the year, ranging from 1 to 366.

The data is collected in the 'Barataria Phenology Trail' partner group in four sites Visitor Center Trail,Palmetto Trail, Ring Levee Trail, Bayou Coquille Trail in the year 2017, 2018 and 2019. The reports concentrates on descriptive statistics for the different organisms documented in the data.


Issues you have encountered with the data
=========================================

The majority of the Jean Lafitte dataset was in good shape as it was given.  Each observation was in a single row, in a single file, and most of the dataset was complete.  The primary thrust of the data can be summarized into four areas:  the phenophase observed, the species exhibiting the phenophase, the mean date(s) it was observed, and the location of the observation.  The main issue with the dataset involved the dates of observation.  Within the date observations, the data contained means, medians, highs, lows, and standard deviations to account for any multiple observations.  However, in a vast majority of cases the sample size was 1, and at most 2, making all the statistical distribution data mostly meaningless.  Also, there were several instances where a row would contain a first observation of a particular phenophase, but no last observation, and vice versa.  In addition, some of dates given for first and last observation did not conform with temporal integrity (e.g. the last date was before the first date).  Finally, the dataset had very lengthy variable names, and excess columns either providing alternate descriptions or the same value for every single observation.

Description of rationale for the steps taken to remediate data
==============================================================

First, on data observations that contained no first observation date, that date was set to equal the last observation date (e.g. only observed on one date), and the leading number of days from the last “no” observation was set to zero.  Similarly, on rows that contained no last observation date, that date was set to the first observation date and the trailing number of days until the first “no” observation was set to zero.
Second, columns that were alternative descriptions, or same values, or meaningless statistical data were de-selected, since they provide no meaningful value for the analysis.  Also, some variable names were shortened to facilitate the analysis.
Third, the temporal integrity of the following dates was checked, and any rows that did not follow this rule were de-selected:
	Last “No” Date <= First “Yes” Date <= Last “Yes” Date <= First “No” Date


Data cleaning steps
===================

**Fill in missing information about dates**


If the data contains a "first yes" but no "last yes" information, then set the "last yes" information to the same values as the "first yes" information, and set the lag days to "no" at zero.  The same is true if the data contains a "last yes" but no "first yes".  Effectively, we are saying that if only one "yes" exists, it is both first and last, and the number of days to "no" is zero.

We could also move the Julian date and all the statistical columns associated with "first yes" and "last yes", however in the next pass we will be de-selecting all those columns anyway.

We should now have a dataset with complete information on each observation for "first yes" and "last yes" - anything remaining had NO "yes" observations and will be eliminated in the next pass (based on my Excel look, there are no records to be fully eliminated, but we will put the step in our R script anyway).

**Select rows and columns** 

Select rows only with complete data, and we can select columns based on data we will likely be using in the project.  For rows, we require an observation of at least one "yes".  For columns, we will be eliminating some data that is descriptive but not necessary, columns that have unchanging data, all the "statistical" columns related to sample sizes and Julian dates, and all the observational "conflict" data.  We have elected not to consider the statistical elements (e.g. min, max, std-dev, etc) as all observations are a sample sizes are either 1 or 2.  For samples sizes of 2, the data already contains the mean, so that is the only value we will be using, as the distribution for a sample size of 2 is pretty meaningless.


**Selected columns** 

.SiteID
.SiteName
.Latitude
.Longitude
.SpeciesID
.SpeciesDesc
.Kingdom
.SpeciesType
.PhenophaseID
.PhenophaseDesc
.First_Yes_Year
.Mean_First_Yes_DOY
.NumLastNo
.Last_Yes_Year
.Mean_Last_Yes_DOY
.NumFirstNo

This should yield a dataset with 720 ROWS and 20 COLUMNS.  In the next pass, we will enrich the data with some date calculations.

**Contributorship Statement**: Priyanka Choudhary, Mike Rouw, Pratheeba Nalligounder Palanisami contributed to the data cleaning undertaking and the writing of this document.

**Proofreader statement** : I, Priyanka Choudhary have reviewed and proofread the following work and agree that it is ready for submission.

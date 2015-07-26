###GACDAssignment1###

####The run_analysis.R contains five parts:####
<p>
The initial checking is done to ensure we are at the right working directory in which the data is placed under sub directory.
Libraries are then loaded in. The libraries in use are data.table and dplyr.
</p>

1. Part 1 contains steps to merge data from training and test sets into single dataset

2. Part 2 contains steps to extract only data containing mean and standard deviation values for various measurements

3. Part 3 contains steps to associate numbering used to the descriptive activity names
:LAYING, SITTING , STANDING,WALKING,WALKING_DOWNSTAIRS and WALKING_UPSTAIRS are the activity names respectively

4. Part 4 is to replace acronyms with more readable forms of labels for measurements recorded

5. Part 5 is to tidy the data and output it to Tidy.txt for further processing

####The following are steps to perform analysis with run_analysis.R####

1. Unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Make sure the folderand the run_analysis.R script are both in the current working directory.

2. Use source("run_analysis.R") command in RStudio.

3. You will find output file Tidy.txt is generated in the current working directory.It contains a data frame called result with 180*68 dimension.

4. Finally, use data <- read.table("Tidy.txt") command in RStudio to read the file. Since we are required to get the average of each variable for each activity and each subject, and there are 6 activities in total and 30 subjects in total, we have 180 rows with all combinations for each of the 66 features.

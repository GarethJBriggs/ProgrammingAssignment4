state = "TX"
outcome = "heart attack"

## working directory
        setwd('C:/Users/GEVA/Dropbox/Coursera-R-Programming/Programming Assingnment 3 Data')
##initialise data frame
        hosp_care_df <- data.frame()
##read data
        hosp_care_df <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors=FALSE)
##set the outcomes terms in a vector, names of out come equalling column index for ease of subsetting
        outcomes <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
##subset intial dataframe so that it contains only hosp, states and outcome columns
        hosp_hso_df <- hosp_care_df[, c(2, 7, outcomes[outcome])]
##rename the dataframe columns for ease of use
        names(hosp_hso_df) <- c("hosp", "state", "outcome")
##logically test if state argument value is contained in the dataframe subset of the state column. If false...
        if(state%in%hosp_hso_df$state) {
##return error message of 'invalid state'
                                            stop("invalid state")
##else logically test if outcome argumant value matches any of the outcomes of interest. If false...
                                            } else {
                                                    (outcome%in%hosp_hso_df==F)         
##return an error message of 'invalid outcome'
                                                    stop("invalid outcome")
        }
##subset dataframe by state of interest in states column
        hosp_so_df <- hosp_hso_df[hosp_hso_df$state == state, ]
##create logical vector checking for NA values
        good <- complete.cases(hosp_so_df)
##subset dataframe by logicical vector
        hosp_so_nna_df <- hosp_so_df[good, ]
##rank the hosps in the state by outcome
        hosp_arr_df <- arrange(hosp_so_nna_df, outcome, hosp)
##index the data to return the the hosp value with best outcome that is first alphabetically
        Hospital.Name <- hosp_arr_df[1,1]
##return the hosp name
        Hospital.Name
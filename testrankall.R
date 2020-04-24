## declare variables
        outcome = "heart attack"
        num = 20
## set working directory
        setwd('C:/Users/GEVA/Dropbox/Coursera-R-Programming/Programming Assingnment 3 Data')
## initialise data frame
        hosp_care_df <- data.frame()
## read data
        hosp_care_df <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors  = FALSE)
## define outcomes in terms of column numbers
        outcomes <- c("heart attack" = 11 , "heart failure" = 17, "pneumonia" = 23)
#IF outcome is absent from outcomes
        if(outcome %in% names(outcomes) == FALSE)
## stop rankhospital, print "invalid"
        stop("invalid outcome")
## subset the dataframe by hosp, state and outcome
        hosp_hso_df <- hosp_care_df[, c(2, 7, outcomes[outcome])]
## remame the dataframe columns
        names(hosp_hso_df) <- c("hosp", "state", "outcome")
## identify NA values by outcome per row
        good <- complete.cases(hop_hso_df[,"outcome" ])     
## remove NA values
        hosp_hso_nna_df <- hosp_hso_df[good, ]
## order the dataframe by state,outcome, then hospital
         hosp_arr <- arrange(hosp_hso_nna_df, state, outcome, hosp)
## split the dataframe by state
         s <- split(hosp_hso_nna_df, hosp_hso_nna_df$state)
## IF num equals best
        if(num == "best") {
## use lappy with subset to isolate the highest ranked hospital per state
        rall_List <- lapply(s, tail(s, 1))
## ELSE IF num equals worst
        } else if(num == "worst") {
## use lappy with tail to isolate the lowest ranked hospital per state
        rall_list <- lapply(s, tail(s, 1))
## ELSE IF num equals numeric
        } else if(num == is.numeric(num)) {
## use lappy with subset to isolate hospitals with the same ranking per state
        rall_list<- lappy(s, subset(s[num,]))
        }
## unlist the lappy output
        hosp_vec <- unlist(rall_list)
## use names to generate a vector of state names
        state_vec <- names(hosp_vec)
## create a dataframe of the state and hospital names
        rall_df <- data.frame(hospital = hosp_vec, state = state_vec, row.names = state_vec)
## return the dataframe 
        rall_df
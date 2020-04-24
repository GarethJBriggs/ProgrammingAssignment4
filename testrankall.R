## declare variables
        outcome = "heart attack"
        num = "20"
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
        names(hosp_hso_df) <- c("hospital", "state", "outcome")
## identify NA values by outcome per row
        good <- complete.cases(hosp_hso_df[,"outcome" ])     
## remove NA values
        hosp_hso_nna_df <- hosp_hso_df[good, ]
## order the dataframe by state,outcome, then hospital
         hosp_arr <- arrange(hosp_hso_nna_df, state, outcome, hospital)
## split the dataframe by state
         s <- split(hosp_arr, hosp_arr$state)
## use lappy with an anonymous function to isolate hospitals corrisponding to num arg
         rall_list <- lapply(s, function(x, num) {
                 ## IF num equals best
                 if(num == "best") {
                         ## return first hospital per state list in split
                         return(x$hospital[1])
                         ## ELSE IF num equals worst
                 } else if(num == "worst") {
                         ## last hospital per state list in split
                         tail(x[, "hospital"], 1) 
                         ## ELSE IF num equals numeric
                 } else if(is.numeric(num) == TRUE) {
                         ## return the hospital rank equivelant to num
                         z  <- (x[num, ])
                         return(z$hospital)
                 }
         }, num  )
## unlist the lappy output
        hosp_vec <- unlist(rall_list) 
## use names to generate a vector of state names
        state_vec <- names(hosp_vec)
## create a dataframe of the state and hospital names
        rall_df <- data.frame(hospital = hosp_vec, state = state_vec, row.names = state_vec)
## return the dataframe 
        rall_df
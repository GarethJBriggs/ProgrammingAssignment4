rankhospital <- function(state, outcome, num) {
        ## set working directory
        setwd('C:/Users/GEVA/Dropbox/Coursera-R-Programming/Programming Assingnment 3 Data')
        ## initialise data frame
        hosp_care_df <- data.frame()
        ## read data
        hosp_care_df <- read.csv("outcome-of-care-measures.csv", na.strings="Not Available", stringsAsFactors  = FALSE)
        ## define outcomes in terms of column numbers
        outcomes <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
        ## IF state is absent from the dataframe)
        if(state %in% hosp_care_df[, 7] == FALSE) {
                ##  stop rankhospital, print "invalid state",
                stop("invalid state")
                ## ELSE IF outcome is absent from outcomes
        } else if(outcome %in% names(outcomes) == FALSE) {
                ## stop rankhospital, print "invalid state"
                stop("invalid outcome")
        }
        ## subset the dataframe by hosp, state and outcome
        hosp_hso_df <- hosp_care_df[, c(2, 7, outcomes[outcome])]
        ## remame the dataframe columns
        names(hosp_hso_df) <- c("hosp", "state", "outcome")
        ## subset the dataframe by state
        hosp_ho <- hosp_hso_df[hosp_hso_df$state==state, ]
        ## identify NA values
        good <- complete.cases(hosp_ho)
        ## remove NA values
        hosp_nna <- hosp_ho[good, ]
        ## order the dataframe by outcome, then hospital
        hosp_arr<- arrange(hosp_nna, outcome, hosp)
        ## add a rank column to the dataframe and populate it
        hosp_arr$rank <- 1:nrow(hosp_arr)
        ## IF num equals best
        if(num == "best") {
                ## subset the dataframe by maximum rank
                death_rate <- head(hosp_arr, 1)
                ## ELSE IF num equals worst
        } else if(num == "worst") {
                ## subset the dataframe by minimum rank
                death_rate <- tail(hosp_arr, 1)
                ## ELSE IF num greater than the number of hospitals in the state
        } else if (num > nrow(hosp_arr)) {
                return(NA)
                ## ELSE IF num equals numeric
        } else if(is.numeric(num) == TRUE) {        
                ## subset the datafrane bynum
                death_rate <- hosp_arr[hosp_arr$rank==num, ]
        }
        ## return 30-day death rate 
        death_rate[1,1]
}
rall_list<- lappy(s, function(x, num)) {
if(num == "best") {
        ## return first hospital per state list in split
        return(x$hospital[1])
        ## ELSE IF num equals worst
} else if(num == "worst") {
        ## return last hospital per state list in split
        y <- tail(x,1) 
        return(y$hospital)
        ## ELSE IF num equals numeric
} else if(num == is.numeric(num)) {
        ## return the hospital rank equivelant to num
        return(x$hospital[num]
}
}
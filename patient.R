install.packages("assertive")
library(R6)
library(assertive)

Patient <- R6Class("Patient",
                   private = list(
                     name = NA,
                     age = NA,
                     medical_condition = NA
                   ),
                   public = list(
                     initialize = function(name = NA, age = NA, medical_condition = NA){
                       private$name <- name
                       private$age <- age
                       private$medical_condition <- medical_condition
                     },
                     get_name = function(){
                       if(is.na(private$name)){
                         return("Missing")
                       }
                       return(private$name)
                     },
                     set_name = function(name){
                       private$name <- name
                     },
                     get_age = function(){
                       return(private$age)
                     },
                     set_age = function(age){
                       assert_is_a_number(age)
                       private$age <- age
                     },
                     get_medical_condition = function(){
                       return(private$medical_condition)
                     },
                     set_medical_condition = function(condition){
                       private$medical_condition <- condition
                     }
                   )
)

                     
    
       
    

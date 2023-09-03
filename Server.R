library(shiny)
library(ggplot2)
library(RColorBrewer)

source("Patient.R")

function(input, output, session) {
  rv <- reactiveValues(patients = list())
  
  observeEvent(input$addButton, {
    new_patient <- Patient$new()
    new_patient$set_name(input$nameInput)
    new_patient$set_age(input$ageInput)
    new_patient$set_medical_condition(input$conditionInput)
    rv$patients <- c(rv$patients, list(new_patient))
  })
  
  output$patientTable <- renderTable({
    if (length(rv$patients) > 0) {
      data.frame(
        Name = sapply(rv$patients, function(patient) patient$get_name()),
        Age = sapply(rv$patients, function(patient) patient$get_age()),
        Medical_Condition = sapply(rv$patients, function(patient) patient$get_medical_condition())
      )
    }
  })
  
  output$healthStatusPlot <- renderPlot({
    if(length(rv$patients) > 0) {
      ages <- sapply(rv$patients, function(patient) patient$get_age())
      health_statuses <- sapply(rv$patients, function(patient) patient$get_medical_condition())
      
      patient_data <- data.frame(Age = ages, HealthStatus = health_statuses)
      patient_data$AgeGroup <- cut(patient_data$Age, breaks = c(0, 30, 50, Inf), labels = c('<30', '30-50', '>50'))
      count_data <- as.data.frame(table(patient_data$AgeGroup, patient_data$HealthStatus))
      
      ggplot(count_data, aes(x = Var1, y = Freq, fill = Var2)) +
        geom_bar(stat = "identity", position = "dodge") +
        xlab("Age Group") +
        ylab("Frequency") +
        ggtitle("Distribution of Health Statuses by Age Group") +
        scale_fill_brewer(palette = "Set1")
    }
  })
}




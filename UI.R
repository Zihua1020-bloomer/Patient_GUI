
library(shiny)

fluidPage(
  titlePanel("Hospital GUI"),
  sidebarLayout(
    sidebarPanel(
      textInput("nameInput", "Name:"),
      numericInput("ageInput", "Age:", value = 0),
      selectInput("conditionInput", "Medical Condition:", choices = c("Healthy", "Moderate", "Heavy")),
      actionButton("addButton", "Add Patient")
    ),
    mainPanel(
      tableOutput("patientTable"),
      plotOutput("healthStatusPlot")
    )
  )
)

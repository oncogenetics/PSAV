library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(MASS)
library(markdown)

source("source_UDF.R")

shinyUI(
  
  pageWithSidebar(
    headerPanel(h3("PSA Velocity - v0.2"),windowTitle="PSA Velocity"),
    
    sidebarPanel(
      h4("Data:"),
      helpText("Paste data below without headers and select delimiter. Default field separator is comma."),
      helpText("SampleID,PSA_Date,PSA"),
      #Example input data
      tags$textarea(id="PasteData", rows=10, cols=50, placeholder="SampleID,PSA_Date,PSA",
                    "Sample_1,19/09/2008,0.77
Sample_1,15/01/2010,0.48
Sample_1,11/03/2011,0.7
Sample_1,23/03/2012,0.53
Sample_2,19/09/2008,0.77
Sample_2,15/01/2010,0.48
Sample_3,11/03/2011,0.7"),
      p(),
      #Choose Field separator
      radioButtons("FieldSeparator", 
                   h4("Field Separator:"),
                   list("Comma"=1,"Tab"=2,"Semicolon"=3)),
      p(),
      actionButton("clearTextButton","Clear data")
    ),#pageWithSidebar
    
    mainPanel(
      tabsetPanel(type = "pills",
                  tabPanel("Input Data",
                           helpText("Input Data"),
                           hr(),
                           dataTableOutput("PSAV")),
                  tabPanel("Result",
                           helpText("Result"),
                           hr(),
                           dataTableOutput("PSAV_result"),
                           downloadButton("downloadResult", "Download")),
                  tabPanel("Plot",
                           helpText("Plot"),
                           hr(),
                           uiOutput("SampleID"),
                           hr(),
                           h4("PSA Velocity:"),
                           dataTableOutput("PSAVResultSelected"),
                           hr(),
                           h4("PSA Plot:"),
                           plotOutput("SamplePlot")
                           ),
                  tabPanel("About",
                           helpText("About"),
                           hr(),
                           includeMarkdown("Markdown/README.md"))
      )#tabsetPanel
    )#mainPanel
  )#sidebarPanel
)
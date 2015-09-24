library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(MASS)
library(markdown)

source("source_UDF.R")

shinyUI(
  navbarPage(
    # Application title
    title = "PSA Velocity v0.3",
    windowTitle = "PSA Velocity",
    fluid = FALSE,
    position = "fixed-top",
    inverse = TRUE,
    tabPanel("Data",
             #push it down 70px to avoid going under navbar
             tags$style(type="text/css", "body {padding-top: 70px;}"),
             sidebarPanel(
               h4("Data:"),
               helpText("Paste data below without headers and select delimiter. Default field separator is comma."),
               helpText("SampleID,PSA_Date,PSA"),
               #Example input data
               tags$textarea(id="PasteData", rows=10, cols=30, placeholder="SampleID,PSA_Date,PSA",
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
               helpText("Input Data"),
               hr(),
               dataTableOutput("PSAV"))),
    tabPanel("Result",
             helpText("Result"),
             hr(),
             h4("PSA Velocity"),
             helpText("CONCLUSIONS: Methods used to calculate PSAV using the same PSA data can produce markedly different results. Linear regression should be the method of choice for calculating PSAV. Using first and last PSA values only may be adequate for everyday clinical use, as long as measurements are separated by a sufficiently long time period. - Connolly D., et al.; Eur Urol.2007 Oct; 52(4):1044-50; Epub 2006 Dec 18; PMID: 17197071"),
             hr(),
             dataTableOutput("PSAV_result"),
             downloadButton("downloadResult", "Download")),
    tabPanel("Plot",
             helpText("Plot"),
             hr(),
             h4("PSA Velocity"),
             helpText("CONCLUSIONS: Methods used to calculate PSAV using the same PSA data can produce markedly different results. Linear regression should be the method of choice for calculating PSAV. Using first and last PSA values only may be adequate for everyday clinical use, as long as measurements are separated by a sufficiently long time period. - Connolly D., et al.; Eur Urol.2007 Oct; 52(4):1044-50; Epub 2006 Dec 18; PMID: 17197071"),
             hr(),
             uiOutput("SampleID"),
             dataTableOutput("PSAVResultSelected"),
             hr(),
             h4("PSA Plot:"),
             plotOutput("SamplePlot")),
    tabPanel("About",
             tabsetPanel(tabPanel("About",
                                  helpText("About"),
                                  hr(),
                                  includeMarkdown("README.md")),
                         tabPanel("Poster",
                                  helpText("Poster"),
                                  hr(),
                                  img(src="ECCOPoster2015.PNG", height = 800, width = 1200))))
    )#navbarPage
  )#navbarPage

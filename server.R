shinyServer(
  function(input, output, session) {
    
    #if Clear pressed then clear the text box
    observe({
      if (input$clearTextButton == 0) return()
      isolate({ updateTextInput(session, "PasteData", label = ",", value = "") })
    })
    
    #Input Data Tab --------------------------------------------------------------
    #Convert pasted text into a dataframe
    datPSA <- reactive({
      if(is.null(input$PasteData) |
         input$PasteData=="") {return(NULL)}
      
      mySep <- switch(input$FieldSeparator,
                      '1'=",",'2'="\t",'3'=";")
      
      x <- matrix(strsplit(input$PasteData, "\n")[[1]])
      
      x <- do.call(rbind,
                   lapply(x,function(i){
                     strsplit(i,mySep)[[1]]}))
      
      x <- data.frame(SampleID=x[,1],
                      PSA_Date=as.Date(x[,2],"%d/%m/%Y"),
                      PSA=as.numeric(x[,3]), stringsAsFactors = FALSE)
      return(x)
    })
    
    #Get results using udf_PSAV function
    datPSAResult <- reactive({udf_PSAV(datPSA())})
    
    #Show input data as table on "Input Data" tab
    output$PSAV <- renderDataTable({ datPSA() })
    
    #Result Tab --------------------------------------------------------------
    #Output for "Result" tab
    output$PSAV_result <- renderDataTable({ datPSAResult() })
    
    #Option to download Results
    output$downloadResult <- downloadHandler(
      filename = function() { 
        "PSAV_results.csv" 
      },
      content = function(file) {
        write.csv(datPSAResult(), file,row.names=FALSE)})
    
    #Plot Tab --------------------------------------------------------------
    #Dynamic input - Select Sample for plot
    output$SampleID <- renderUI({
      selectInput("SampleID", h4("Select sample ID:"),
                  choices = sort(unique(datPSA()$SampleID)))
      })
    
    # Plot for selected sample
    output$SamplePlot <- renderPlot({
      d <- datPSA()[ datPSA()$SampleID == input$SampleID,]
      d$FirstLast <- ifelse(d$PSA_Date %in% c(min(d$PSA_Date,na.rm=TRUE),
                                              max(d$PSA_Date,na.rm=TRUE)),1,0)
      ggplot(d,
             aes(x=PSA_Date,y=PSA)) +
        geom_point() +
        geom_line(colour="#A71930") +
        geom_smooth(method=lm,se=FALSE,col="#726E20") +
        geom_line(data=d[ d$FirstLast==1,], aes(x=PSA_Date,y=PSA),col="#003D4C") +
        xlab("PSA Date") +
        ggtitle(input$SampleID) +
        theme_classic()
      
    })
    
    #Pretty output for a selected sample
    output$PSAVResultSelected <- renderDataTable({
      datPSAResult()[datPSAResult()$SampleID==input$SampleID, 2:5] %>% 
        datatable(filter = "none",
                  rownames = FALSE,
                  colnames = c("PSA Count" = 1,
                               "Arithmetic equation (AE)" = 2,
                               "Linear regression (LR)" = 3,
                               "First and last (FL)" = 4),
                  options=list(dom = 't',
                               sort = FALSE,
                               paging = FALSE, 
                               searching = FALSE, 
                               searchable = FALSE)) %>% 
        formatStyle("Linear regression (LR)", backgroundColor="#C9DD03") 
        #formatStyle("Arithmetic equation (AE)", backgroundColor="#E23C57") %>% 
        #formatStyle("First and last (FL)", backgroundColor="#0083A3")
      })
    
    
  }
)#shinyServer
library(data.table)
library(shiny)
library(dplyr)
library(tidyr)

source("data.R")

function(input, output, session) {



#-------------------
# GEI 

contaminante_GEI_reactive <- reactive({
  filter(gei_fin, CONTAMINANTE_GEI == input$select_contaminante_GEI)
  
})

observeEvent(contaminante_GEI_reactive(), {
  choices <- unique(contaminante_GEI_reactive()$SECTOR_GEI)
  updateSelectizeInput(session,"select_sector_GEI", choices = choices)
  
})

sector_GEI_reactive <- reactive({
  req(input$select_sector_GEI)
  filter(contaminante_GEI_reactive(), SECTOR_GEI == input$select_sector_GEI)
  
})

observeEvent(sector_GEI_reactive(), {
  choices <- unique(sector_GEI_reactive()$DIVISION_GEI)
  updateSelectizeInput(session,"select_division_GEI", choices = choices)
})


division_GEI_reactive <- reactive({
  req(input$select_division_GEI)
  filter(contaminante_GEI_reactive(),  DIVISION_GEI == input$select_division_GEI)
  filter(sector_GEI_reactive(),  DIVISION_GEI == input$select_division_GEI)
  ##### kontuz, hemen bi filatan.. geo hiru.. etc 
})

observeEvent(division_GEI_reactive(), {
  choices <- unique(division_GEI_reactive()$CLASS_GEI)
  updateSelectizeInput(session, "select_class_GEI", choices = choices)
})


class_GEI_reactive <- reactive({
  req(input$select_class_GEI)
  filter(contaminante_GEI_reactive(),  CLASS_GEI == input$select_class_GEI)
  filter(sector_GEI_reactive(),  CLASS_GEI == input$select_class_GEI)
  filter(division_GEI_reactive(),  CLASS_GEI == input$select_class_GEI)
  
})

observeEvent(class_GEI_reactive(), {
  choices <- unique(class_GEI_reactive()$SUBCLASS_GEI)
  updateSelectizeInput(session, "select_subclass_GEI", choices = choices)
})


#no hay que hacer un reactive de subclass, ese directamente ira con el output table 
  
 output$data_gei <- renderTable({ 
    req(input$select_subclass_GEI)
    #tab_gei() 
    class_GEI_reactive() %>%
      filter(SUBCLASS_GEI == input$select_subclass_GEI) 
 
    
})
  

 

  
  
}

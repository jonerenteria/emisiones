library(data.table)
library(shiny)
library(dplyr)
library(tidyr)


function(input, output, session) {

source("data.R")

#-------------------
# GEI 
  tab_gei <- reactive({ # <-- Reactive function here
    
    gei_fin %>% 
      filter(CONTAMINANTE == input$selectContaminanteGEI) %>%
      filter(SECTOR == input$selectSectorGEI) %>%
      filter(DIVISION == input$selectDivisionGEI) %>%
      filter(CLASS == input$selectClassGEI) %>%
      filter(SUBCLASS == input$selectSubClassGEI) %>%
      filter( `TIPO DE UNIDAD` == input$selectTDUGEI) %>%
      filter(ANNO %in% input$sliderGEI[1]:input$sliderGEI[2]) 

})
  
  output$data_gei <- renderTable({ 
    
    tab_gei()
    
})
  
## GEI, filter the drop down list when choosing 
  
  gei_sector_choice <- reactive({
    gei_fin %>% 
      filter(CONTAMINANTE == input$selectContaminanteGEI) %>%
      pull(SECTOR)
})
  
  
  gei_division_choice <- reactive({
    gei_fin %>% 
      filter(CONTAMINANTE == input$selectContaminanteGEI) %>%
      filter(SECTOR == input$selectSectorGEI) %>% 
      pull(DIVISION)
})
  
  gei_class_choice <- reactive({
    gei_fin %>% 
      filter(CONTAMINANTE == input$selectContaminanteGEI) %>%
      filter(SECTOR == input$selectSectorGEI) %>% 
      filter(DIVISION == input$selectDivisionGEI) %>%
      pull(CLASS)
})
  
  gei_subclass_choice <- reactive({
    gei_fin %>% 
      filter(CONTAMINANTE == input$selectContaminanteGEI) %>%
      filter(SECTOR == input$selectSectorGEI) %>% 
      filter(DIVISION == input$selectDivisionGEI) %>%
      filter(CLASS == input$selectClassGEI) %>%
      pull(SUBCLASS)
})
  
  
# Observe <---
  observe({
    
    updateSelectizeInput(session, "selectSectorGEI", choices = gei_sector_choice())
    updateSelectizeInput(session, "selectDivisionGEI", choices = gei_division_choice())
    updateSelectizeInput(session, "selectClassGEI", choices = gei_class_choice())
    updateSelectizeInput(session, "selectSubClassGEI", choices = gei_subclass_choice())
    
}) 

#-------------------
# CONTAMINANTES  
  tab_cont <- reactive({ # <-- Reactive function here
    
    cont_fin %>% 
      filter(CONTAMINANTE == input$selectContaminanteCONT) %>%
      filter(SECTOR == input$selectSectorCONT) %>%
      filter(DESCRIPCION == input$selectDescripcionCONT) %>%
      filter(ANNO %in% input$sliderCONT[1]:input$sliderCONT[2]) 
    
})
  
  output$data_cont <- renderTable({ 
    
    tab_cont()
    
})
  
## contaminantes, filter the drop down list when choosing 
  
  cont_sector_choice <- reactive({
    cont_fin %>% 
      filter(CONTAMINANTE == input$selectContaminanteCONT) %>%
      pull(SECTOR)
})
  
  
  cont_act_choice <- reactive({
    cont_fin %>% 
      filter(CONTAMINANTE == input$selectContaminanteCONT) %>%
      filter(SECTOR == input$selectSectorCONT) %>% 
      pull(DESCRIPCION)
})
  
# Observe <---
  observe({
    
    updateSelectizeInput(session, "selectSectorCONT", choices = cont_sector_choice())
    updateSelectizeInput(session, "selectDescripcionCONT", choices = cont_act_choice())
    
}) 
  
#-------------------
# METALES PESADOS  

tab_met <- reactive({ 
    
    met_pes_fin %>% 
      filter(CONTAMINANTE  ==  input$selectContaminanteMET) %>%
      filter(SECTOR  ==  input$selectSectorMET) %>%
      filter(DESCRIPCION  ==  input$selectDescripcionMET) %>%
      filter(ANNO %in% input$sliderMET[1]:input$sliderMET[2])
})
  
output$data_metales <- renderTable({ 
  
  tab_met()
  
})

## metales pesados, filter the drop down list when choosing 

met_sector_choice <- reactive({
  met_pes_fin %>% 
    filter(CONTAMINANTE == input$selectContaminanteMET) %>%
    pull(SECTOR)
})


met_act_choice <- reactive({
  met_pes_fin %>% 
    filter(CONTAMINANTE == input$selectContaminanteMET) %>%
    filter(SECTOR == input$selectSectorMET) %>% 
    pull(DESCRIPCION)
})

# Observe <---
observe({
  
  updateSelectizeInput(session, "selectSectorMET", choices = met_sector_choice())
  updateSelectizeInput(session, "selectDescripcionMET", choices = met_act_choice())
  
})
  
  
}

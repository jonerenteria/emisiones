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
  
#-------------------
# METALES PESADOS  

tab_met <- reactive({ 
    
    met_pes_fin %>% 
      filter(CONTAMINANTE_MET %in% input$selectContaminanteMET) %>%
      filter(SECTOR_MET %in% input$selectSectorMET) %>%
      filter(DESCRIPCION_MET %in% input$selectDescripcionMET) %>%
      filter(ANNO %in% input$sliderMET[1]:input$sliderMET[2])
  })
  
output$data_metales <- renderTable({ 
  
  tab_met()
  
})


lapply(c("data_gei","data_cont", "data_metales"),
       function(x) outputOptions(output, x, suspendWhenHidden = FALSE))   
  
  
}

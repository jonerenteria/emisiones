library(data.table)
library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)

source("data.R")

function(input, output, session) {



#-------------------
# Code for the sidebar GEI 

# -- Contaminante from GEIs
contaminante_GEI_reactive <- reactive({
  filter(gei_fin, CONTAMINANTE_GEI == input$select_contaminante_GEI)
  
})

observeEvent(contaminante_GEI_reactive(), {
  choices <- sort(unique(contaminante_GEI_reactive()$SECTOR_GEI))
  updateSelectizeInput(session,"select_sector_GEI", choices = choices)
  
})

# -- Sector from GEIs
sector_GEI_reactive <- reactive({
  req(input$select_sector_GEI)
  filter(contaminante_GEI_reactive(), SECTOR_GEI == input$select_sector_GEI) 
  
})

observeEvent(sector_GEI_reactive(), {
  choices <- sort(unique(sector_GEI_reactive()$DIVISION_GEI))
  updateSelectizeInput(session,"select_division_GEI", choices = choices)
})

# -- Division from GEIs
division_GEI_reactive <- reactive({
  req(input$select_division_GEI)
  filter(contaminante_GEI_reactive(),  DIVISION_GEI == input$select_division_GEI)
  filter(sector_GEI_reactive(),  DIVISION_GEI == input$select_division_GEI)
})

observeEvent(division_GEI_reactive(), {
  choices <- sort(unique(division_GEI_reactive()$CLASS_GEI))
  updateSelectizeInput(session, "select_class_GEI", choices = choices)
})

# -- Class from GEIs
class_GEI_reactive <- reactive({
  req(input$select_class_GEI)
  filter(contaminante_GEI_reactive(),  CLASS_GEI == input$select_class_GEI)
  filter(sector_GEI_reactive(),  CLASS_GEI == input$select_class_GEI)
  filter(division_GEI_reactive(),  CLASS_GEI == input$select_class_GEI)
  
})

observeEvent(class_GEI_reactive(), {
  choices <- sort(unique(class_GEI_reactive()$SUBCLASS_GEI))
  updateSelectizeInput(session, "select_subclass_GEI", choices = choices)
})

#-------------------
# Code for the mainbar GEI: table

output$data_gei <- renderTable({ 
    req(input$select_subclass_GEI)
    class_GEI_reactive() %>%
      filter(SUBCLASS_GEI == input$select_subclass_GEI) %>%
      rename(SECTOR=SECTOR_GEI,
             DIVISION=DIVISION_GEI,
             CLASS=CLASS_GEI,
             SUBCLASS=SUBCLASS_GEI,
             ANNO=ANNO_GEI,
             CONTAMINANTE=CONTAMINANTE_GEI,
             UNIDAD=UNIDAD_GEI,
             `TIPO DE UNIDAD`=`TIPO DE UNIDAD_GEI`,
             VALOR=VALOR_GEI)

})


  
#-------------------
# Code for the sidebar CONT 

# -- Contaminante from CONT
contaminante_CONT_reactive <- reactive({
  filter(cont_fin, CONTAMINANTE_CONT == input$select_contaminante_CONT)
  
})

observeEvent(contaminante_CONT_reactive(), {
  choices <- sort(unique(contaminante_CONT_reactive()$SECTOR_CONT))
  updateSelectizeInput(session,"select_sector_CONT", choices = choices)
  
})

# -- Sector from CONT
sector_CONT_reactive <- reactive({
  req(input$select_sector_CONT)
  filter(contaminante_CONT_reactive(), SECTOR_CONT == input$select_sector_CONT)
  
})

observeEvent(sector_CONT_reactive(), {
  choices <- sort(unique(sector_CONT_reactive()$DESCRIPCION_CONT))
  updateSelectizeInput(session,"select_descripcion_CONT", choices = choices)
}) 

#-------------------
# Code for the mainbar CONT: table

output$data_cont <- renderTable({ 
  req(input$select_descripcion_CONT)
  sector_CONT_reactive() %>%
    filter(DESCRIPCION_CONT == input$select_descripcion_CONT) %>%
    rename(SECTOR=SECTOR_CONT,
           ACTIVIDAD=ACTIVIDAD_CONT,
           CONTAMINANTE=CONTAMINANTE_CONT,
           DESCRIPCION=DESCRIPCION_CONT,
           ANNO=ANNO_CONT,
           VALOR=VALOR_CONT,
           UNIDAD=UNIDAD_CONT)
})

output$plot_cont <- renderPlot({ 
  
  req(input$select_descripcion_CONT)

  ggplot(data=sector_CONT_reactive() %>%
                      filter(DESCRIPCION_CONT == input$select_descripcion_CONT) %>%
                      rename(SECTOR=SECTOR_CONT,
                             ACTIVIDAD=ACTIVIDAD_CONT,
                             CONTAMINANTE=CONTAMINANTE_CONT,
                             DESCRIPCION=DESCRIPCION_CONT,
                             ANNO=ANNO_CONT,
                             VALOR=VALOR_CONT,
                             UNIDAD=UNIDAD_CONT),aes(x=as.numeric(ANNO),y=VALOR)) +
    geom_point()+
    geom_line()+
    theme_bw()
  
})


#-------------------
# Code for the sidebar MET

# -- Contaminante from MET
contaminante_MET_reactive <- reactive({
  filter(met_pes_fin, CONTAMINANTE_MET == input$select_contaminante_MET)
  
})

observeEvent(contaminante_MET_reactive(), {
  choices <- sort(unique(contaminante_MET_reactive()$SECTOR_MET))
  updateSelectizeInput(session,"select_sector_MET", choices = choices)
  
})

# -- Sector from MET
sector_MET_reactive <- reactive({
  req(input$select_sector_MET)
  filter(contaminante_MET_reactive(), SECTOR_MET == input$select_sector_MET)
  
})

observeEvent(sector_MET_reactive(), {
  choices <- sort(unique(sector_MET_reactive()$DESCRIPCION_MET))
  updateSelectizeInput(session,"select_descripcion_MET", choices = choices)
}) 

#-------------------
# Code for the mainbar MET: table

output$data_met <- renderTable({ 
  req(input$select_descripcion_MET)
  sector_MET_reactive() %>%
    filter(DESCRIPCION_MET == input$select_descripcion_MET) %>%
    rename(SECTOR=SECTOR_MET,
           ACTIVIDAD=ACTIVIDAD_MET,
           CONTAMINANTE=CONTAMINANTE_MET,
           DESCRIPCION=DESCRIPCION_MET,
           ANNO=ANNO_MET,
           VALOR=VALOR_MET,
           UNIDAD=UNIDAD_MET)
})

}

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
      filter(ANNO_GEI %in% input$select_anno_GEI[1]:input$select_anno_GEI[2]) %>%
      filter(`TIPO DE UNIDAD_GEI` == input$select_value_type_GEI) %>%
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
# Code for the mainbar GEI: plot

output$plot_gei <- renderPlot({ 
  
  req(input$select_subclass_GEI)
  
  c<-class_GEI_reactive() %>%
    filter(SUBCLASS_GEI == input$select_subclass_GEI) %>%
    filter(ANNO_GEI %in% input$select_anno_GEI[1]:input$select_anno_GEI[2]) %>%
    filter(`TIPO DE UNIDAD_GEI` == input$select_value_type_GEI) %>%
    rename(SECTOR=SECTOR_GEI,
           DIVISION=DIVISION_GEI,
           CLASS=CLASS_GEI,
           SUBCLASS=SUBCLASS_GEI,
           ANNO=ANNO_GEI,
           CONTAMINANTE=CONTAMINANTE_GEI,
           UNIDAD=UNIDAD_GEI,
           `TIPO DE UNIDAD`=`TIPO DE UNIDAD_GEI`,
           VALOR=VALOR_GEI)  %>%
    mutate(ANNO=as.numeric(as.character(ANNO)))
  
  ggplot(data=c) +
    geom_point(data=c,aes(x=ANNO,y=VALOR),size=5,color="black")+
    geom_line(data=c,size=2,aes(x=ANNO,y=VALOR),color="navyblue")+
    theme_bw()+
    theme(legend.position = "none",
          axis.text.x = element_text(size=10),
          axis.text.y = element_text(size=12),
          axis.title.x = element_text(size=14),
          axis.title.y = element_text(size=14),
          plot.title = element_text(size=16,hjust = 0.5))+
    labs(x="",y=paste0("Emisiones (",unique(c$UNIDAD),";",unique(c$`TIPO DE UNIDAD`),")"))+
    ggtitle(paste0(unique(c$CLASS)," -- ",unique(c$SUBCLASS),": Emisiones de ",unique(c$CONTAMINANTE)," por periodo (",unique(c$UNIDAD),";",unique(c$`TIPO DE UNIDAD`),")"))
  
  
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
    filter(ANNO_CONT %in% input$select_anno_CONT[1]:input$select_anno_CONT[2]) %>%
    rename(SECTOR=SECTOR_CONT,
           ACTIVIDAD=ACTIVIDAD_CONT,
           CONTAMINANTE=CONTAMINANTE_CONT,
           DESCRIPCION=DESCRIPCION_CONT,
           ANNO=ANNO_CONT,
           VALOR=VALOR_CONT,
           UNIDAD=UNIDAD_CONT)
})

#-------------------
# Code for the mainbar CONT: plot

output$plot_cont <- renderPlot({ 
  
  req(input$select_descripcion_CONT)

  a<-sector_CONT_reactive() %>%
    filter(DESCRIPCION_CONT == input$select_descripcion_CONT) %>%
    filter(ANNO_CONT %in% input$select_anno_CONT[1]:input$select_anno_CONT[2]) %>%
    rename(SECTOR=SECTOR_CONT,
           ACTIVIDAD=ACTIVIDAD_CONT,
           CONTAMINANTE=CONTAMINANTE_CONT,
           DESCRIPCION=DESCRIPCION_CONT,
           ANNO=ANNO_CONT,
           VALOR=VALOR_CONT,
           UNIDAD=UNIDAD_CONT) %>%
    mutate(ANNO=as.numeric(as.character(ANNO)))
  
  ggplot(data=a) +
    geom_point(data=a,aes(x=ANNO,y=VALOR),size=5,color="black")+
    geom_line(data=a,aes(x=ANNO,y=VALOR),size=2,color="navyblue")+
    theme_bw()+
    theme(legend.position = "none",
          axis.text.x = element_text(size=10),
          axis.text.y = element_text(size=12),
          axis.title.x = element_text(size=14),
          axis.title.y = element_text(size=14),
          plot.title = element_text(size=16,hjust = 0.5))+
    labs(x="",y=paste0("Emisiones (",unique(a$UNIDAD),")"))+
    ggtitle(paste0(unique(a$DESCRIPCION),": Emisiones de ",unique(a$CONTAMINANTE)," por periodo (",unique(a$UNIDAD),")"))
  
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
    filter(ANNO_MET %in% input$select_anno_MET[1]:input$select_anno_MET[2]) %>%
    rename(SECTOR=SECTOR_MET,
           ACTIVIDAD=ACTIVIDAD_MET,
           CONTAMINANTE=CONTAMINANTE_MET,
           DESCRIPCION=DESCRIPCION_MET,
           ANNO=ANNO_MET,
           VALOR=VALOR_MET,
           UNIDAD=UNIDAD_MET) 
})

#-------------------
# Code for the mainbar MET: plot

output$plot_met <- renderPlot({ 
  
  req(input$select_descripcion_MET)
  
  b<-sector_MET_reactive() %>%
    filter(DESCRIPCION_MET == input$select_descripcion_MET) %>%
    filter(ANNO_MET %in% input$select_anno_MET[1]:input$select_anno_MET[2]) %>%
    rename(SECTOR=SECTOR_MET,
           ACTIVIDAD=ACTIVIDAD_MET,
           CONTAMINANTE=CONTAMINANTE_MET,
           DESCRIPCION=DESCRIPCION_MET,
           ANNO=ANNO_MET,
           VALOR=VALOR_MET,
           UNIDAD=UNIDAD_MET) %>%
    mutate(ANNO=as.numeric(as.character(ANNO)))
  
  ggplot(data=b) +
    geom_point(data=b,aes(x=ANNO,y=VALOR),size=5,color="black")+
    geom_line(data=b,aes(x=ANNO,y=VALOR),size=2,color="navyblue")+
    theme_bw()+
    theme(legend.position = "none",
          axis.text.x = element_text(size=10),
          axis.text.y = element_text(size=12),
          axis.title.x = element_text(size=14),
          axis.title.y = element_text(size=14),
          plot.title = element_text(size=16,hjust = 0.5))+
    labs(x="",y=paste0("Emisiones (",unique(b$UNIDAD),")"))+
    ggtitle(paste0(unique(b$DESCRIPCION),": Emisiones de ",unique(b$CONTAMINANTE)," por periodo (",unique(b$UNIDAD),")"))
  
})


}

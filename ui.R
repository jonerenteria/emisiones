
source("data.R")

fluidPage(
  
  theme = "https://stackpath.bootstrapcdn.com/bootswatch/3.4.1/spacelab/bootstrap.min.css",
  titlePanel("Inventario Nacional de Emisiones"),
  
  
  tabsetPanel(
    tabPanel("GEI: Gases de efecto invernadero",  
             sidebarPanel(h2("Gases de efecto invernadero"), h5("Por favor, seleccione las opciones que desee"),
                        selectizeInput('select_contaminante_GEI', 'Contaminante', choices = unique(gei_fin$CONTAMINANTE_GEI)),
                        selectizeInput('select_sector_GEI', "Sector", choices = NULL), 
                        selectizeInput('select_division_GEI', "Division", choices = NULL), 
                        selectizeInput('select_class_GEI', "Class", choices = NULL),
                        selectizeInput('select_subclass_GEI', "Subclass", choices = NULL), 
                        radioButtons("select_value_type_GEI", "Tipo de valor", choices = c("EM", "CO2-Eq"), selected = NULL), 
                        sliderInput("select_anno_GEI", "Rango de anno", min = as.numeric(min(levels(gei_fin$ANNO_GEI))) , max = as.numeric(max(levels(gei_fin$ANNO_GEI))), 
                                    value =  c(as.numeric(min(levels(gei_fin$ANNO_GEI))), as.numeric(max(levels(gei_fin$ANNO_GEI))))), 
                        
                        width = 3
             
                        
                        
                        ),
                          
             mainPanel(
               
               DT::DTOutput("data_gei"),
               downloadButton("download_gei_table", "Descargar-Tabla", style = "color: #fff; background-color: black	; border-color: #fff"),
               plotOutput("plot_gei"), 
               downloadButton("download_gei_plot", "Descargar-Grafico", style = "color: #fff; background-color: black; border-color: #fff")
             )),  
    
    
    tabPanel("Contaminantes", 
            sidebarPanel(h2("Contaminantes"), h5("Por favor, seleccione las opciones que desee"),
                         selectizeInput('select_contaminante_CONT', 'Contaminante', choices = unique(cont_fin$CONTAMINANTE_CONT)),
                         selectizeInput('select_sector_CONT', "Sector", choices = NULL), 
                         selectizeInput('select_descripcion_CONT', "Descripcion", choices = NULL), 
                         sliderInput("select_anno_CONT", "Rango de anno", min = as.numeric(min(levels(cont_fin$ANNO_CONT))) , max = as.numeric(max(levels(cont_fin$ANNO_CONT))), 
                                     value =  c(as.numeric(min(levels(cont_fin$ANNO_CONT))), as.numeric(max(levels(cont_fin$ANNO_CONT))))), 
                         width = 3
                         
            ),
  
            mainPanel(
              
              DT::DTOutput("data_cont"),
              downloadButton("download_cont_table", "Descargar-Tabla", style = "color: #fff; background-color: black	; border-color: #fff"),
              plotOutput("plot_cont"), 
              downloadButton("download_cont_plot", "Descargar-Grafico", style = "color: #fff; background-color: black; border-color: #fff")
              
            )), 

    
    tabPanel("Metales pesados",
            sidebarPanel(h2("Metales pesados"), h5("Por favor, seleccione las opciones que desee"),
                         selectizeInput('select_contaminante_MET', 'Contaminante', choices = unique(met_pes_fin$CONTAMINANTE_MET)),
                         selectizeInput('select_sector_MET', "Sector", choices = NULL), 
                         selectizeInput('select_descripcion_MET', "Descripcion", choices = NULL), 
                         sliderInput("select_anno_MET", "Rango de anno", min = as.numeric(min(levels(met_pes_fin$ANNO_MET))) , max = as.numeric(max(levels(met_pes_fin$ANNO_MET))), 
                                     value =  c(as.numeric(min(levels(met_pes_fin$ANNO_MET))), as.numeric(max(levels(met_pes_fin$ANNO_MET))))), 
                         width = 3
                        
                      
           ), 
         
           mainPanel(
             
             DT::DTOutput("data_met"),
             downloadButton("download_met_table", "Descargar-Tabla", style = "color: #fff; background-color: black	; border-color: #fff"),
             plotOutput("plot_met"), 
             downloadButton("download_met_plot", "Descargar-Grafico", style = "color: #fff; background-color: black; border-color: #fff")
             
           ))

)

)





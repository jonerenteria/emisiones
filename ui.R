
navbarPage(
  
  titlePanel("Shinny App Emisiones"),
  
  tabsetPanel(
    tabPanel("Panel1_gei",  
             sidebarPanel(h2("GEI"),
                        selectizeInput('select_contaminante_GEI', 'Contaminante', choices = unique(gei_fin$CONTAMINANTE_GEI)),
                        selectizeInput('select_sector_GEI', "Sector", choices = NULL), 
                        selectizeInput('select_division_GEI', "Division", choices = NULL), 
                        selectizeInput('select_class_GEI', "Class", choices = NULL),
                        selectizeInput('select_subclass_GEI', "Subclass", choices = NULL), 
                        radioButtons("select_value_type_GEI", "Tipo de valor", choices = c("EM", "CO2-Eq"), selected = NULL), 
                        sliderInput("select_anno_GEI", "Rango de año", min = as.numeric(min(levels(gei_fin$ANNO_GEI))) , max = as.numeric(max(levels(gei_fin$ANNO_GEI))), 
                                    value =  c(as.numeric(min(levels(gei_fin$ANNO_GEI))), as.numeric(max(levels(gei_fin$ANNO_GEI)))))
             ),
                          
             mainPanel(
               
               tableOutput("data_gei"),plotOutput("plot_gei")
             )),  
    
    
    tabPanel("Panel2_cont", 
            sidebarPanel(h2("CONT"),
                         selectizeInput('select_contaminante_CONT', 'Contaminante', choices = unique(cont_fin$CONTAMINANTE_CONT)),
                         selectizeInput('select_sector_CONT', "Sector", choices = NULL), 
                         selectizeInput('select_descripcion_CONT', "Descripción", choices = NULL), 
                         sliderInput("select_anno_CONT", "Rango de año", min = as.numeric(min(levels(cont_fin$ANNO_CONT))) , max = as.numeric(max(levels(cont_fin$ANNO_CONT))), 
                                     value =  c(as.numeric(min(levels(cont_fin$ANNO_CONT))), as.numeric(max(levels(cont_fin$ANNO_CONT)))))
                         
            ),
  
            mainPanel(
              
              tableOutput("data_cont"),plotOutput("plot_cont")
            )), 

    
    tabPanel("Panel3_met",
            sidebarPanel(h2("METALES"),
                         selectizeInput('select_contaminante_MET', 'Contaminante', choices = unique(met_pes_fin$CONTAMINANTE_MET)),
                         selectizeInput('select_sector_MET', "Sector", choices = NULL), 
                         selectizeInput('select_descripcion_MET', "Descripción", choices = NULL), 
                         sliderInput("select_anno_MET", "Rango de año", min = as.numeric(min(levels(met_pes_fin$ANNO_MET))) , max = as.numeric(max(levels(met_pes_fin$ANNO_MET))), 
                                     value =  c(as.numeric(min(levels(met_pes_fin$ANNO_MET))), as.numeric(max(levels(met_pes_fin$ANNO_MET)))))
                        
                      
           ), 
         
           mainPanel(
             
             tableOutput("data_met"),plotOutput("plot_met")
           ))

)

)





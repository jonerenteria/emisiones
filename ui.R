
navbarPage(
  
  titlePanel("Shinny App Emisiones"),
  
  tabsetPanel(
    tabPanel("Panel1_gei",  
             sidebarPanel(h2("GEI"),
                        selectizeInput('select_contaminante_GEI', 'Contaminante', choices = unique(gei_fin$CONTAMINANTE_GEI)),
                        selectizeInput('select_sector_GEI', "Sector", choices = NULL), 
                        selectizeInput('select_division_GEI', "Division", choices = NULL), 
                        selectizeInput('select_class_GEI', "Class", choices = NULL),
                        selectizeInput('select_subclass_GEI', "Subclass", choices = NULL)
             ),
                          
             mainPanel(
               
               tableOutput("data_gei")
             )),  
    
    
    tabPanel("Panel2_cont", 
            sidebarPanel(h2("CONT"),
                         selectizeInput('select_contaminante_CONT', 'Contaminante', choices = unique(cont_fin$CONTAMINANTE_CONT)),
                         selectizeInput('select_sector_CONT', "Sector", choices = NULL), 
                         selectizeInput('select_descripcion_CONT', "Descripción", choices = NULL) 
                         
            ),
  
            mainPanel(
              
              tableOutput("data_cont")
            )), 

    
    tabPanel("Panel3_met",
            sidebarPanel(h2("METALES"),
                         selectizeInput('select_contaminante_MET', 'Contaminante', choices = unique(met_pes_fin$CONTAMINANTE_MET)),
                         selectizeInput('select_sector_MET', "Sector", choices = NULL), 
                         selectizeInput('select_descripcion_MET', "Descripción", choices = NULL)
                        
                      
           ), 
         
           mainPanel(
             
             tableOutput("data_met")   
           ))

)

)





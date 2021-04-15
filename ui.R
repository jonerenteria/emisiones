
navbarPage(
  
  titlePanel("Shinny App Emisiones"),
  
  tabsetPanel(
    tabPanel("Panel1_gei",  
             sidebarPanel(h2("GEI"),
                        selectizeInput('select_contaminante_GEI', 'Contaminante', choices = unique(gei_fin$CONTAMINANTE_GEI)),
                        selectizeInput('select_sector_GEI', "Sector", choices = NULL), 
                        selectizeInput('select_division_GEI', "DIVISION", choices = NULL), 
                        selectizeInput('select_class_GEI', "CLASS", choices = NULL),
                        selectizeInput('select_subclass_GEI', "SUBCLASS", choices = NULL)
             ),
                          
             mainPanel(
               
               tableOutput("data_gei")
             )),  
    
    
    tabPanel("Panel2_cont", 
            sidebarPanel(h2("CONT"),
                         uiOutput('select_contaminante_CONT')
                         
            ),
  
            mainPanel(
              
              tableOutput("data_cont")
            )), 

    
    tabPanel("Panel3_met",
            sidebarPanel(h2("METALES"),
                         uiOutput("select_contaminante_MET")
                        
                      
           ), 
         
           mainPanel(
             
             tableOutput("data_metales")   
           ))

)

)






navbarPage(
  
  titlePanel("Shinny App Emisiones"),
  
  tabsetPanel(
    tabPanel("Panel1_gei",  
             sidebarPanel(h2("GEI"),
                          selectizeInput('selectContaminanteGEI', 'Contaminante', choices = levels(gei_fin$CONTAMINANTE)),
                          selectizeInput('selectSectorGEI', 'Sector', choices = levels(gei_fin$SECTOR)), 
                          selectizeInput('selectDivisionGEI', 'DIVISION', choices = levels(gei_fin$DIVISION)),
                          selectizeInput('selectClassGEI', 'CLASS', choices = levels(gei_fin$CLASS)),
                          selectizeInput('selectSubClassGEI', 'SUBCLASS', choices = levels(gei_fin$SUBCLASS)), 
                          radioButtons("selectTDUGEI", "Tipo de Unidad",choices = levels(gei_fin$`TIPO DE UNIDAD`)), 
                          sliderInput("sliderGEI", label = h3("Rango fechas"), min = min(as.numeric(as.character(gei_fin$ANNO))), 
                                      max = max(as.numeric(as.character(gei_fin$ANNO))), 
                                      value = c(min(as.numeric(as.character(gei_fin$ANNO))), max(as.numeric(as.character(gei_fin$ANNO)))))
             
             ),
                          
             mainPanel(
               
               tableOutput("data_gei")
             )),  
    
    
    tabPanel("Panel2_cont", 
            sidebarPanel(h2("CONT"),
                         selectizeInput('selectContaminanteCONT', 'Contaminante', choices = levels(cont_fin$CONTAMINANTE)),
                         selectizeInput('selectSectorCONT', 'Sector', choices = levels(cont_fin$SECTOR)), 
                         selectizeInput('selectDescripcionCONT', 'Actividad', choices = levels(cont_fin$DESCRIPCION)), 
                         sliderInput("sliderCONT", label = h3("Rango fechas"), min = min(as.numeric(as.character(cont_fin$ANNO))), 
                                     max = max(as.numeric(as.character(cont_fin$ANNO))), 
                                     value = c(min(as.numeric(as.character(cont_fin$ANNO))), max(as.numeric(as.character(cont_fin$ANNO)))))
            ),
  
            mainPanel(
              
              tableOutput("data_cont")
            )), 

    
    tabPanel("Panel3_met",
            sidebarPanel(h2("METALES"),
                        selectizeInput("selectContaminanteMET","seleccione el metal pesado", choices = levels(met_pes_fin$CONTAMINANTE)),
                        selectizeInput("selectSectorMET", "Sector", choices = levels(met_pes_fin$SECTOR)), 
                        selectizeInput("selectDescripcionMET","Actividad",  choices = levels(met_pes_fin$DESCRIPCION)),  
                        sliderInput("sliderMET", label = h3("Rango fechas"), min = min(as.numeric(as.character(met_pes_fin$ANNO))), 
                                   max = max(as.numeric(as.character(met_pes_fin$ANNO))), 
                                   value = c(min(as.numeric(as.character(met_pes_fin$ANNO))), max(as.numeric(as.character(met_pes_fin$ANNO)))))
                      
           ), 
         
           mainPanel(
             
             tableOutput("data_metales")   
           ))

)

)





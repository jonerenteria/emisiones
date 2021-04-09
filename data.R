library(dplyr)
library(tidyr)

## Data loading
# ---
url1 <- "https://www.miteco.gob.es/es/calidad-y-evaluacion-ambiental/temas/sistema-espanol-de-inventario-sei-/webtabla-inv_tcm30-506253.xlsx"
httr::GET(url1,  httr::write_disk(tf <- tempfile(fileext = ".xlsx")))
em <- readxl::read_excel(tf, sheet = "Total GEI por gas y sector")

sector_map <- readxl::read_excel(tf, sheet = "IPCC_SUBACTIVITIES") %>%
  unite(c("IPCC_SECTOR", "IPCC_DIVISION", "IPCC_CLASS","IPCC_SUBCLASS","IPCC_ACTIVITY","IPCC_SUBACTIVITY"), col = "UNITED", sep = "", remove = FALSE) 
  # las emisiones LUC por tierras convertidas a otras tierras no est?n estructuradas correctamente y hay que ajustarlo a mano.
  # En el inventario ya est? desagregado por IPCC_Subactivity ("Direct N2O mineralization" y "Biomass burning-Wild") pero no muestra el subtotal de "IPCC_SUBCLASS"
  
land_converted<-data.frame(ACTIVITY=rep(NA,6), IPCC_SECTOR=rep(4,6),IPCC_DIVISION=c("A","B","C","D","E","F"),IPCC_CLASS=rep(2,6),IPCC_SUBCLASS=as.character(rep(0,6)),IPCC_ACTIVITY=rep(NA,6),IPCC_SUBACTIVITY=rep(NA,6),
                           UNITED=c("4A20NANA","4B20NANA","4C20NANA","4D20NANA","4E20NANA","4F20NANA"),
                           DESCRIPTION=c("Land converted to Forest land",
                                         "Land converted to Cropland",
                                         "Land converted to Grassland",
                                         "Land converted to Wetlands",
                                         "Land converted to Settlements",
                                         "Land converted to Other land"))

sector_map<- bind_rows(sector_map,land_converted)


cont <- readxl::read_excel(tf, sheet ="Contaminantes Total Nacional")
# ---


em_em<- em %>%
  select(starts_with("EM"), SECCION,IPCC_SECTOR, IPCC_DIVISION, IPCC_CLASS,IPCC_SUBCLASS, CONTAMINANTE, UNIDAD) %>%
  gather(year, value_em, -SECCION,-IPCC_SECTOR, -IPCC_DIVISION, -IPCC_CLASS, -IPCC_SUBCLASS,  -CONTAMINANTE, -UNIDAD ) %>%
  mutate(year = gsub('EM','', year)) %>%
  group_by(IPCC_SECTOR, IPCC_DIVISION, IPCC_CLASS,IPCC_SUBCLASS, CONTAMINANTE, UNIDAD, year) %>%
  summarise(value_em = sum(value_em)) %>%
  ungroup()

em_eq<- em %>%
  select(starts_with("CO2EQ"), SECCION,IPCC_SECTOR, IPCC_DIVISION,IPCC_CLASS,IPCC_SUBCLASS,  CONTAMINANTE, UNIDAD) %>%
  gather(year, value_eq, -SECCION,-IPCC_SECTOR, -IPCC_DIVISION, -IPCC_CLASS, -IPCC_SUBCLASS, -CONTAMINANTE, -UNIDAD ) %>%
  mutate(year = gsub('CO2EQ','', year)) %>%
  group_by(IPCC_SECTOR, IPCC_DIVISION,IPCC_CLASS,IPCC_SUBCLASS, CONTAMINANTE, UNIDAD, year) %>%
  summarise(value_eq = sum(value_eq)) %>%
  ungroup()

em_all <- em_em %>%
  gcamdata::left_join_error_no_match(em_eq, by=c("IPCC_SECTOR", "IPCC_DIVISION", "CONTAMINANTE","IPCC_CLASS","IPCC_SUBCLASS", "UNIDAD", "year"))



em.all.list <- split(em_all, em_all$CONTAMINANTE)


obtener_coef <- function(df){
  colnames(df) <- c("IPCC_SECTOR", "IPCC_DIVISION","IPCC_CLASS","IPCC_SUBCLASS", "CONTAMINANTE", "UNIDAD", "year", "value_em", "value_eq")
  
  df <- df %>%
    mutate(coef = round(value_eq/ value_em, 5), 
           coef2 = if_else(coef=='NaN', -100, coef), 
           coef3 = max(coef2)) %>%
    select(-coef2, -coef) %>%
    rename(coef = coef3)
  
  invisible(df)
  
}

em_fin<-tibble::as_tibble(as.data.frame(bind_rows(lapply(em.all.list, obtener_coef))))  %>%
  mutate(SECTOR=paste0(IPCC_SECTOR, "NANANANANA"), 
         DIVISION = paste0(IPCC_SECTOR, IPCC_DIVISION, "NANANANA"),
         CLASS = paste0(IPCC_SECTOR, IPCC_DIVISION, IPCC_CLASS,"NANANA"),
         SUBCLASS = paste0(IPCC_SECTOR, IPCC_DIVISION,IPCC_CLASS,IPCC_SUBCLASS, "NANA")) %>%
  gcamdata::left_join_error_no_match(sector_map %>% select(UNITED,DESCRIPTION) %>% rename(SECTOR=UNITED), by="SECTOR") %>%
  select(-SECTOR) %>%
  rename(SECTOR=DESCRIPTION) %>%
  gcamdata::left_join_error_no_match(sector_map %>% select(UNITED,DESCRIPTION) %>% rename(DIVISION=UNITED), by="DIVISION") %>%
  select(-DIVISION) %>%
  rename(DIVISION=DESCRIPTION) %>%
  gcamdata::left_join_error_no_match(sector_map %>% select(UNITED,DESCRIPTION) %>% rename(CLASS=UNITED), by="CLASS") %>%
  select(-CLASS) %>%
  rename(CLASS=DESCRIPTION) %>%
  gcamdata::left_join_error_no_match(sector_map %>% select(UNITED,DESCRIPTION) %>% rename(SUBCLASS=UNITED), by="SUBCLASS") %>%
  select(-SUBCLASS) %>%
  rename(SUBCLASS=DESCRIPTION) %>%
  rename(ANNO = year) %>%
  mutate(TIPO = "GEI") %>%
  select(SECTOR, DIVISION,CLASS, SUBCLASS, CONTAMINANTE, ANNO, value_em, value_eq, UNIDAD, coef )  %>%
  mutate(ANNO=as.factor(as.character(ANNO))) %>%
  mutate_if(is.character, as.factor)

summary_cof <- em_fin %>%
  group_by(CONTAMINANTE) %>%
  summarise(coef=mean(coef)) %>%
  ungroup()


gei_fin<-em_fin %>%
  select(-coef) %>%
  gather(`TIPO DE UNIDAD`,VALOR,-SECTOR,-DIVISION,-CONTAMINANTE,-CLASS,-SUBCLASS,-ANNO,-UNIDAD) %>%
  mutate(`TIPO DE UNIDAD`=gsub("value_em","EM",`TIPO DE UNIDAD`),
         `TIPO DE UNIDAD`=gsub("value_eq","CO2-Eq",`TIPO DE UNIDAD`),
         `TIPO DE UNIDAD`=as.factor(`TIPO DE UNIDAD`))




# --------------------------------------------------------
# data cleaning CONT

cont_adj<- cont %>%
  select(-DIOX, -BEN_A_PI, -BEN_B_FL, -BEN_K_FL, -INDENO, -PAH, -HCB,
         -PCB, -LIQUID_FUELS, -SOLID_FUELS,-GAS_FUELS, -BIOMASS, -OTHER_FUELS, -OTHERACTIVITY, -OTHER_ACTIVITY_UNITS) %>%
  gather (CONTAMINANTE, value,-SECTOR, -ANNO, -ACTIVIDAD, - DESCRIPCION) %>%
  mutate(TIPO = if_else(CONTAMINANTE %in% c("NO2", "NMVOC","SOX", "NH3", "PM2_5", "PM10", "TSP", "BC", "CO"), "CONT", "MET.PESADO")) %>%
  arrange(SECTOR,ACTIVIDAD) %>%
  mutate(UNIDAD = if_else(TIPO == "CONT", "kt", "t")) %>%
  select(TIPO, SECTOR, ACTIVIDAD,DESCRIPCION ,CONTAMINANTE, ANNO, value, UNIDAD ) %>%
  rename(VALOR = value)

cont_fin<-tibble::as_tibble(cont_adj) %>% filter(TIPO=="CONT") %>%
  select(-TIPO) %>%
  mutate(CONTAMINANTE = as.factor(CONTAMINANTE), 
         SECTOR = as.factor(SECTOR),
         DESCRIPCION = as.factor(DESCRIPCION),
         ANNO=as.factor(as.character(ANNO)),
         UNIDAD = as.factor(UNIDAD))


met_pes_fin<-as.data.frame(cont_adj) %>% filter(TIPO=="MET.PESADO") %>%
  select(-TIPO) %>%
  mutate(ANNO=as.factor(as.character(ANNO)),
         CONTAMINANTE=as.factor(CONTAMINANTE),
         SECTOR=as.factor(SECTOR)) %>%
  mutate(DESCRIPCION=as.factor(DESCRIPCION)) %>%
  rename(CONTAMINANTE_MET=CONTAMINANTE,
         SECTOR_MET=SECTOR,
         DESCRIPCION_MET=DESCRIPCION)


### test para git
# --------------------------------------------------------






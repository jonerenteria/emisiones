<!-- ------------------------>
<!-- ------------------------>
# <a name="[Descripción]"></a>Descripción
<!-- ------------------------>
<!-- ------------------------>

La herramienta de visualización de datos desarrollada en R Shiny se genera a partir de los datos sobre emisiones de gases de efecto invernadero (GEIs) y contaminantes atmosféricos que el Ministerio para la Transición Ecológica y el Reto Demográfico presenta anualmente. La web, directamente enlazada con el último inventario publicado por el Ministerio, y correspondiente con la serie 1990-2019, tiene como objetivo proporcionar al usuario una interfaz sencilla que facilite la búsqueda de datos relacionados con los GEIs, Contaminantes Atmosféricos y Metales Pesados. 
La aplicación facilita al usuario la opción de filtrar la búsqueda de datos de una manera interactiva para cada uno de los bloques, mostrando los datos en formato de tablas y gráficos, y permitiendo además la descarga de los mismos tras realizar la selección. 
La nomenclatura utilizada para cada uno de los bloques no ha sido modificada del Inventario Nacional, por lo que los nombres utilizados para las emisiones, sectores, clases…etc. es la misma que en la tabla presentada por el Ministerio en su web.  
Es posible acceder a la aplicación de dos formas diferentes: la primera, y la más sencilla, accediendo al siguiente enlace: ….. y la segunda, siguiendo la guía de instalación presentada a continuación. 


<!-- ------------------------>
<!-- ------------------------>
# <a name="[Guía de instalación]"></a>Guía de instalación
<!-- ------------------------>
<!-- ------------------------>

1.	Descargue e instale: 
•	R (https://www.r-project.org/)
•	R studio (https://www.rstudio.com/)

2.	En R studio, instale los siguientes paquetes: 
```r
   install.packages(c(“devtools”, “shiny”,” DT”,” grDevices” “dplyr”, “tidyr”, “ggplot2”)
```

3.	Descargue la aplicación utilizando el siguiente código en su consola: 

```r
   devtools::install_github(“jonerenteria/emisiones”)
```

4.	Abra los archivos ui.R y server.R del proyecto “emisiones”, y haga click en Run App. 

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

1. Descargue e instale: 

      + R (https://www.r-project.org/)
      + RStudio (https://www.rstudio.com/)

2. En RStudio, asegurese de tener los siguientes paquetes instalados:  

```r
   install.packages(c(“shiny”,” DT”,” grDevices” “dplyr”, “tidyr”, “ggplot2”))
```

3. En RStudio, comience un nuevo proyecto: File > New Project > Version Control > Git. En el recuadro *repository URL*, pegue el URL del repositorio de GitHub: https://github.com/jonerenteria/emisiones.git. 

Es recomendable que guarde el proyecto en un directorio local de su ordenador y que abra el proyecto en una nueva sesión (*Open in new session*) seleccionando esta opción en el recuadro de la pantalla emergente. Finalmente, haga clic en *Create Project*. 

4. El proyecto se abrirá automáticamente, y para acceder a la aplicación, debe escribir lo siguiente en la consola: 

```r
   shiny::runApp()
```

5. La aplicación se abrira en su computadora. Podrá visualizar la aplicación en su navegador, haciendo clic en el recuadro *Open in Browser*, situado arriba a la izquierda de la pantalla. 

6. Para los siguientes usos de la app, simplemente abra el proyecto que ha guardado en su computadora y vuelva a escribir el código mostrado en el cuarto punto de esta guía.  

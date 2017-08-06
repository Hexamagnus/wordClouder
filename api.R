install.packages("png")
# library(jsonlite)
library(httr)
library(wordcloud2)
# library(plumber)
library(htmlwidgets)
library(png)
library(webshot)
library(readr)


#* @get /generarNube
#* @png
generarNube <- function(texto) {
  
  solicitud <- POST(url="https://5e79bb3b.ngrok.io/summarize",body = list("article" = texto))
  respuesta <- content(solicitud)
  palabras<- names(respuesta$frequency)
  frequency <- data.frame(word = palabras, freq=unlist(respuesta$frequency))
  rownames(frequency) <- NULL
  
  img <- wordcloud2(frequency)
  # webshot::install_phantomjs()
  setwd("./")
  saveWidget(img,"1.html",selfcontained = F) 
  # webshot::webshot("1.html","1.png",vwidth = 1992, vheight = 1744, delay =0.2)
  # salida<-readPNG("1.png")
  webshot::webshot("1.html","1.png",vwidth = 1992, vheight = 1744, delay =0.5)
  #retorno <- readr::read_file("1.png")
  #return (retorno)
  
  ima <- readPNG("1.png")
  #return(x)
  #plot(cars)
  
  #Set up the plot area
  plot(1:2, type='n', main="Plotting Over an Image", xlab="x", ylab="y")
  
  #Get the plot information so the image will fill the plot box, and draw it
  lim <- par()
  rasterImage(ima, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
  grid()
  lines(c(1, 1.2, 1.4, 1.6, 1.8, 2.0), c(1, 1.3, 1.7, 1.6, 1.7, 1.0), type="b", lwd=5, col="white")
}


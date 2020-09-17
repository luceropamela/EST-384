#----------- Tarea 1 EST-384 -----------#
#Importe la base de datos actual sobre el COVID-19 de la página: https://www.worldometers.info/coronavirus/ a partir de ella:
  
#1) Seleccione la información de sólo los países
#2) Según la naturaleza de las variables, realice los cambios correspondientes para garantizar el uso correcto de ellas
#3) Guarde la base de datos

library(rvest)
info<-"https://www.worldometers.info/coronavirus/"
www<-read_html(info)
tablas<-html_table(www)
now<-tablas[[1]] 
head(now)
names(now)
library(dplyr)
now<-now %>% mutate_all(funs(gsub(",","", .)))
now<-now %>% mutate_all(funs(gsub("\\+","", .)))

# 1) Seleccionando solo los paises
names(now)[1]<-"id"
now<-now[!is.na(now$id),]

# 2) volviendolas numericas
now$TotalCases<-as.numeric(now$TotalCases,na.rm=T)
num<-c(1,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,19)
now[num]<-now %>% select(1,3:15,17:19) %>%  mutate_if(is.character,as.numeric) 
str(now)


# 3) Guardando la base de datos
setwd("C:\\Users\\JULIA\\Documents\\PAMELA\\R Segundo semestre\\BASES DE DATOS")
save(now,file = "now.RData")
load("now.RData")


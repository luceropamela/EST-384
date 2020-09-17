##---------------- tarea 2 EST-384 ---------------------##
#1) Importación a R considerando las celdas A5:R14
#2) Eliminar las filas sin información y la fila del total 
#3) Realizar el reshape 

setwd("C:\\Users\\JULIA\\Documents\\PAMELA\\R Segundo semestre\\BASES DE DATOS")
dir()
# 1)
library(readxl)
bd<-read_excel("C070311.xls",range = "A5:R14" )

# 2)
bd<-bd[!is.na(bd$DESCRIPCIÓN),]
bd<-bd[bd$DESCRIPCIÓN!="TOTAL",]
names(bd)

# 3)
bd2<-reshape(bd,idvar = names(bd)[1],varying = names(bd)[-1],
             v.names = "Nro_Titulados",timevar = "Año",
             times = names(bd)[-1],new.row.names = 1:1000,
             split = ".",direction = "long")

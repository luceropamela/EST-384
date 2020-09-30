#----------------- Tarea 3 EST-384 ----------------------------
#Usando la encuesta a hogares 2019, genere la siguiente tabla: 
#Promedio de ingreso laboral de las personas mayores de 17 años por departamento, 
#área y sexo. Considere:
  
#1. Tabla sobre los datos a nivel muestral
#2. Tabla sobre los datos considerando el diseño muestral, incluya los efectos de 
#diseño y los coeficientes de variación
setwd("C:\\Users\\JULIA\\Documents\\PAMELA\\R Segundo semestre\\BASES DE DATOS")
dir()
# Encuesta a hogares 2019
load("eh19.RData")
names(eh19p)
## nivel muestral

library(dplyr)
t1<-eh19p %>% filter(s02a_03>17) 
t1<-t1 %>% group_by(departamento=depto,area=area,sexo=s02a_02) %>%  summarise(media_ingreso_laboral=mean(ylab,na.rm=T))
t1

# con diseño muestral incluido el efecto de diseño y su coeficiente de variacion
library(survey)
sd_ehq9p<-svydesign(ids = ~upm,strata = ~estrato,weights = ~factor,data = eh19p)
library(srvyr)
dm<-as_survey_design(sd_ehq9p)

tds<- dm %>% filter(s02a_03>17)
td<- tds %>% group_by(departamento=depto,area=area,sexo=s02a_02) %>% summarise(m_ylab=survey_mean(ylab,na.rm=T,deff=T))
td<- td %>% mutate(coef_var=(m_ylab_se/m_ylab))
td



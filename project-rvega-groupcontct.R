library("altair")
library("listviewer")

rm(list = ls())
#import data
vega_data = altair::import_vega_data()
#See the list of the available datasets
vega_data$list_datasets()
#select one dataset
#data_source = vega_data$disasters()
#load 
sday = read.csv(url("https://raw.githubusercontent.com/ChaoJiang0416/KUL_DataVisualization/master/2019_Zhang_China_sday.csv"))
part_extra = read.csv(url("https://raw.githubusercontent.com/ChaoJiang0416/KUL_DataVisualization/master/2019_Zhang_China_participant_extra.csv"))
#take a look of this dataset
str(sday)
str(part_extra)
summary(sday)
summary(part_extra)
head(sday)
head(part_extra)
tail(sday)
head(part_extra)

contact<-cbind(sday,part_extra)[,-4]
head(contact)

#Bubble plot
brush <-alt$selection(type = "interval")

bubble = alt$Chart(contact)$
  mark_circle(
    opacity=0.8,
    stroke='black',
    strokeWidth=0.5
  )$
  encode(
    x = "sday_id:T",
    y = "dayofweek",
    color = alt$condition(brush,"dayofweek:N",alt$ColorValue("gray")),
    size = "group_n:Q"
  )$
  properties(
    height=200,
    width=600,
    selection = brush
  )
bubble

bars1<-
  alt$Chart()$
  mark_bar()$
  encode(
    x = "count(group_age0):Q",
    y = "group_age0:N",
    color = "group_age0:N"
  )$
  transform_filter(brush$ref())$
  properties(
    height=30,
    width=400,
    selection = brush
  )

bars2<-
  alt$Chart()$
  mark_bar()$
  encode(
    x = "count(group_age6):Q",
    y = "group_age6:N",
    color = "group_age6:N"
  )$
  transform_filter(brush$ref())$
  properties(
    height=30,
    width=400,
    selection = brush
  )


bars3<-
  alt$Chart()$
  mark_bar()$
  encode(
    x = "count(group_age12):Q",
    y = "group_age12:N",
    color = "group_age12:N"
  )$
  transform_filter(brush$ref())$
  properties(
    height=30,
    width=400,
    selection = brush
  )


bars4<-
  alt$Chart()$
  mark_bar()$
  encode(
    x = "count(group_age19):Q",
    y = "group_age19:N",
    color = "group_age19:N"
  )$
  transform_filter(brush$ref())$
  properties(
    height=30,
    width=400,
    selection = brush
  )


bars5<-
  alt$Chart()$
  mark_bar()$
  encode(
    x = "count(group_age60):Q",
    y = "group_age60:N",
    color = "group_age60:N"
  )$
  transform_filter(brush$ref())$
  properties(
    height=30,
    width=400,
    selection = brush
  )


chart <- alt$vconcat(bubble,bars1,bars2,bars3,bars4,bars5,data = contact)

chart

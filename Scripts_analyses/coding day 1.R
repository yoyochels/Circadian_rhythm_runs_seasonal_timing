## comments
#### objective: calculate metabolic rate
# co2 production (mL)/unit time (hours)/weight (mg)


## calculating the time interval

# initial - 13:39
# final - 10:13

### initial time
Ti<-13+39/60
#13.65

##final time
Tf<-10+13/60
#10.21


##calculating time interval
Int<-24-(13.65-10.21)
Int<-24-(Ti-Tf)
#co2 (mL)

co<-.29411

#20.56 hours

#mass (mg)
mass<-11.175

##calculating the mass specific metabolic rate
.29411/20.65/11.175

co/Int/mass


#### scale up to the dataset

master.dat<-read.csv("../Data/2017-10-27_data_slice.csv")
master.dat



str(master.dat)

master.dat$purge_time_1

substr("13:38",1,2)

class(substr("13:38",4,5))
substr("13:38",4,5)/60

as.numeric(substr("13:38",4,5))/60+as.numeric(substr("13:38",1,2))

Ti<-as.numeric(substr(master.dat$purge_time_1,1,2))+as.numeric(substr(master.dat$purge_time_1,4,5))/60
as.numeric(substr(master.dat$purge_time_1,4,5))/60

Tf<-as.numeric(substr(master.dat$resp_time_1,1,2))+as.numeric(substr(master.dat$resp_time_1,4,5))/60


Int<-24-(Ti-Tf)


master.dat$resp_day11/Int/master.dat$mass_day10


##problem: we have purge times for initial and final but not all samples
###solution: create a sequence of time of equal length for each cohort and tape block

##break up into small step: first start off by creating a sequence of time for a start time and end time 

start<-"13:39"
end<-"14:39"
N<-60

#convert time to numbers

start.numeric<-as.numeric(substr(start,1,2))+as.numeric(substr(start,4,5))/60

end.numeric<-as.numeric(substr(end,1,2))+as.numeric(substr(end,4,5))/60

delta.time<-(end.numeric-start.numeric)/N
start.numeric+delta.time


seq(1,60,1)*delta.time
time_int<-rep(start.numeric,N)+seq(1,60,1)*delta.time
time_int<-c(start.numeric,time_int[-1])
seq(start.numeric,end.numeric,length.out=60)


## scale the time sequence for every cohort and tape block

library(plyr)
library(ggplot2)

##getting sample sizes for every cohort and tape and collection date
sample.size<-ddply(master.dat,.(collection_date,cohort_day,tape),summarize,count=length(tape))

###plotting the sample sizes across time per collection date

ggplot(sample.size,aes(x=cohort_day,y=count,colour=collection_date))+geom_point()+geom_line()



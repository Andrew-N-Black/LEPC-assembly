library(ggplot2)
library(scales)
metrics <- read_excel("metrics2.xlsx")
n50<-ggplot(metrics,aes(x=reorder(c.name,N50),y=N50,color=busco.c.percent,shape=level))  +  geom_segment(aes(xend=c.name,yend=0)) + geom_point(size=6)+ labs(y='Scaffold N50',x='')+theme_classic()+coord_flip()
n50+scale_colour_gradient2(
    high = "black",
    mid = "lightgrey",
    low = "brown",
    midpoint = 85)

library(readxl)
library(ggplot2)
bird_het <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/LEPC/analysis/Fig_1.xlsx")


ggplot(bird_het,aes(x=reorder(CommonName,Corrected_HET),y=Corrected_HET)) +  geom_segment(aes(xend=CommonName,yend=0),size=2) + geom_point(size=7)+ labs(y='H',x='')+theme_classic()+coord_flip()+ theme(axis.text = element_text(size = 18))+ theme(axis.title = element_text(size = 30)) +theme(axis.title.x=element_text(face="italic"))+ theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave("Figure_1A.svg")

n50<-ggplot(bird_het,aes(x=reorder(CommonName,true_N50),y=true_N50,color=busco.c.percent,shape=level))  +  geom_segment(aes(xend=CommonName,yend=0),size = 2) + geom_point(size=7)+ labs(y='Scaffold N50 (Mb)',x='')+theme_classic()+coord_flip()+ theme(axis.text = element_text(size = 18)) +ylim(-2,101)
n50+scale_colour_gradient2(
    high = "black",
    mid = "lightgrey",
    low = "brown",
    midpoint = 78)+ theme(axis.title = element_text(size = 30))+ theme(legend.text=element_text(size=12))
ggsave("Figure_1B.svg")

C_r <- read.delim("~/C_r.txt")
ggplot(C_r, aes(y=Cestimated_genome_size, x=ncbi_genome_size_total)) +geom_point(size=7, shape=17)+theme_classic() + geom_text(label=C_r$CommonName,nudge_y=0,nudge_x = 0.075,size=10)+ylab("Genome Size (Gb)")+xlab("Assembly Size (Gb)")+geom_abline(intercept=0,slope=1,linetype="dashed")+theme(axis.text=element_text(size=18),axis.title=element_text(size=18),legend.title=element_text(size=18),legend.text=element_text(size=18))+xlim(0.93,1.44)+ylim(0.93,1.44)+ theme(axis.title = element_text(size = 30))

ggsave("Figure_1C.svg")



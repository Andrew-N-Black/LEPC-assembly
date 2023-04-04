
library(ggplot2)
C_r <- read.delim("~/C_r.txt")
ggplot(C_r, aes(y=Cestimated_genome_size, x=ncbi_genome_size_total)) +geom_point(size=8, shape=17)+theme_classic() + geom_text(label=C_r$CommonName,nudge_y=0,nudge_x = 0.075)+ylab("Genome Size (Gb)")+xlab("Assembly Size (Gb)")+geom_abline(intercept=0,slope=1,linetype="dashed")+theme(axis.text=element_text(size=14),axis.title=element_text(size=18),legend.title=element_text(size=10),legend.text=element_text(size=14))+xlim(0.93,1.44)+ylim(0.93,1.44)
ggsave("~/Fig.S1.svg")

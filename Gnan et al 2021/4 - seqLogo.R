library(ggseqlogo)
library(ggplot2)
dir='~/Desktop/Projects/Paramecium/'
files=list.files(dir,pattern = 'end|start')

files=files[grepl(pattern = '.csv$',x = files)]



for(f in files){
x=read.csv(paste0(dir,f),stringsAsFactors = F)

p=ggplot()+geom_logo( x$seq, method = 'prob')+theme_logo()
p
ggsave(paste0(dir,f,'.pdf'),p)
}

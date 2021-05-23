# Load Packages 
library(tidyverse)
library(gridExtra)
library(ggthemes)
# Set Theme
theme_set(theme_gray(base_size = 18))

# Loading Data 
data <- read.csv("variants_from_assembly.bed", sep="\t",
                 stringsAsFactors = TRUE, header = FALSE, 
                 quote = '')
# Colnames 
names(data) <-  c("chrom", "start", "stop", "name", "size", "strand", 
                  "type", "ref.dist", "query.dist")
# Data Preprocessing  
# 1.Filtering Data 
data <- filter(data, chrom %in% c(seq(1,22), "X", "Y", "MT"))
# 2.Ordering Chromosomes
data$chrom <- factor(data$chrom, levels=c(seq(1,22),"X","Y","MT"))
# 3.Ordering Choromosomes Type 
data$type <- factor(data$type, levels = c("Insertion", "Deletion", 
                                          "Expansion", "Contraction"))
# Bar Chart 
data %>% 
  ggplot(aes(x=chrom, fill=type))+
  geom_bar()+
  labs(x="Chromosomes", 
       y= "Counts")+
  guides(fill=guide_legend(title = "Type"))
ggsave("test.tiff", units="in", width=12, height=6, dpi=300, compression = 'lzw')
ggsave("test.png", units="in", width=12, height=6, dpi=300)

#### exemple Sarah ####
# Prepare for ordination for all treatments
comm.phylo16S.mat <- vegdist(phylo16S.mat , "bray")
PCoA.comm.phylo16S.mat<-capscale(phylo16S.mat~1,distance="bray")
PCoA.comm.phylo16S.mat$CA$eig[1:3]/sum(PCoA.comm.phylo16S.mat$CA$eig)
eig <- PCoA.comm.phylo16S.mat$CA$eig
eig[1]/sum(abs(eig)) # 13.51 %
eig[2]/sum(abs(eig)) # 8.56 %
eig[3]/sum(abs(eig)) # 5.25 %
PCoA.phylo16S<- PCoA.comm.phylo16S.mat # New shorter name

# Assign PCoA scores of each samples as column in the meta dataframe
meta16S$MDS1 <- vegan::scores(PCoA.phylo16S)$site[,1] # MDS1
meta16S$MDS2 <- scores(PCoA.phylo16S)$site[,2] # MDS2
head(meta16S)

pcoa_cities_16S <- ggplot(meta16S, aes(MDS1, MDS2, shape = city, fill = city, color = city))+# What we want to plot
  # Add ellipses representing the 95% confidence level for each site
  stat_ellipse(level=0.95, geom = "polygon",alpha = 1/3, aes(group = city))+
  geom_point(aes(size=0.1))+ # Add points to the plot, specify point size
  # Customize the color scale for site labels
  scale_color_manual(name = "Cities",values= c("black","black","black","black"))+
  # Customize the shape scale for cultivar labels
  scale_shape_manual(name = "Cities", values = c(22,21,24))+
  # Customize the fill color scale for site labels
  scale_fill_manual(name = "Cities",values = c("indianred3","khaki1","darkolivegreen3"))+
  theme_bw()+ # Set black and white theme
  ggtitle("PCoA of bacteria along cities") + # Set the plot title
  theme(plot.title = element_text(hjust = 0.5, face="bold"),
        axis.title = element_text(size = 16),
        legend.title = element_text(size=16),
        legend.text = element_text(size=14))+ # Customize plot and axis titles
  xlab("PCoA1 (14%)") +  # Set the x-axis label
  ylab("PCoA2 (9%)")+ # y-axis label
  guides(size = "none")+
  guides(shape = guide_legend(override.aes = list(size=5)))+
  guides(fill = guide_legend(override.aes = list(shape = NA))); pcoa_cities_16S # Remove the size legend

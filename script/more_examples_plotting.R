# some random examples

p2 <- ggplot()

p2 + geom_point(data = df,aes(x=cu,y=zn)) +
  geom_line(data = df,aes(x=cu,y=zn))

p3 <- ggplot(data = df,aes(x=cu,y=zn))

p3 + geom_point() +
  geom_line()

ggplot() + geom_point(data = df,aes(x=cu,y=zn)) +
  facet_grid(vars(landuse), vars(texture),scales = "free")


ggplot(df)+
  geom_point(aes(cu,zn,color=landuse))+ 
  facet_wrap(~landuse)+#,scales = "free_y"
  ggtitle("This is a great title!")+
  labs(x = "Cu [mg/kg]",y = "Zn [mg/kg]")+
  theme_classic(base_size = 20)+
  theme(legend.position = "bottom")


ggplot(df,aes(y = cu,x = landuse,fill = landuse))+
  geom_boxplot()+
  scale_fill_brewer(palette = "BrBG")

ggplot(df,aes(y = cu,x = landuse,fill = landuse))+
  geom_boxplot()+
  scale_fill_manual(values = c("yellow","blue"))


ggplot(df,aes(y = cu,x = landuse,color = landuse))+
  geom_boxplot()+
  scale_color_manual(values = c("yellow","blue"))

tree_data <- read.csv("C:/curso_r/treedata.csv")
head(tree_data)
str(tree_data)
summary(tree_data)
############################################
######## Uso de dplyr  #####################
############################################
require(dplyr)
tree_data %>% 
  group_by(plotsize, species) %>% 
  filter(plotsize >= 100) %>%
  # filter(species != "Abies fraseri") %>%
  summarise(n = length(cover), 
            suma = sum(cover), 
            media = sd(cover),
            mediana = median(cover),
            mini = min(cover),
            maxi = max(cover))
############################################
######## Uso de ggplot2 ####################
############################################
require(ggplot2)
head(tree_data)
ggplot(tree_data, aes(x = utme, y = utmn))+
  # geom_point(aes(color = species))+
  geom_point(aes(size = cover, color = elev))+
  # facet_wrap(~plotsize)+
  xlab("Coordenadas utm en x")+
  ylab("Coordenadas utm en y")+
  labs(title = "Ejemplot de ggplot2",
       subtitle = "Solamente para muestra en clase",
       caption = "Fuente: internet")+
  theme_bw()
############################################
######## Combinar con dplyr ################
############################################
tree_data %>% 
  group_by(plotsize, species) %>% 
  filter(plotsize >= 1000) %>%
  ggplot(aes(x = utme, y = utmn))+
  # geom_point(aes(color = species))+
  geom_point(aes(size = cover, color = elev))+
  facet_wrap(~plotsize)+
  xlab("Coordenadas utm en x")+
  ylab("Coordenadas utm en y")+
  labs(title = "Ejemplot de ggplot2",
       subtitle = "Solamente para muestra en clase",
       caption = "Fuente: internet")+
  theme_bw()
############################################
############ Histograma ####################
############################################
head(tree_data)
str(tree_data)
ggplot(tree_data)+
  # geom_point(aes(color = species))+
  geom_histogram(aes(x = elev), color = "black", fill = "gray90")+
  facet_wrap(~disturb)+
  # xlab("Coordenadas utm en x")+
  # ylab("Coordenadas utm en y")+
  labs(title = "Ejemplo de histograma",
       subtitle = "Solamente para muestra en clase",
       caption = "Fuente: internet")+
  theme_bw()
############################################
############### Boxplot ####################
############################################
ggplot(tree_data)+
  geom_boxplot(aes(x = disturb, y = elev))+
  facet_wrap(~plotsize)+
  # xlab("Coordenadas utm en x")+
  # ylab("Coordenadas utm en y")+
  labs(title = "Ejemplo de boxplot",
       subtitle = "Solamente para muestra en clase",
       caption = "Fuente: internet")+
  theme_bw()

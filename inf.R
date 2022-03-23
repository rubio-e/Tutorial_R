library(graphics)
t <- read.csv("/home/rubio/MEGA/R_1/BDATOS/ttest.csv", header = T)
n <- length(t$G1)
head(t, n = 5)

mean(t$G1)
length(t$G1)
# Hipótesis de una cola para comparación con media hipotética
t.test(
  x = t$G1, # Variable peso
  mu = 23, # Media hipotética
  alternative = "less"
) # less indica que la cola es hacia abajo, es decir,
# queremos ver si nuestra media es menor a 22
# Caso contrario sería "greater"

boxplot(t$G1, t$G2, names = c("Grupo 1", "Grupo 2"))
t.test(t$G1, t$G2, paired = F)
t.test(extra ~ group, data = sleep)


# Ejemplo anova
Plantas <- read.csv("/home/rubio/MEGA/R_1/BDATOS/Plantas.csv", header = T) # Llamamos la base Plantas
head(Plantas)
Plantas$Grupo <- as.factor(Plantas$Grupo)
plot(Peso ~ Grupo, data = Plantas) ## boxplot
fligner.test(Peso ~ Grupo, data = Plantas)
# ANOVA
fit <- aov(Peso ~ (Grupo), data = Plantas) # Peso= Variable respuesta
summary(fit)
RES <- residuals(fit) # Calcula los residuales del modelo
plot(RES) # Muestra la distribución de los residuales en el gráfico
qqnorm(RES)
qqline(RES)
shapiro.test(RES)
# Post-Hoc
TukeyHSD(fit, conf.level=0.95)
plot(TukeyHSD(fit))
# Usando agrocolae
library(agricolae)
out <- HSD.test(
  y = fit, trt = "Grupo",
  group = T,
  console = TRUE
)

## Crear un gráfico
bar.group(out$groups,
  main = "Efecto del tratamiento A",
  border = "black",
  col = "orange",
  ylim = c(0, 8)
)
box()

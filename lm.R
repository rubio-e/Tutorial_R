data(trees)
plot(trees)
names(trees)
# Uso de los correlograms para detectar correlaciones entre variables
# library(corrgram)
# corrgram(trees, order=TRUE, lower.panel=panel.shade,
#          upper.panel=panel.pie, text.panel=panel.txt,
#          main="Correlograma")
# sum((trees$Girth-mean(trees$Girth))*(trees$Volume-mean(trees$Volume)))/sqrt(sum((trees$Girth-mean(trees$Girth))^2)*sum((trees$Volume-mean(trees$Volume))^2))
cor.test(x = trees$Girth, y = trees$Volume)
##########################################
## Gráfico de los primeros datos #########
##########################################
plot(Volume ~ Girth,
  data = trees,
  # xlab="X", ylab="Y", main="Modelo de regresión",
  pch = 16, cex = 1, cex.lab = 1, cex.axis = 1
)
##########################################
## Estimar la línea de regresión simple ##
##########################################
mod <- lm(Volume ~ Girth, data = trees)
summary(mod)
abline(mod)
## Adherir segmentos
segments(trees$Girth, fitted(mod), trees$Girth, trees$Volume, lty = 2)
#########################
# 1. Linealidad #########
#########################
res <- residuals(mod)
yfit <- fitted(mod)
plot(yfit, res, ylab = "Residuales", xlab = "Ajustados", main = "Residuales vs Ajustados")
abline(lm(res ~ yfit))
#########################
# 2. Normalidad #########
#########################
library(car)
qqPlot(res, col = "black")
qqnorm(scale(res))
abline(0, 1)
shapiro.test(res)
#########################
# 3. heterocedasticidad #
#########################
library(lmtest)
bptest(mod)
#########################
# 3. Transformación #####
#########################
mod_uno <- lm(log(Volume) ~ Girth, data = trees)
bptest(mod_uno)
summary(mod_uno)
res_uno <- residuals(mod_uno)
yfit_uno <- fitted(mod_uno)
plot(yfit_uno, res_uno, ylab = "Residuales", xlab = "Ajustados", main = "Residuales vs Ajustados (G)")
abline(lm(res_uno ~ yfit_uno))
#########################
# 3. Regresión Multiple #
#########################
mod_dos <- lm(log(Volume) ~ Girth + Height, data = trees)
bptest(mod_dos)
summary(mod_dos)
# anova(mod_uno, mod_dos)
#########################
res_dos <- residuals(mod_dos)
yfit_dos <- fitted(mod_dos)
plot(yfit_dos, res_dos, ylab = "Residuales", xlab = "Ajustados", main = "Residuales vs Ajustados (G+H)")
abline(lm(res_dos ~ yfit_dos))
# predicción
pred <- data.frame( observados = trees$Volume,predichos = exp(predict(mod_dos)))
head(pred)
            
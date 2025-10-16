# CLASSIFICAÇÃO DE PINGUINS COM PCA E ANÁLISE DISCRIMINANTE                


###### CONFIGURAÇÃO DO AMBIENTE

# Instalando os pacotes necessários
# Adicionamos o pacote 'janitor' para facilitar a limpeza dos nomes das colunas
install.packages(c("tidyverse", "MASS", "factoextra", 
                   "DataExplorer", "Hmisc", "imputeTS", "janitor"))

# Carregando os pacotes 
library(tidyverse)      
library(MASS)           
library(factoextra)  
library(DataExplorer)
library(Hmisc)
library(imputeTS)
library(janitor)       

###### Carregando a base de dados 
dados_pinguins <- read.csv("penguins_size.csv")

glimpse(dados_pinguins) # Visualizando a estrutura dos dados


###### Verificando os dados perdidos (NA)
# cria um gráfico que mostra a porcentagem de dados faltantes em cada coluna.
plot_missing(dados_pinguins)

# tratando os dados perdidos (NA)
pinguins_db <- na.omit(dados_pinguins)
plot_missing(pinguins_db)


###### ANÁLISE DE COMPONENTES PRINCIPAIS (PCA)
###### Objetivo: Simplificar as 4 variáveis de medidas físicas em 2 componentes.
table(pinguins_db$species)

# Selecionando apenas as colunas numéricas que vamos usar no PCA
medidas_pinguins <- pinguins_db %>%
  dplyr::select(culmen_length_mm, culmen_depth_mm, flipper_length_mm, body_mass_g)

# Padronizando os dados 
medidas_padronizadas <- scale(medidas_pinguins)

# Executando o PCA
pca_pinguins <- prcomp(medidas_padronizadas)

# Analisando o resultado do PCA 
summary(pca_pinguins)

# Visualização do PCA 
fviz_pca_biplot(pca_pinguins,
                geom.ind = "point", 
                pointshape = 21,
                pointsize = 3,
                fill.ind = pinguins_db$species,
                addEllipses = TRUE,
                legend.title = "Espécie",
                title = "PCA das Medidas de Pinguins") +
  theme_minimal()


###### ETAPA 6: ANÁLISE DISCRIMINANTE 
###### Objetivo: Criar um modelo que usa os resultados do PCA para classificar as espécies.

# Preparando os dados para o modelo
dados_modelo <- data.frame(
  species = pinguins_db$species,
  PC1 = pca_pinguins$x[, 1],
  PC2 = pca_pinguins$x[, 2]
)

# Criando o modelo
modelo_lda <- lda(species ~ PC1 + PC2, data = dados_modelo)

# Visualização do Modelo
grid <- expand.grid(
  PC1 = seq(min(dados_modelo$PC1) - 1, max(dados_modelo$PC1) + 1, length.out = 200),
  PC2 = seq(min(dados_modelo$PC2) - 1, max(dados_modelo$PC2) + 1, length.out = 200)
)
predicoes_grid <- predict(modelo_lda, newdata = grid)
grid$species_predita <- predicoes_grid$class

ggplot() +
  geom_raster(data = grid, aes(x = PC1, y = PC2, fill = species_predita), alpha = 0.4) +
  geom_point(data = dados_modelo, aes(x = PC1, y = PC2, color = species), size = 3) +
  labs(title = "Fronteira de Decisão da Análise Discriminante",
       x = "Comp 1 (Tamanho Geral)",
       y = "Comp 2 (Formato do Bico)") +
  scale_fill_manual(name = "Região Prevista", values = c("Adelie" = "#E69F00", "Chinstrap" = "#009E73", "Gentoo" = "#56B4E9")) +
  scale_color_manual(name = "Espécie Real", values = c("Adelie" = "#E69F00", "Chinstrap" = "#009E73", "Gentoo" = "#56B4E9")) +
  theme_minimal() +
  theme(legend.position = "bottom")

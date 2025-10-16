# Classificação de Espécies de Pinguins com PCA e Análise Discriminante
Este projeto utiliza técnicas de aprendizado de máquina para classificar três espécies de pinguins (Adelie, Chinstrap e Gentoo) com base em suas medidas corporais. A Análise de Componentes Principais (PCA) é empregada para reduzir a dimensionalidade dos dados e a Análise Discriminante Linear (LDA) é usada para criar um modelo de classificação.

O processo consiste em:

1. Carregamento e Limpeza dos Dados: Carregar o dataset, visualizar e remover dados faltantes.
2. Redução de Dimensionalidade com PCA: Simplificar as quatro variáveis de medidas físicas em dois componentes principais, que capturam a maior parte da variância dos dados.
3. Classificação com Análise Discriminante: Treinar um modelo para classificar as espécies de pinguins com base nos componentes principais obtidos.

# Dataset
O dataset utilizado é o penguins_size.csv, que faz parte do famoso conjunto de dados Palmer Penguins. Ele contém dados de 344 pinguins e inclui as seguintes variáveis utilizadas na análise:

		species: A espécie do pinguim (Adelie, Chinstrap, Gentoo).
		culmen_length_mm: Comprimento do bico.
		culmen_depth_mm: Profundidade do bico.
		flipper_length_mm: Comprimento da nadadeira.
		body_mass_g: Massa corporal.

Análise e Resultados
O fluxo de análise seguiu duas etapas principais após a limpeza dos dados:

1. Análise de Componentes Principais (PCA):
A PCA foi aplicada sobre as quatro variáveis numéricas de medidas corporais. O gráfico abaixo (biplot) visualiza os dois primeiros componentes principais (PC1 e PC2), que juntos explicam a maior parte da variabilidade nos dados. É possível observar a formação de agrupamentos distintos para cada espécie.
<img width="627" height="512" alt="Rplot" src="https://github.com/user-attachments/assets/2716ae04-1c66-42e5-ae8d-0531da39d53b" />

3. Análise Discriminante (LDA):
Utilizando os dois componentes principais (PC1 e PC2) como preditores, um modelo de Análise Discriminante Linear foi treinado para classificar as espécies. O gráfico abaixo mostra as fronteiras de decisão criadas pelo modelo. As áreas coloridas representam a região onde o modelo classifica uma nova observação como pertencente a uma determinada espécie. Os pontos representam os dados originais.
Como podemos ver, o modelo cria fronteiras claras que separam eficientemente as três espécies de pinguins.
<img width="627" height="512" alt="Rplot02" src="https://github.com/user-attachments/assets/b48f1221-52b8-4d1e-9217-0aa268f993fa" />

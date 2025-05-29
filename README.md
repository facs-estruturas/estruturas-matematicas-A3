# estruturas-matematicas-A3

Descrição do trabalho:

Desenvolver em linguagem Julia uma solução de Cadeias de Markov.

Páginas 14 a 26 do livro Álgebra Linear do Boldrini.

**Exemplo utilizado:**
Imagine um serviço de aluguel/empréstimo de bicicletas públicas. Para conse-guir o empréstimo de alguma, a pessoa precisa ir a alguma das três estações: Centro (C),  Orla  (O)  e  Parque  (P).  Suponhamos,  também,  que  as  devoluções  das  bicicletas  devem  ser  obrigatoriamente  em  algum  dos  locais  citados  acima.  Os  dados  obtidos  revelam que a movimentação das bicicletas ocorre da seguinte maneira: 95% das bi-cicletas que são pegas no centro são devolvidas no centro, 3% das bicicletas retiradas do centro são devolvidas na Orla e 2% delas são devolvidas no parque. Em relação às bicicletas pegas na Orla, temos que 2% são devolvidas no centro, 90% são deixadas na Orla, e 8% são devolvidas no Parque. Sobre as bicicletas retiradas no Parque, 5% são deixadas no Centro, 5% no Orla e 90% deixadas no mesmo local. Sabendo que a distribuição inicial, no primeiro dia, do total de bicicletas foi de 50% no Centro, 30% na Orla e 20% no Parque. Qual será a distribuição ao final deste dia?


**Fonte:**
https://periodicos.set.edu.br/cadernoexatas/article/view/2379/1448, páginas 8 e 9.

**Matriz de transição:**
P = [
    0.95  0.02  0.05;
    0.03  0.90  0.05;
    0.02  0.08  0.90
]


**Vetores iniciais:**
v0 = [0.5,
      0.3,
      0.2
]  


## Como instalar as dependências
Para rodar o projeto, siga os passos abaixo:

1. **Inicie o Julia**

   ```bash
   julia
   ```

2. **Ative o ambiente do projeto e instale as dependências**

   No terminal do Julia (REPL), digite `]` para entrar no modo de pacote, depois:

   ```julia
   activate .
   instantiate
   ```

Isso instala automaticamente todos os pacotes utilizados na aplicação.

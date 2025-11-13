# estruturas-matematicas-A3

Descrição do trabalho:

Desenvolver em linguagem Julia uma solução de Cadeias de Markov.

Páginas 14 a 26 do livro Álgebra Linear do Boldrini.
<br><br>

## Exemplo utilizado:

### Fonte:
http://www.olewitthansen.dk/Mathematics/Markov_chains_examples.pdf, páginas 9 a 11.
<br><br>

### Dados utilizados:

**Matriz de transição:**
```bash
P = [
    0  0  0  0  0  0  0  1;
    0  0  0  0  0  0  0.5  0.5;
    0  0  0  0  0  0.5  0  0.5;
    0  0  0  0  0  0.5  0  0.5;
    0  0  0  0.5  0  0  0  0.5;
    0  0  0.25  0.25  0  0  0.25  0.25;
    0  0  0  0  0  0.5  0  0.5;
    0  0  0  0  0  0  0  1;
]
```

**Vetor inicial:**
```bash
v0 = [0.4 0.2 0.1 0.2 0.1 0 0 0]
```  
<br><br>
## Como instalar as dependências
Para instalar as dependências do projeto, é necessário que o usuário possua a aplicação do Julia instalado em seu computador.
Se estiver usando o Windows, execute o seguinte comando:
``
winget install --name Julia --id 9NJNWW8PVKMN -e -s msstore
`` 
<br>
<br>
Não sendo o caso, basta seguir os passos disponíveis no website oficial da linguagem, em https://julialang.org/install/.
Com o Julia devidamente instalado, siga os passos abaixo:

1. **Inicie o Julia**

   ```bash
   julia
   ```

2. **Ative o ambiente do projeto e instale as dependências**

   No terminal do Julia (REPL), digite `]` para entrar no modo de pacote (pkg), depois:

   ```bash
   activate .
   instantiate
   ```

Isso instala automaticamente todos os pacotes utilizados na aplicação.

## Como rodar o projeto
Para rodar o projeto:

Caso ainda esteja no modo de pacote (pkg) do terminal do Julia, aperte Backspace ou Ctrl+C para retornar ao terminal do Julia.

No terminal do Julia:

```
include("main.jl")
```

Ou, alternativamente, fora do terminal do Julia:

```bash
julia main.jl
```

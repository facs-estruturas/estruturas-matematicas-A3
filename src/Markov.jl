module Markov
using LinearAlgebra

export proxima_iteracao, simular_cadeia, encontrar_vetor_estacionario, criar_matriz

function criar_matriz()

    # falta validar input > 0 e menor que 1; validar soma da linha === 1
    #provavelmente fazer uma função para fazer essas validações e tratar

    println("Digite o tamanho da matriz (n x n): ")
    n = parse(Int, readline())

    println("Digite a matriz de transição linha por linha, separando os valores por espaço: ")
    P = zeros(n, n)

    for i in 1:n
        print("Linha $i: ")
        entrada = readline()
        valores = parse.(Float64, split(entrada))
        if length(valores) != n
            error("A linha $i precisa ter exatamente $n valores.")
        end
        P[i, :] = valores
    end
    println("\nMatriz de transição recebida: ")
    println(P)
    return P
end

function receber_v0()

    # falta validações e possivel refinamento

    println("Digite os vetores iniciais: ")
    v0 = readline()
    return v0
end

function receber_passos()

    # acho que não falta nada, revisarei

    println("Digite o número de passos desejados: ")
    passos = readline()
    if passos < 1
        error("O número mínimo de passos é 2.")
    end
    return passos
end

# realiza a proxima iteracao consecutivamente
function proxima_iteracao(P::Matrix{Float64}, v::Vector{Float64})
    n = size(P, 1)
    resultado = zeros(Float64, n)

    println("\n📊 Cálculo do novo vetor (P * v):")
    for i in 1:n
        linha = P[i, :]
        soma = 0.0
        termos = []
        for j in 1:n
            termo = linha[j] * v[j]
            # arredondamento feito apenas para a impressao, nao altera o calculo
            push!(termos, "P[$i,$j]*v[$j] = $(round(linha[j], digits=3))*$(round(v[j], digits=3)) = $(round(termo, digits=6))")
            soma += termo
        end
        resultado[i] = soma
        println("→ v[$i] = ", join(termos, " + "), " = ", round(soma, digits=6))
    end

    println("\n")

    return resultado
end

# simula a cadeia de markov fazendo o push de cada iteracao no array de vetores
function simular_cadeia(P::Matrix{Float64}, v0::Vector{Float64}, passos::Int)
    vs = [(v0)]
    v = v0
    for _ in 1:passos
        v = (proxima_iteracao(P, v))
        push!(vs, v)
    end
    return vs
end

# tenta encontrar o vetor estacionario
function encontrar_vetor_estacionario(P::Matrix{Float64})
    n = size(P, 1)
    A = transpose(P) - I
    A = vcat(A[1:end-1, :], ones(1, n))
    b = zeros(n)
    b[end] = 1.0
    π = A \ b
    return π
end

end
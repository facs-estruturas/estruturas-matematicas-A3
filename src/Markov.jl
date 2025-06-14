module Markov
using LinearAlgebra

export proxima_iteracao, simular_cadeia, encontrar_vetor_estacionario, recebe_matriz, recebe_v0, recebe_passos

function recebe_matriz()
    n = 0

    while true
        println("Digite o tamanho da matriz (n x n): ")

        try
            n = parse(Int, readline())
            if n < 2
                println("O tamanho mínimo de uma matriz é 2. Tente novamente.")
            else
                break
            end
        catch
            println("Opção inválida, Digite um número inteiro.")
        end
    end

    tipo = 0
    while true
        println("Sua matriz é uma matriz coluna ou uma matriz linha?")
        println("1: coluna")
        println("2: linha")
        println("Digite 1 ou 2 :")

        try
            tipo = parse(Int, readline())
            if tipo in [1, 2]
                break
            else
                println("Opção inválida. Digite apenas '1' ou '2'")
            end
        catch
            println("Opção inválida. Digite apenas 1 ou 2.")
        end
    end

    println("Digite a matriz de transição linha por linha, separando os valores por espaço: ")
    P = zeros(n, n)
    tolerancia = 2 # ajustar a tolerancia para linha e coluna

    for i in 1:n
        while true
            print("Linha $i: ")
            entrada = readline()

            try
                valores = parse.(Float64, split(entrada))

                if length(valores) != n
                    error("Erro: a linha $i precisa ter exatamente $n valores.")
                    continue
                elseif any(x -> x < 0, valores)
                    println("Todos os valores devem ser maiores ou iguais a 0.")
                    continue
                elseif abs(sum(valores) - 1.0) > tolerancia
                    println("A soma da linha $i deve ser 1 (tolerância de 0.000004). Soma atual: ", sum(valores))
                    continue
                else
                    P[i, :] = valores
                    break
                end
            catch
                println("Entrada inválida. Certifique-se de digitar $n números separados por espaço.")
            end
        end
    end
    
    # Transpõe caso seja matriz linha
    if tipo == 2
        println("\nVocê selecionou matriz linha. Será transposta para uso como matriz coluna.")
        P = Matrix(transpose(P))
    else
        println("\nVocê selecionou matriz coluna. Será usada diretamente.")
    end

    println("\nMatriz de transição recebida: ")
    println(P)
    return P, n
end

function recebe_v0(n::Int)
    while true
        println("Digite os $n vetores iniciais separados por espaço: ")
        entrada = readline()

        try
            valores = parse.(Float64, split(entrada))

            if length(valores) != n
                error("Erro: são necessários exatamente $n vetores iniciais.")
                continue
            elseif any(x -> x < 0, valores)
                println("Erro: Os valores não podem ser negativos.")
                continue
            elseif abs(sum(valores) - 1.0 > 4e-6)
                println("Erro: a soma dos valores deve ser 1.")
                continue
            else
                return valores
            end
        catch
            println("Erro ao converter os valores. Tente novamente.")
        end
    end
end

function recebe_passos()
    while true
        println("Digite o número de passos desejados: ")
        passos = parse(Int, readline())

        try
            if passos < 2
            println("O número mínimo de passos deve ser 2.")
            continue
            else
                return passos 
            end
        catch
            println("Erro ao receber os passos. Tente novamente.")
        end
    end
end

function proxima_iteracao(P::Matrix{Float64}, v::Vector{Float64})
    n = size(P, 1)
    resultado = zeros(Float64, n)

    # calculo para matriz coluna, matriz linha é transposta antes de ser calculada
    println("\nCálculo do novo vetor (P * v):")
    for i in 1:n
        linha = P[i, :]
        soma = 0.0
        termos = []
        for j in 1:n
            termo = linha[j] * v[j]
            push!(termos, "P[$i,$j]*v[$j] = $(round(linha[j], digits=3))*$(round(v[j], digits=3)) = $(round(termo, digits=6))")
            soma += termo
        end
        resultado[i] = soma
        println("→ v[$i] = ", join(termos, " + "), " = ", round(soma, digits=6))
    end
    println("\n")
    return resultado
end

function simular_cadeia(P::Matrix{Float64}, v0::Vector{Float64}, passos::Int)
    vs = [(v0)]
    v = v0
    for _ in 1:passos
        v = (proxima_iteracao(P, v))
        push!(vs, v)
    end
    return vs
end

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
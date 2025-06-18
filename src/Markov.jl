module Markov
using LinearAlgebra
using Printf
using Plots

export proxima_iteracao, simular_cadeia, encontrar_vetor_estacionario, recebe_matriz, recebe_v0, recebe_passos, plotar_grafico

const TOLERANCIA = 0.000004
const TOLERANCIA_STR = @sprintf("%.6f", TOLERANCIA)

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
            println("Opção inválida. Digite um número inteiro.")
        end
    end

    tipo = 0
    while true
        println("O seu vetor de probabilidades é uma matriz linha ou uma matriz coluna?")
        println("1: Coluna")
        println("2: Linha")
        print("Digite 1 ou 2: ")

        try
            tipo = parse(Int, readline())
            if tipo in [1, 2]
                break
            else
                println("Opção inválida. Digite apenas 1 ou 2.")
            end
        catch
            println("Opção inválida. Digite apenas 1 ou 2.")
        end
    end

    while true
        P = zeros(n, n)
        println("\nDigite a matriz de transição linha por linha, separando os valores por espaço e utilizando ponto para os decimais (ex: 0.707):")

        for i in 1:n
            while true
                print("Linha $i: ")
                entrada = readline()
                try
                    valores = parse.(Float64, split(entrada))

                    if length(valores) != n
                        println("Erro: a linha $i precisa ter exatamente $n valores.")
                        continue
                    elseif any(x -> x < 0, valores)
                        println("Todos os valores devem ser maiores ou iguais a 0.")
                        continue
                    elseif tipo == 2 && abs(sum(valores) - 1.0) > TOLERANCIA # validação por linha
                        println("A soma da linha $i deve ser 1 (tolerância de $TOLERANCIA_STR). Soma atual: ", sum(valores))
                        continue
                    else
                        P[i, :] = valores
                        break
                    end
                catch
                    println("Entrada inválida. Certifique-se de digitar $n números separados por espaço e de utilizar ponto para os decimais.")
                end
            end
        end

        if tipo == 1  # validação por coluna
            erro_encontrado = false
            for j in 1:n
                soma_coluna = sum(P[:, j])
                if abs(soma_coluna - 1.0) > TOLERANCIA
                    println("A coluna $j deve somar 1 (tolerância $TOLERANCIA_STR). Soma atual: $soma_coluna")
                    erro_encontrado = true
                end
            end
            if erro_encontrado
                println("Erro nas colunas. Reinsira toda a matriz.\n")
                continue  # reinicia o loop externo
            end
        end

        # Transpõe se for matriz por linha
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
end

function recebe_v0(n::Int)
    while true
        println("Digite os $n valores do vetor inicial, separando os valores por espaço e utilizando ponto para os decimais: ")
        entrada = readline()

        try
            valores = parse.(Float64, split(entrada))

            if length(valores) != n
                error("Erro: são necessários exatamente $n valores para o vetor inicial.")
                continue
            elseif any(x -> x < 0, valores)
                println("Erro: Os valores não podem ser negativos.")
                continue
            elseif abs(sum(valores) - 1.0) > TOLERANCIA
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
    A = P - I
    A = vcat(A[1:end-1, :], ones(1, n))
    b = zeros(n)
    b[end] = 1.0
    π = abs.(A \ b)
    return π
end

function plotar_grafico(resultados::Vector{Vector{Float64}})
    n_estados = length(resultados[1])
    passos = 0:(length(resultados) - 1)

    # Plot da primeira linha
    plot(passos, [v[1] for v in resultados], label="Estado 1", linewidth=2)

    # Plot das linhas seguintes
    for i in 2:n_estados
        plot!(passos, [v[i] for v in resultados], label="Estado $i", linewidth=2)
    end

    xlabel!("Passos")
    ylabel!("Probabilidade")
    title!("Evolução da Cadeia de Markov")
    savefig("plots/evolucao.png")
end

end
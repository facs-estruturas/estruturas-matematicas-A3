module Markov
using LinearAlgebra

export proxima_iteracao, simular_cadeia, encontrar_vetor_estacionario

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
            push!(termos, "P[$i,$j]*v[$j] = $(round(linha[j], digits=3))*$(round(v[j], digits=3)) = $(round(termo, digits=6))")
            soma += termo
        end
        resultado[i] = soma
        println("→ v[$i] = ", join(termos, " + "), " = ", round(soma, digits=6))
    end

    println("\n")

    return resultado
end

#simula a cadeia de markov fazendo o push de cada iteracao no array de vetores
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
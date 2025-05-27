module Markov
using LinearAlgebra

export proxima_iteracao, simular_cadeia, encontrar_vetor_estacionario

function proxima_iteracao(P::Matrix{Float64}, v::Vector{Float64})
    return P * v
end

function simular_cadeia(P::Matrix{Float64}, v0::Vector{Float64}, passos::Int)
    vs = [v0]
    v = v0
    for _ in 1:passos
        v = proxima_iteracao(P, v)
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
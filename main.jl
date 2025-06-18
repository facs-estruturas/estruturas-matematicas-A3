include("src/Markov.jl")
using .Markov

P, n, tipo = recebe_matriz()
v0 = recebe_v0(n)
passos = recebe_passos()

println("Exemplo:")
resultados = simular_cadeia(P, v0, passos)

for (i, v) in enumerate(resultados)
    println("Passo $i: ", round.(v, digits = 4), "  | Soma: ", sum(v))
end

ve = encontrar_vetor_estacionario(P, tipo)
println("\nVetor estacionário aproximado: ", round.(ve, digits=4))

plotar_grafico(resultados)
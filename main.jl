include("src/Markov.jl")
using .Markov
using Plots

P = [0.9 0.1; 0.5 0.5]
v0 = [1.0, 0.0]

# P = [0.0 1.0; 1.0 0.0]
# v0 = [0.3, 0.7]

passos = 100

resultados = simular_cadeia(P, v0, passos)

for (i, v) in enumerate(resultados)
    println("Passo $i: ", round.(v, digits = 4))
end

ve = encontrar_vetor_estacionario(P)
println("\nVetor estacionário aproximado: ", round.(ve, digits=4))

plot([v[1] for v in resultados], label="Estado 1")
plot!([v[2] for v in resultados], label="Estado 2", xlabel="Passos", ylabel="Probabilidade", title="Evolução dos estados")
savefig("plots/evolucao.png")
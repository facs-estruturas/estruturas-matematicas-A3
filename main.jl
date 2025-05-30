include("src/Markov.jl")
using .Markov
using Plots

# caso aluguel de bicicletas

# matriz de transicao (C, O, P)
P = [
    0.95  0.02  0.05;  # C → C, O, P
    0.03  0.90  0.05;  # O → C, O, P
    0.02  0.08  0.90   # P → C, O, P
]

v0 = [0.5, # 50% centro
      0.3, # 30% orla
      0.2  # 20% parque
] 

passos = 200

resultados = simular_cadeia(P, v0, passos)

for (i, v) in enumerate(resultados)
    println("Passo $i: ", round.(v, digits = 4), "  | Soma: ", sum(v))
end

ve = encontrar_vetor_estacionario(P)
println("\nVetor estacionário aproximado: ", round.(ve, digits=4))

plot([v[1] for v in resultados], label="Centro", linewidth=2)
plot!([v[2] for v in resultados], label="Orla", linewidth=2)
plot!(
    [v[3] for v in resultados], label="Parque", linewidth=2,
    xlabel="Passos", ylabel="Probabilidade",
    title="Evolução da Cadeia de Markov"
)
savefig("plots/evolucao.png")
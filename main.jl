include("src/Markov.jl")
using .Markov
using Plots

# P = criar_matriz()
# v0 = receber_v0()
# passos = receber_passos()

println("Exemplo:")
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
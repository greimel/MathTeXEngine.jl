using CairoMakie
using MathTeXEngine

inputs = Dict()

inputs["accents"] = [
    L"\dot{Q} \dot{q}",
    L"\vec{A} \vec{a}",
    L"\bar{L} \bar{l}",
    L"\hat{\Phi} \bar{\varphi}"
]

inputs["delimiters"] = [
    L"(1 + 2) (\frac{1}{2})",
    L"\left(1 + 2\right) \left(\frac{1}{2}\right)",
    L"\left[a + b\right] \left[\frac{a}{b}\right]",
    L"\left{A + B \right} + \left{\frac{A}{B}\right}",
    L"\left{\alpha + \beta \right} + \left{\frac{\alpha}{\beta}\right}",
    L"\left{1 + \left[2 + \left(3 + 4\right)\right]\right}"
]

inputs["fractions"] = [
    L"\frac{a + b + c}{c + b + a}",
    L"\frac{a}{A + B + C}",
    L"\frac{j - f}{f - j}"
]

inputs["functions"] = [
    L"\sin{\omega} + \cos{\theta}",
    L"\exp{\log{2}} = 2",
    L"\inf_{x} \tan(x) \leq \sup_{x} \tan(x)" 
]

inputs["symbols"] = [
    L"\alpha \beta \gamma \delta \epsilon \omega \theta \phi \varphi \psi",
    L"\Gamma \Delta \Omega \Theta \Phi \Psi",
    L"\nabla \rightarrow \neq \leq \hbar"
]

inputs["integrals"] = [
    L"\int_a^b",
    L"\int \int \int"
]

inputs["punctuation"] = [
    L"x!",
    L"23.17",
    L"10,000"
]

inputs["square_roots"] = [
    L"\sqrt{2}",
    L"\sqrt{\frac{1}{2}}",
    L"\sqrt{b^2 - 4ac}",
    L"\sqrt{1 + \frac{A + B}{J + U}}"
]

inputs["spaces"] = [
    L"a \! b",
    L"a \; b",
    L"a \quad b",
    L"a \qquad b"
]

inputs["infix"] = [
    L"T + V",
    L"7 - 2",
    L"v \cdot w",
    L"E = m c^2"
]

inputs["subsuper"] = [
    L"V^1_2",
    L"U_{ij}",
    L"W^{(i + j)}",
    L"x_{y \rightarrow 0}"
]

inputs["underover"] = [
    L"\sum_{n = 1}^{m^2}",
    L"\sum_{N = 1}^{M^2}",
    L"\prod_{n \neq m}",
    L"\prod_{N \neq M}"
]

inputs["fonts"] = [
    L"\mathrm{bonjour}",
    L"\mathbb{R} \mathbb{Q} \mathbb{C}",
    L"\mathcal{N} \mathcal{K}"
]

function generate(name)
    @info "Generating reference image at $name"
    path = mkpath(name)
    failures = Dict()
    for (group, exprs) in inputs
        fig, fails = single_figure(exprs)
        if !isempty(fails)
            failures[group] = fails
        end

        save(joinpath(path, "$group.png"), fig, px_per_unit=3)
    end

    return failures
end

function single_figure(exprs)
    fig = Figure(resolution=(200, length(exprs)*60))
    failures = Dict()
    for (i, expr) in enumerate(exprs)
        try
            fig[i, 1] = Label(fig, expr)
        catch e
            failures[expr] = e
        end 
    end
    return fig, failures
end
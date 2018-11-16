include("io/read_input.jl")

function main()
    timesteps = 0
    dt = 0.0
    species_input_data = SpeciesInput[]
    particles_filename = ""
    interactions_filename = ""
    fnum = 0.0
    ndens = 0.0
    rho = 0.0
    p = 0.0

    parse_input(ARGS[1])
    println(fnum)
end

main()
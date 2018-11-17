include("io/read_input.jl")

function main()
    species_params = SpeciesParams[]
    global_params = parse_input(ARGS[1])
    println(global_params.interactions_file)
end

main()
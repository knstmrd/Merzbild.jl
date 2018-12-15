include("utils/constants.jl")
include("io/read_input.jl")
include("io/screen_output.jl")
include("utils/physics_utils.jl")
include("data/species.jl")

function main()
    global_params, species_params = parse_input(ARGS[1])

    check_initial_conditions(global_params, species_params)

    output_global_params(global_params)

    species_data = load_species_data(global_params, species_params)
    # interaction_data = load_interaction_data(particle_data)
    # compute_initial_conditions(species_params, global_params)
    # particles = create_particles(particle_data, species_params)
end

main()
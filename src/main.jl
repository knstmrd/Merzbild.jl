include("io/read_input.jl")
include("io/screen_output.jl")
include("utils/physics_utils.jl")

function main()
    global_params, species_params = parse_input(ARGS[1])

    check_initial_conditions(species_params, global_params)

    output_global_params(global_params)

    # particle_data = load_particle_data(species_params)
    # interaction_data = load_interaction_data(particle_data)
    # compute_initial_conditions(species_params, global_params)
    # particles = create_particles(particle_data, species_params)
end

main()
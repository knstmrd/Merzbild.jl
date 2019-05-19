include("data/params.jl")
include("utils/constants.jl")
include("io/read_input.jl")
include("io/screen_output.jl")
include("utils/physics_utils.jl")
include("data/species.jl")
include("data/interactions.jl")

function main()
    # input: path to input file, path to species data file
    global_params, species_params = parse_input(ARGS[1])

    check_initial_conditions(global_params, species_params)

    output_global_params(global_params)

    species_data = load_species_data(global_params, species_params)
    interaction_data = load_interaction_data(global_params, species_data)
    compute_initial_conditions(global_params, species_params, species_data)
    # particles = create_particles(global_params, species_params, species_data)

    # time counter
    # collide
    # compute macroscopic parameters
    # output
end

main()
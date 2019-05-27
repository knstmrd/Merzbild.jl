include("data/params.jl")
include("utils/constants.jl")
include("io/read_input.jl")
include("io/screen_output.jl")
include("utils/physics_utils.jl")
include("data/species.jl")
include("data/interactions.jl")
include("data/particles.jl")
using Random

function main()

    # input: path to input file, path to species data file
    global_params, species_params = parse_input(ARGS[1])

    # TODO: read-in random seed
    rng = MersenneTwister(1234);

    check_initial_conditions!(global_params, species_params)

    output_global_params(global_params)

    species_data = load_species_data(global_params, species_params)
    interaction_data = load_interaction_data(global_params, species_data)
    compute_initial_conditions!(global_params, species_params, species_data)
    particles = create_particles(global_params, species_params, species_data, rng)

    global_macro_params, species_macro_params = create_macroscopic_parameters(species_params, global_params.n_species)

    compute_macroscopic_parameters!(global_macro_params, species_macro_params, species_data, global_params.n_species, particles)
    output_per_timestep(global_macro_params, species_macro_params, global_params.n_species, 0)

    for t in 1:global_params.n_timesteps
        # convect(t/2)
        # collide
        # convect(t/2)
        compute_macroscopic_parameters!(global_macro_params, species_macro_params, species_data, global_params.n_species, particles)
        output_per_timestep(global_macro_params, species_macro_params, global_params.n_species, t)
    end
    # time counter
    # compute macroscopic parameters
    # output
end

main()
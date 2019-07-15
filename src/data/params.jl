mutable struct SpeciesParams
    species::String
    fnum::Float64
    nparticles::Int64 # computed or specified

    ndens::Float64  # either this or nfrac can be specified
    nfrac::Float64
    p::Float64  # pressure
    rho::Float64  # either this or rhofrac can be specified
    rhofrac::Float64

    T::Float64

    df_type::String  # distribution function
    df_offset::Array{Float64,1}  # offset of distribution function in velocity space
end

mutable struct GlobalParams
    description::String
    species_file::String
    interactions_file::String

    n_species::Int64
    timestep::Float64
    n_timesteps::Int64
    use_single_fnum::Bool  # if fnum is the same for all species, we can simplify collision scheme
    # add species list!!!
end

mutable struct MacroParams
    vel::Array{Float64,1}
    ndens::Float64
    T::Float64
    kinetic_energy::Float64
    nparticles::Int64
end


function create_macroscopic_parameters(species_params, n_species)
    species_macro_params = MacroParams[]

    for i=1:n_species
        smp = MacroParams([0.0, 0.0, 0.0], 0.0, 0.0, 0.0, species_params[i].nparticles)

        push!(species_macro_params, smp)
    end

    global_macro_params = MacroParams([0.0, 0.0, 0.0], 0.0, 0.0, 0.0, 0)

    return global_macro_params, species_macro_params
end
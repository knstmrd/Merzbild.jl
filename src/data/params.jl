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

    fnum::Float64
    nparticles::Int64
    ndens::Float64
    p::Float64
    rho::Float64
    T::Float64

    timestep::Float64
    num_timesteps::Int64
    use_single_fnum::Bool  # if fnum is the same for all species, we can simplify collision scheme
    # add species list!!!
end
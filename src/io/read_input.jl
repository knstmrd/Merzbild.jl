using YAML

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
    particles_file::String
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
end

function parse_input(filename)
    data = YAML.load(open(filename))

    species_params = SpeciesParams[]

    global_params =  GlobalParams(data["description"], data["particles file"], data["interactions file"], -1.0, -1, -1.0, -1.0, -1.0, -1.0,
                                  data["timestep"], data["number of timesteps"], true)

    global_params.fnum = get(data, "global fnum", -1.0)
    global_params.nparticles = get(data, "global nparticles", -1.0)
    global_params.ndens = get(data, "global ndens", -1.0)
    global_params.p = get(data, "global p", -1.0)
    global_params.rho = get(data, "global rho", -1.0)
    global_params.T = get(data, "global T", -1.0)

    for k in data["initial conditions"]
        sp = SpeciesParams(k["species"], -1.0, -1, -1.0, -1.0, -1.0, -1.0, -1.0, -1.0, k["distribution function"], k["distribution function offset"])

        sp.fnum = get(k, "fnum", -1.0)
        sp.nparticles = get(k, "nparticles", -1.0)
        sp.ndens = get(k, "ndens", -1.0)
        sp.nfrac = get(k, "ndens", -1.0)
        sp.p = get(k, "p", -1.0)
        sp.rho = get(k, "rho", -1.0)
        sp.rhofrac = get(k, "rhofrac", -1.0)

        push!(species_params, sp)
    end

    return global_params, species_params
end
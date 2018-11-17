using YAML

struct SpeciesParams
    name
    fnum
    nparticles # computed or specified
    ndens  # either this or nfrac can be specified
    nfrac
    p  # pressure
    rho  # either this or rhofrac can be specified
    rhofrac
    df_type  # distribution function
    df_offset  # offset of distribution function in velocity space
end

struct GlobalParams
    particles_file::String
    interactions_file::String

    fnum::Float64
    nparticles::Int64
    ndens::Float64
    p::Float64
    rho::Float64

    timestep::Float64
    num_timesteps::Int64
    use_single_fnum::Bool  # if fnum is the same for all species, we can simplify collision scheme
end

function parse_input(filename)

    data = YAML.load(open(filename))

    global_params =  GlobalParams(data["particles file"], data["interactions file"], 0.0, 0, 0.0, 0.0, 0.0,
                                  data["timestep"], data["number of timesteps"], true)


    println(data)
    return global_params
end
using YAML

function parse_input(filename)
    data = YAML.load(open(filename))

    species_params = SpeciesParams[]

    global_params =  GlobalParams(data["description"], data["species file"], data["interactions file"], -1.0, -1, -1.0, -1.0, -1.0, -1.0, 0,
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
        sp.nfrac = get(k, "nfrac", -1.0)
        sp.p = get(k, "p", -1.0)
        sp.rho = get(k, "rho", -1.0)
        sp.rhofrac = get(k, "rhofrac", -1.0)
        sp.T = get(k, "T", -1.0)
        global_params.n_species += 1

        push!(species_params, sp)
    end

    return global_params, species_params
end
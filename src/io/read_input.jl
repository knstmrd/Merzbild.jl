using YAML

struct SpeciesInput
    name
    ndens
    fnum
    nfrac
    rho
    rhofrac
end

function parse_input(filename)

    data = YAML.load(open(filename))
    fnum = data["global fnum"]
    particles_data_file = data["particles file"]
    println(particles_data_file, fnum)
end
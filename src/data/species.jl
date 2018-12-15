struct SpeciesData
    species::String

    mass::Float64
    diameter::Float64
end


function load_species_data(global_params, species_params)

    species_data = SpeciesData[]

    data = YAML.load(open(global_params.species_file))

    for species in species_params
        sp_data = SpeciesData(species.species, data[species.species]["Mass, kg"], data[species.species]["Diameter, m"])

        push!(species_data, sp_data)
    end

    return species_data
end
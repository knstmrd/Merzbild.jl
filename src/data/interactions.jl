struct InteractionDataSingle
    species1::String
    species2::String

    collision_mass::Float64
    collision_diameter::Float64
end


function load_interaction_data(global_params, species_data)
    interaction_data = Dict{String,InteractionDataSingle}()

    for species1_id in 1:length(species_data)
        for species2_id in species1_id:length(species_data)
            species1 = species_data[species1_id]
            species2 = species_data[species2_id]

            collision_diameter = 0.5 * (species1.diameter + species2.diameter)
            collision_mass = species1.mass * species2.mass / (species1.mass + species2.mass)

            interaction_data_single = InteractionDataSingle(species1.species, species2.species, collision_mass, collision_diameter)

            interaction_data[species1.species * " + " * species2.species] = interaction_data_single
            println("Added interaction_data for ", species1.species, " + ", species2.species)
        end
    end

    return interaction_data
end
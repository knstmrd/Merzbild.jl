function output_global_params(global_params)
    println("Description: ", global_params.description)
    println("Species data file: ", global_params.species_file)
end

function output_per_timestep(global_macro_params, species_macro_params, n_species, t)
    println("Output at timestep ", t)

    for i in 1:n_species
        println("Velocity ", species_macro_params[i].vel)
        println("Temperature ", species_macro_params[i].T)
        println("Number density ", species_macro_params[i].ndens)
        println()
    end
end
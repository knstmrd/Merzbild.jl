function compute_macroscopic_parameters!(global_macro_params, species_macro_params, species_data, n_species, particles)
    
    global_macro_params.ndens = 0.0

    for species_id in 1:n_species
        ndens = 0.0
        species_macro_params[species_id].vel = [0.0, 0.0, 0.0]
        species_macro_params[species_id].ndens = 0.0
        for i in 1:species_macro_params[species_id].nparticles
            species_macro_params[species_id].vel += particles[i].vel * particles[i].fnum
            species_macro_params[species_id].ndens += particles[i].fnum
        end

        species_macro_params[species_id].vel /= species_macro_params[species_id].ndens
        global_macro_params.ndens += species_macro_params[species_id].ndens
    end


    for species_id in 1:n_species
        species_macro_params[species_id].kinetic_energy = 0.0
        for i in 1:species_macro_params[species_id].nparticles
            vel = particles[i].vel - species_macro_params[species_id].vel
            species_macro_params[species_id].kinetic_energy += sum(vel.*vel)
        end
        species_macro_params[species_id].kinetic_energy *= 0.5 * species_data[species_id].mass
        species_macro_params[species_id].T = (2.0 / 3.0) * species_macro_params[species_id].kinetic_energy / (constants.k * (species_macro_params[species_id].nparticles - 1))
    end

end

function compute_initial_conditions!(global_params, species_params, species_data)
    for species_param in species_params
        species_param.nparticles = round(Int64, species_param.ndens / species_param.fnum)

        println("Will create ", species_param.nparticles, " particles of species ", species_param.species)
    end
end

function check_initial_conditions!(global_params, species_params)
    for sp in species_params
        if sp.fnum < 0.0
            error("fnum not specified for species " * sp.species)
        end
        if sp.T < 0.0
            error("T not specified for species " * sp.species)
        end

        if (sp.ndens >= 0.0)
            if ((sp.p >= 0.0) || (sp.rho >= 0.0))
                error("Cannot specify species number density AND species pressure/density; both specified for species " * sp.species)
            end
        elseif (sp.p >= 0.0)
            if ((sp.ndens >= 0.0) || (sp.rho >= 0.0))
                error("Cannot specify species pressure AND species density/number density; both specified for species " * sp.species)
            end
        elseif  (sp.rho >= 0.0)
            if ((sp.p >= 0.0) || (sp.ndens >= 0.0))
                error("Cannot specify density AND species pressure/number density; both specified for species " * sp.species)
            end
        end

        if (sp.p >= 0.0)
            sp.ndens = sp.p / (constants.k * sp.T)
        end
    end
end
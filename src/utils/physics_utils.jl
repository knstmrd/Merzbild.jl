function compute_initial_conditions(species_params, global_params)

end

function check_initial_conditions_species(species_params, global_fnum, full_init_species)

end

function check_initial_conditions(species_params, global_params)
    # check initial conditions for consistency
    global_fnum = false
    global_np = false
    global_ndens = false
    global_p = false
    global_rho = false
    global_T = false

    full_init_species = false  # if true, each species needs to specify not fraction, but full ndens/pressure/density

    if global_params.fnum > 0.0
        global_fnum = true
    end
    if global_params.nparticles > 0.0
        global_np = true
    end
    if global_params.ndens > 0.0
        global_ndens = true
    end
    if global_params.p > 0.0
        global_p = true
    end
    if global_params.rho > 0.0
        global_rho = true
    end

    if global_params.T > 0.0
        global_T = true
    end

    if (global_ndens)
        if (global_p || global_rho)  # check that only number density is set
            error("Cannot specify global number density AND global pressure/density")
        end
    elseif (global_p)
        if (global_rho)  # check that only pressure is set
            error("Cannot specify global pressure AND global density")
        end
    end

    if (global_p)
        if (global_T)
            global_params.ndens = global_params.p / (1.38064852e-23 * global_params.T)
        else
            error("Cannot specify global pressure without specifying global temperature")
        end
    end

    if ((!global_ndens) && (!global_p) && (!global_rho))
        full_init_species = true
    end

    check_initial_conditions_species(species_params, global_fnum, full_init_species)
end
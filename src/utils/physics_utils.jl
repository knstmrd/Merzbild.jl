function compute_initial_conditions(species_params, global_params, particle_data)

end

function check_initial_conditions_species(global_params, species_params, global_fnum, global_T, full_init_species)
    for sp in species_params
        if (global_fnum)
            if sp.fnum < 0.0
                sp.fnum = global_params.fnum
            else
                error("Cannot specify global fnum AND species-specific fnum (specified for species " * sp.species * ")")
            end
        else
            if sp.fnum < 0.0
                error("fnum not specified for species " * sp.species)
            end
        end

        if (global_T)
            if sp.T < 0.0
                sp.T = global_params.T
            else
                error("Cannot specify global T AND species-specific T (specified for species " * sp.species * ")")
            end
        else
            if sp.T < 0.0
                error("T not specified for species " * sp.species)
            end
        end

        if (full_init_species)
            if ((sp.ndens < 0.0) && (sp.p < 0.0) && (sp.rho < 0.0))
                error("Need to specify either global or species number density/pressure/density; none specified for species " * sp.species)
            else
                if (sp.ndens >= 0.0)
                    if ((sp.p >= 0.0) || (sp.rho > 0.0))
                        error("Cannot specify species number density AND species pressure/density; both specified for species " * sp.species)
                    end
                elseif (sp.p >= 0.0)
                    if (sp.rho > 0.0)
                        error("Cannot specify species pressure AND species density; both specified for species " * sp.species)
                    end
                end

                if (sp.p >= 0.0)
                    sp.ndens = sp.p / (constants.k * sp.T)
                end
            end
        else
            if ((sp.ndens > 0.0) || (sp.p > 0.0) || (sp.rho > 0.0))
                error("Cannot specify global number density/pressure/density AND species number density/pressure/density; both specified for species " * sp.species)
            else
                if ((sp.nfrac > 0.0) && (sp.rhofrac > 0.0))
                    error("Cannot specify molar fraction AND mass fraction; both specified for species " * sp.species)
                elseif ((sp.nfrac < 0.0) && (sp.rhofrac < 0.0))
                    error("Molar fraction/mass fraction not specified for species " * sp.species)
                end
            end
        end
    end
end

function check_initial_conditions(global_params, species_params)
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
            global_ndens = true
            global_params.ndens = global_params.p / (constants.k * global_params.T)
        else
            error("Cannot specify global pressure without specifying global temperature")
        end
    end

    if ((!global_ndens) && (!global_p) && (!global_rho) && (!global_np))
        full_init_species = true
    end

    if ((global_ndens) && (global_fnum) && (global_np))
        error("Cannot specify global number density, fnum and number of particles simultaneously")
    end

    check_initial_conditions_species(global_params, species_params, global_fnum, global_T, full_init_species)
end
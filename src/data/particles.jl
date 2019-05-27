include("../utils/distributions.jl")

mutable struct Particle
    fnum::Float64
    vel::Array{Float64,1}
end

function create_particles(global_params, species_params, species_data, rng)
    particles = Particle[]

    for species_id in 1:global_params.n_species
        for i in 1:species_params[species_id].nparticles


            p = Particle(species_params[species_id].fnum,
                         maxwellian(species_params[species_id].T,
                         species_data[species_id].mass, rng))
            push!(particles, p)

        end
    end

    return particles
end
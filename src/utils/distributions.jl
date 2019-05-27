function maxwellian(T, mass, rng)
    return sqrt(constants.k * T / mass) * randn(rng, (3,))
end
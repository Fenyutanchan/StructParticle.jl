abstract type AbstractParticle end

struct Particle <: AbstractParticle
    PDGID::Integer
    Momentum::Vector{<:Real}
    Energy::Real
    Mass::Real
end

struct Jet <: AbstractParticle
    PDGID::Union{Integer, Nothing}
    Momentum::Vector{<:Real}
    Energy::Real
    Mass::Real
    Particles::Vector{<:AbstractParticle}
end

struct Event
    Event_Weight::Real
    Particles::Vector{<:AbstractParticle}
end

Particle(p::Particle)   =   p
Particle(j::Jet)        =   Particle(
    j.PDGID,
    j.Momentum,
    j.Energy,
    j.Mass
)

Jet(p::Particle)        =   Jet(
    p.PDGID,
    p.Momentum,
    p.Energy,
    p.Mass,
    [p]
)
Jet(j::Jet)             =   j

Event(e::Event)         =   e

# zero(::AbstractParticle)    =   Particle(0, [0, 0, 0], 0, 0)
# zero(::Particle)            =   Particle(0, [0, 0, 0], 0, 0)
# zero(::Jet)                 =   Jet(0, [0, 0, 0], 0, 0, Particle[])
# zero(::Event)               =   Event(0, AbstractParticle[])
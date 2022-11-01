# import  Base.zero
import  Base.Dict

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
    Particles::Vector{Particle}
end

struct Event
    Event_Weight::Real
    Particles::Vector{<:AbstractParticle}
end

Dict(p::Particle)   =   Dict(
    "PDGID"     =>  p.PDGID,
    "Momentum"  =>  p.Momentum,
    "Energy"    =>  p.Energy,
    "Mass"      =>  p.Mass
)
Dict(j::Jet)        =   Dict(
    "PDGID"     =>  j.PDGID,
    "Momentum"  =>  j.Momentum,
    "Energy"    =>  j.Energy,
    "Mass"      =>  j.Mass,
    "Particles" =>  Dict.(j.Particles)
)
Dict(e::Event)      =   Dict(
    "Event_Weight"  =>  e.Event_Weight,
    "Particles"     =>  Dict.(e.Particles)
)

Particle(p::Particle)   =   p
Particle(j::Jet)        =   Particle(
    j.PDGID,
    j.Momentum,
    j.Energy,
    j.Mass
)
Particle(d::Dict)       =   Particle(
    d["PDGID"],
    d["Momentum"],
    d["Energy"],
    d["Mass"]
)

Jet(p::Particle)        =   Jet(
    p.PDGID,
    p.Momentum,
    p.Energy,
    p.Mass,
    [p]
)
Jet(j::Jet)             =   j
Jet(d::Dict)            =   Jet(
    d["PDGID"],
    d["Momentum"],
    d["Energy"],
    d["Mass"],
    Particle.(d["Particles"])
)

Event(d::Dict)  =   Event(
    d["Event_Weight"],
    Particle.(d["Particles"])
)

# zero(::AbstractParticle)    =   Particle(0, [0, 0, 0], 0, 0)
# zero(::Particle)            =   Particle(0, [0, 0, 0], 0, 0)
# zero(::Jet)                 =   Jet(0, [0, 0, 0], 0, 0, Particle[])
# zero(::Event)               =   Event(0, AbstractParticle[])
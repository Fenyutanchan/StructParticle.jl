module StructParticle

    using   JLD2

    export  AbstractParticle
    export  Particle, Jet
    export  Event

    export  read_events_JLD2
    export  write_events_JLD2

    export  read_events_JLD2_old
    export  write_events_JLD2_old

    include("Particle.jl")
    include("ForJLD2.jl")

end # module StructParticle

module StructParticle

    using   JLD2
    using   ProgressMeter

    export  AbstractParticle
    export  Particle, Jet
    export  Event

    export  read_events_JLD2
    export  read_jets_JLD2
    export  write_events_JLD2
    export  write_jets_JLD2

    include("Particle.jl")
    include("ForJLD2.jl")

end # module StructParticle

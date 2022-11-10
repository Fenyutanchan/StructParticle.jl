import  Base.Dict

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

Particle(d::Dict)       =   Particle(
    d["PDGID"],
    d["Momentum"],
    d["Energy"],
    d["Mass"]
)

Jet(d::Dict)            =   Jet(
    d["PDGID"],
    d["Momentum"],
    d["Energy"],
    d["Mass"],
    Particle.(d["Particles"])
)

Dict_to_Particle_or_Jet(d::Dict)::AbstractParticle  =   if "Particles" ∈ keys(d)
    return  Jet(d)
else
    return  Particle(d)
end

Event(d::Dict)  =   Event(
    d["Event_Weight"],
    Dict_to_Particle_or_Jet.(d["Particles"])
)

function read_events_JLD2(file_name::String, index::String)::Event
    @assert splitext(file_name)[end] == ".jld2"

    jld_file    =   jldopen(file_name, "r")
    jld_keys    =   keys(jld_file)

    @assert index ∈ jld_keys
    event   =   Event(jld_file[index])

    close(jld_file)
    return  event
end
read_events_JLD2(file_name::String, index::Int)::Event  =   read_events_JLD2(
    file_name, "$index"
)
function read_events_JLD2(file_name::String)::Vector{Event}
    @assert splitext(file_name)[end] == ".jld2"

    jld_file    =   jldopen(file_name, "r")
    jld_keys    =   sort(Meta.parse.(keys(jld_file)))
    event_list  =   Event[Event(jld_file["$key"]) for key ∈ jld_keys]
    close(jld_file)
    
    return event_list
end

function write_events_JLD2(file_name::String, event_list::Vector{Event})::Nothing
    if splitext(file_name)[end] != ".jld2"
        file_name   *=  ".jld2"
    end

    file_content    =   Dict{String, Dict}()
    for ii ∈ eachindex(event_list)
        file_content["$ii"]    =   Dict(event_list[ii])
    end
    save(file_name, file_content)
    return  nothing
end
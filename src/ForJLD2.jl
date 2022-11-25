function write_events_JLD2(file_name::String, event_list::Vector{Event})::Nothing
    if splitext(file_name)[end] != ".jld2"
        file_name   *=  ".jld2"
    end

    file_content    =   Symbol.("Event_" .* string.(eachindex(event_list))) .=> event_list
    jldsave(file_name; file_content...)
    return  nothing
end

# read_events_JLD2(file_name::String, index::String)::Event   =   load(file_name, index)
read_events_JLD2(file_name::String, index::Int)::Event      =   load(file_name, "Event_$index")
function read_events_JLD2(file_name::String)::Vector{Event}
    jld_keys    =   jldopen(file_name, "r") do jld_file
        keys(jld_file)
    end

    event_list  =   Vector{Event}(undef, length(jld_keys))
    @showprogress for ii in eachindex(jld_keys)
        event_list[ii]  =   read_events_JLD2(file_name, ii)
    end
    return  event_list
end
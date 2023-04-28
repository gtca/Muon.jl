read_attribute(obj::Union{ZArray, ZGroup}, attrname::AbstractString) = obj.attrs[attrname]
attributes(obj::Union{ZArray, ZGroup}) = obj.attrs
Base.read(arr::ZArray) = arr[(Colon() for _ in 1:ndims(arr))...]
Base.read(grp::ZGroup, name::AbstractString) = grp[name][(Colon() for _ in 1:ndims(grp[name]))...]

is_compound(arr::ZArray) = false
is_bool(arr::ZArray) = eltype(arr) == Bool

Base.keys(group::ZGroup) = Iterators.flatten((keys(group.arrays), keys(group.groups)))
Base.length(group::ZGroup) = length(group.arrays) + length(group.groups)
Base.close(obj::Union{ZArray, ZGroup}) = nothing

function Base.iterate(group::ZGroup, i=nothing)
    iter = isnothing(i) ? keys(group) : i[1]
    next = isnothing(i) ? iterate(iter) : iterate(iter, i[2])
    return isnothing(next) ? next : ((next[1] => group[next[1]]), (iter, next[2]))
end

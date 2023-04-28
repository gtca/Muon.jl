read_attribute(obj::Union{ZArray, ZGroup}, attrname::AbstractString) = obj.attrs[attrname]
attributes(obj::Union{ZArray, ZGroup}) = obj.attrs
read(arr::ZArray) = arr[(Colon() for _ in 1:ndims(arr))...]
read(grp::ZGroup, name::AbstractString) = grp[name][(Colon() for _ in 1:ndims(grp[name]))...]

is_compound(arr::ZArray) = false
is_bool(arr::ZArray) = eltype(arr) == Bool

Base.keys(group::ZGroup) = Iterators.flatten((keys(group.arrays), keys(group.groups)))

close(obj::Union{ZArray, ZGroup}) = nothing

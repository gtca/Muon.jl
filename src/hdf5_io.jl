_datatype(::Type{T}) where T = datatype(T)

function _datatype(::Type{T}) where {T <: AbstractString}
    strdtype = HDF5.API.h5t_copy(HDF5.API.H5T_C_S1)
    HDF5.API.h5t_set_size(strdtype, HDF5.API.H5T_VARIABLE)
    HDF5.API.h5t_set_cset(strdtype, HDF5.API.H5T_CSET_UTF8)

    HDF5.Datatype(strdtype)
end

function _datatype(::Type{Bool})
    dtype = create_datatype(HDF5.API.H5T_ENUM, sizeof(Bool))
    HDF5.API.h5t_enum_insert(dtype, "FALSE", Ref(false))
    HDF5.API.h5t_enum_insert(dtype, "TRUE", Ref(true))
    return dtype
end

is_compound(arr::HDF5.Dataset) = HDF5.API.h5t_get_class(datatype(f)) == HDF5.API.H5T_COMPOUND
is_bool(arr::HDF5.Dataset) = datatype(f) == _datatype(Bool)

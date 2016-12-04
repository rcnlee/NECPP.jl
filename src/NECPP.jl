module NECPP

export handle_nec
export NecContext, nec_create, nec_wire, nec_geometry_complete, nec_gn_card, nec_fr_card, nec_ex_card, 
    nec_rp_card, nec_impedance_real, nec_impedance_imag, nec_delete

using PyCall
using RLESUtils, Observers, LogSystems

@pyimport necpp

include("logdefs.jl")

type NecContext
    obj::PyObject
    logsys::LogSystem
end

function handle_nec(result::Int64)
    if result != 0
        println(necpp.nec_error_message())
    end
end

###
# Categories and functions follow original API docs.
# See tmolteno.github.io/necpp/libnecpp_8h.html 

################################################################################
## Context 
"""
Create a nec context
"""
function nec_create(logsys::LogSystem=logsystem()) 
    @notify_observer(logsys.observer, "cards", ["CE"])
    NecContext(necpp.nec_create(), logsys)
end

"""
Delete a nec context
"""
nec_delete(nec::NecContext) = necpp.nec_delete(nec.obj) 

################################################################################
## Antenna geometry
"""
Create a straight wire
"""
function nec_wire(nec::NecContext, tag_id::Int64, segment_count::Int64, xw1::Float64, 
    yw1::Float64, zw1::Float64, xw2::Float64, yw2::Float64, zw2::Float64, rad::Float64, 
    rdel::Float64, rrad::Float64) 

    @notify_observer(nec.logsys.observer, "cards", ["GW", tag_id, segment_count,
        xw1, yw1, zw1, xw2, yw2, zw2, rad, rdel, rrad])
    necpp.nec_wire(nec.obj, tag_id, segment_count, xw1, yw1, zw1, xw2, 
        yw2, zw2, rad, rdel, rrad)
end

"""
Indicate that the geometry is complete (GE card)
"""
function nec_geometry_complete(nec::NecContext, gpflag::Int64)
    @notify_observer(nec.logsys.observer, "cards", ["GE", gpflag])
    necpp.nec_geometry_complete(nec.obj, gpflag)
end

################################################################################
## Antenna environment

"""
Ground card
"""
function nec_gn_card(nec::NecContext, iperf::Int64, nradl::Int64, epse::Float64, sig::Float64,
    tmp3::Float64, tmp4::Float64, tmp5::Float64, tmp6::Float64)
    @notify_observer(nec.logsys.observer, "cards", ["GN", iperf, nradl, 0, 0, epse, 
        sig, tmp3, tmp4, tmp5, tmp6])
    necpp.nec_gn_card(nec.obj, iperf, nradl, epse, sig, tmp3, tmp4, tmp5, tmp6)
end

"""
FR card
"""
function nec_fr_card(nec::NecContext, in_ifrq::Int64, in_nfrq::Int64, in_freq_mhz::Float64,
    in_del_freq::Float64)
    @notify_observer(nec.logsys.observer, "cards", ["FR", in_ifrq, in_nfrq, 0, 0, in_freq_mhz, 
        in_del_freq])
    necpp.nec_fr_card(nec.obj, in_ifrq, in_nfrq, in_freq_mhz, in_del_freq)
end

"""
EX card
"""
function nec_ex_card(nec::NecContext, extype::Int64, i2::Int64, i3::Int64, i4::Int64, 
    tmp1::Float64, tmp2::Float64, tmp3::Float64, tmp4::Float64, tmp5::Float64, 
    tmp6::Float64)  

    @notify_observer(nec.logsys.observer, "cards", ["EX", extype, i2, i3, i4, tmp1, 
        tmp2, tmp3, tmp4, tmp5, tmp6])
    necpp.nec_ex_card(nec.obj, extype, i2, i3, i4, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6)
end

################################################################################
## Simulation Output
"""
Standard radiation pattern parameters
"""
function nec_rp_card(nec::NecContext, calc_mode::Int64, n_theta::Int64, n_phi::Int64,
    output_format::Int64, normalization::Int64, D::Int64, A::Int64, theta0::Float64,
    phi0::Float64, delta_theta::Float64, delta_phi::Float64, radial_distance::Float64,
    gain_norm::Float64) 

    @notify_observer(nec.logsys.observer, "cards", ["RP", calc_mode, n_theta, n_phi,
        output_format, normalization, D, A, theta0, phi0, delta_theta, delta_phi,
        radial_distance, gain_norm])
    necpp.nec_rp_card(nec.obj, calc_mode, n_theta, n_phi, output_format, normalization,
        D, A, theta0, phi0, delta_theta, delta_phi, radial_distance, gain_norm)
end


################################################################################
## Analysis of Output
"""
Impedance: Real part
"""
nec_impedance_real(nec::NecContext, freq_index::Int64) = 
    necpp.nec_impedance_real(nec.obj, freq_index)

"""
Impedance: Imaginary part
"""
nec_impedance_imag(nec::NecContext, freq_index::Int64) = 
    necpp.nec_impedance_imag(nec.obj, freq_index)

end # module

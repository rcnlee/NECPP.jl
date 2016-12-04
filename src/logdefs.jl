import Compat.ASCIIString

function logsystem()
    logsys = LogSystem()

    register_log!(logsys, "nec_cards", ["card"], [ASCIIString], "cards",
        x->begin
            code = x[1]
            txt = cardtext(Val{Symbol(code)}, x)
            [txt]
        end) 
    logsys
end

function cardtext(::Type{Val{:CM}}, args)
    #"CM", comment = args
    cardtext(args)
end

function cardtext(::Type{Val{:CE}}, args)
    #"CE", comment = args
    cardtext(args)
end

function cardtext(::Type{Val{:GW}}, args)
    #"GW", tag_id, segment_count, xw1, yw1, zw1, xw2, yw2, zw2, rad, radel, rrad = args
    rad = args[10]
    if rad == 0.0
        error("Tapering not implemented")
    end
    join(map(string, args[1:10]), "\t") 
end

function cardtext(::Type{Val{:GE}}, args)
    #"GE", gpflag = args
    cardtext(args)
end

function cardtext(::Type{Val{:GN}}, args)
    #"GN", iperf, nradl, 0, 0, epse, sig, tmp3, tmp4, tmp5, tmp6 = args
    cardtext(args)
end

function cardtext(::Type{Val{:FR}}, args)
    #"FR", in_ifrq, in_nfrq, 0, 0, in_freq_mhz, in_del_freq = args
    cardtext(args)
end

function cardtext(::Type{Val{:EX}}, args)
    #"EX", extype, i2, i3, i4, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6
    cardtext(args)
end

function cardtext(::Type{Val{:RP}}, args)
    #"RP", calc_mode, n_theta, n_phi, output_format, normalization, 
        #D, A, theta0, phi0, delta_theta, delta_phi, radial_distance, 
        #gain_norm] = args
    cardtext(args)
end

cardtext(::Any, args) = cardtext(args)
cardtext(args) = join(map(string, args), "\t")

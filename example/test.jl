###
# Example translated from the original necpp package:
# https://github.com/tmolteno/necpp/blob/master/example/test.py

using NECPP

function frequency_response()
    # Scan through frequencies from 1 to 30 MHz
    for f = 1.0:30.0
        nec = nec_create()
        handle_nec(nec_wire(nec, 1, 17, 0.0, 0.0, 2.0, 0.0, 0.0, 11.0, 0.1, 1.0, 1.0))
        handle_nec(nec_geometry_complete(nec, 1))
        handle_nec(nec_gn_card(nec, 1, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0))
        handle_nec(nec_fr_card(nec, 0, 1, f, 0.0))
        handle_nec(nec_ex_card(nec, 0, 0, 5, 0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0))
        handle_nec(nec_rp_card(nec, 0, 90, 1, 0, 5, 0, 0, 0.0, 90.0, 1.0, 0.0, 0.0, 0.0))
        result_index = 0
        z = Complex(nec_impedance_real(nec,result_index), 
            nec_impedance_imag(nec,result_index))
        @printf "f=%0.2fMHz \t(%6.1f,%+6.1fI) Ohms\r\n" f z.re z.im
        nec_delete(nec)
    end
end

#frequency_response()

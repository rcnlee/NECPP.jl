# NECPP.jl

Author: Ritchie Lee (ritchie.lee@sv.cmu.edu)

This is a Julia wrapper for the necpp python package (https://pypi.python.org/pypi/necpp)
The python package itself is based on NEC++ (https://github.com/tmolteno/necpp)
Main documentation page of original package is at http://tmolteno.github.io/necpp/index.html

## Installation ##

NECPP.jl uses PyCall.jl to wrap the python functions.

First install Python on your system (e.g., Python 3.5), then run
``pip install necpp``
Test that you can import the module in Python.

In Julia,
* ENV["PYTHON"] = "path/to/your/python.exe"
* Pkg.clone("github.com/rcnlee/necpp.jl", "NECPP") 
* Pkg.build("PyCall")

## Usage ##

To make the package function available:
```
using NECPP
```

## Example ##

An example file is available under example/test.jl, that mirrors the test.py example in the original necpp repo (https://github.com/tmolteno/necpp). To run the example, 

```julia
cd(Pkg.dir("NECPP/example"))
include("test.jl")
frequency_response()
```

which should output the impedance of a wire antenna at various frequencies.

```julia
julia> frequency_response()
f=1.00MHz       (   0.3,-4175.4I) Ohms
f=2.00MHz       (   1.3,-2068.5I) Ohms
f=3.00MHz       (   2.9,-1357.6I) Ohms
f=4.00MHz       (   5.2,-995.7I) Ohms
f=5.00MHz       (   8.1,-773.1I) Ohms
f=6.00MHz       (  11.8,-620.2I) Ohms
f=7.00MHz       (  16.3,-506.9I) Ohms
f=8.00MHz       (  21.6,-418.2I) Ohms
f=9.00MHz       (  27.9,-345.5I) Ohms
f=10.00MHz      (  35.3,-283.6I) Ohms
f=11.00MHz      (  44.2,-229.1I) Ohms
f=12.00MHz      (  55.1,-179.5I) Ohms
f=13.00MHz      (  68.9,-132.7I) Ohms
f=14.00MHz      (  87.3, -87.1I) Ohms
f=15.00MHz      ( 113.1, -41.2I) Ohms
f=16.00MHz      ( 151.6,  +5.0I) Ohms
f=17.00MHz      ( 212.7, +48.2I) Ohms
f=18.00MHz      ( 311.3, +71.8I) Ohms
f=19.00MHz      ( 447.7, +24.6I) Ohms
f=20.00MHz      ( 528.8,-148.3I) Ohms
f=21.00MHz      ( 436.6,-321.2I) Ohms
f=22.00MHz      ( 289.5,-360.4I) Ohms
f=23.00MHz      ( 189.4,-326.9I) Ohms
f=24.00MHz      ( 132.7,-278.3I) Ohms
f=25.00MHz      ( 101.0,-231.6I) Ohms
f=26.00MHz      (  83.1,-189.8I) Ohms
f=27.00MHz      (  73.3,-152.2I) Ohms
f=28.00MHz      (  68.9,-117.6I) Ohms
f=29.00MHz      (  68.6, -85.0I) Ohms
f=30.00MHz      (  72.0, -53.6I) Ohms
```

Last updated 11/28/2016

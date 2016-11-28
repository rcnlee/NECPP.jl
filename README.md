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


Last updated 11/28/2016

module Poirot

using Reexport, Printf, IRTools.All, QuadGK
@reexport using Distributions
@reexport using Statistics
using MacroTools: @forward
using Mjolnir: @trace

export Rejection
export infer, observe

include("compiler/trace.jl")
include("compiler/simplify.jl")
include("compiler/logprob.jl")

include("inference/distributions.jl")
include("inference/inference.jl")
include("inference/trivial.jl")
include("inference/quad.jl")
include("inference/rejection.jl")

end # module

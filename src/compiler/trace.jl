using Distributions
using Mjolnir: AType, Const, Basic
import Mjolnir: abstract

abstract(::Basic, ::AType{typeof(rand)}) = Float64
abstract(::Basic, ::AType{typeof(randn)}) = Float64
abstract(::Basic, ::AType{typeof(rand)}, ::AType{<:Type{Bool}}) where T = Bool

abstract(::Basic, ::AType{typeof(rand)}, T::AType{<:Distribution}) =
  Core.Compiler.return_type(rand, Tuple{Mjolnir.widen(T)})

abstract(::Basic, ::AType{Type{Bernoulli}}, ::AType{T}) where T<:AbstractFloat = Bernoulli{Float64}

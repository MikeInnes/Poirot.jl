using Mjolnir
import Mjolnir: Defaults, AType, @trace, abstract

struct ConditionError end

function observe(result::Bool)
  result || throw(ConditionError())
  return
end

abstract(::Basic, ::AType{typeof(observe)}, ::AType{Bool}) = Nothing
Mjolnir.effectful(::AType{typeof(observe)}, x) = true

struct Multi
  algs::Vector{Any}
  Multi(algs...) = new(Any[algs...])
end

function infer(f, m::Multi)
  tr = trace(typeof(f))
  for alg in m.algs
    r = infer(f, alg, tr)
    r == nothing || return r
  end
end

default() = Multi(Trivial(), Quad(), Rejection())

infer(f) = infer(f, default())

using Poirot, IRTools
import ForneyLab
import ForneyLab: FactorGraph, @RV, currentGraph, Variable, Message, PointMass, Univariate, Bernoulli

function node(::typeof(rand), b::Bernoulli)
  var = ForneyLab.Variable(id=gensym())
  ForneyLab.Bernoulli(var, mean(b))
  return var
end

function node(::typeof(rand), n::Normal)
  var = ForneyLab.Variable(id=gensym())
  ForneyLab.GaussianMeanVariance(var, n.μ, n.σ^2)
  return var
end

function node(::typeof(==), a, b)
  ForneyLab.equal(a, b)
end

node(::typeof(+), a, b) = a + b

function graph(ir)
  g = FactorGraph()
  env = Dict()
  rename(x) = x
  rename(x::IRTools.Variable) = env[x]
  last = nothing
  for (v, st) in ir
    last = env[v] = node(rename.(st.expr.args)...)
  end
  return g, last
end

f = () -> begin
  a = rand(Normal(0, 1))
  b = rand(Normal(10, 5))
  a + b
  # a == b
end

ir = Poirot.simplify!(Poirot.Abstract.@trace f())

g, out = graph(ir)
ForneyLab.draw(g)

algo = ForneyLab.sumProductAlgorithm(out)

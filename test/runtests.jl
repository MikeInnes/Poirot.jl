using Poirot, Test

@testset "Poirot" begin

@testset "Compiler" begin
  include("compiler.jl")
end

@testset "Inference" begin
  include("inference.jl")
end

end

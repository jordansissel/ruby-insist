require "insist/namespace"

require "insist/assert"
require "insist/comparators"
require "insist/enumerables"
require "insist/failure"
require "insist/nil"
require "insist/predicates"
require "insist/raises"

# Insist on correctness.
#
#
# Example:
#
#     data = { "hello" => "world" }
#     insist { data["hello"] } == "world"
#
# This class aims to work similarly to how rspec's "should" stuff does, but
# instead of molesting Object allows you to neatly wrap values with blocks
# while still checking for expected values.
class Insist
  class Failure < StandardError; end

  include Insist::Comparators
  include Insist::Enumerables
  include Insist::Nil
  include Insist::Assert
  include Insist::Raises
  include Insist::Predicates

  # Create a new insist with a block.
  #
  # Example:
  #
  #   Insist.new { value }
  #
  # Better:
  #
  #   insist { value }
  def initialize(&block)
    @callback = block
  end # def initialize

  def value
    # TODO(sissel): make caching the value optional
    @value ||= @callback.call
    return @value
  end # def value
end # class Insist

module Kernel
  # A shortcut to 'Insist.new'
  #
  # Example:
  #
  #     insist { "hello world" } != "fizzle"
  def insist(&block)
    return Insist.new(&block)
  end # def insist
end # module Kernel

require "insist/namespace"

require "insist/assert"
require "insist/comparators"
require "insist/raises"
require "insist/failure"
require "insist/nil"

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
  include Insist::Nil
  include Insist::Assert
  include Insist::Raises

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
  end

  def value
    # TODO(sissel): make caching the value optional
    @value ||= @callback.call
    return @value
  end
end # class Insist

module Kernel
  # A shortcut to 'Insist.new'
  def insist(&block)
    return Insist.new(&block)
  end
end

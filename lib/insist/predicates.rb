require "insist/namespace"
require "insist/assert"

module Insist::Predicates
  include Insist::Assert
  PREDICATE_METHOD_RE = /\?$/

  def respond_to?(method)
    assert(value.respond_to?(method),
           "#{value.class} does not respond to the '#{method}' method")
  end # def respond_to?

  # Pass through any 'foo?' style method calls to the 'value' 
  # and fail if the the return is false.
  def method_missing(m, *args)
    # If this is a predicate method (ends in question mark)
    # call it on the value and assert truthiness.
    if PREDICATE_METHOD_RE.match(m.to_s)
      insist { value }.respond_to?(m)

      # call the method, like .empty?, result must be truthy.
      result = value.send(m, *args)
      assert(result, "#{value.class}{#{value.inspect}}##{m} expected to return a truthy " \
             "value, but returned #{result}")
      return result
    else
      return super(m, *args)
    end
  end # def method_missing
end # module Insist::Predicates

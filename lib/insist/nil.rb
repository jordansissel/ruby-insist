
module Insist::Nil
  # Assert nil
  def nil?
    if !value.nil?
      raise Failure.new("Expected nil, got #{@value.inspect}")
    end
  end
end

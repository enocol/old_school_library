require_relative 'base_decorator'

class TrimmerDecorator < BaseDecorator
  MAX_LENGTH = 10

  def correct_name
    trimmed_name = super.strip
    trimmed_name.length > MAX_LENGTH ? trimmed_name[0, MAX_LENGTH] : trimmed_name
  end
end


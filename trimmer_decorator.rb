require_relative 'base_decorator'

class TrimmerDecorator < Basedecorator
  def correct_name
    @nameable.correct_name[0..9]
  end
end

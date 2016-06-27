require "test_helper"

class TipoPlanTest < ActiveSupport::TestCase
  def tipo_plan
    @tipo_plan ||= TipoPlan.new
  end

  def test_valid
    assert tipo_plan.valid?
  end
end

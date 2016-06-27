require "test_helper"

class ZonaTest < ActiveSupport::TestCase
  def zona
    @zona ||= Zona.new
  end

  def test_valid
    assert zona.valid?
  end
end

require "test_helper"

class EquipoGestorTest < ActiveSupport::TestCase
  def equipo_gestor
    @equipo_gestor ||= EquipoGestor.new
  end

  def test_valid
    assert equipo_gestor.valid?
  end
end

require "test_helper"

class ContactoGrupoTest < ActiveSupport::TestCase
  def contacto_grupo
    @contacto_grupo ||= ContactoGrupo.new
  end

  def test_valid
    assert contacto_grupo.valid?
  end
end

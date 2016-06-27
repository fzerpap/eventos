require "test_helper"

class TipoContenidoTest < ActiveSupport::TestCase
  def tipo_contenido
    @tipo_contenido ||= TipoContenido.new
  end

  def test_valid
    assert tipo_contenido.valid?
  end
end

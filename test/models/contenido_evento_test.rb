require "test_helper"

class ContenidoEventoTest < ActiveSupport::TestCase
  def contenido_evento
    @contenido_evento ||= ContenidoEvento.new
  end

  def test_valid
    assert contenido_evento.valid?
  end
end

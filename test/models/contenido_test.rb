require "test_helper"

class ContenidoTest < ActiveSupport::TestCase
  def contenido
    @contenido ||= Contenido.new
  end

  def test_valid
    assert contenido.valid?
  end
end

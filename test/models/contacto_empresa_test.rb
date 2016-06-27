require "test_helper"

class ContactoEmpresaTest < ActiveSupport::TestCase
  def contacto_empresa
    @contacto_empresa ||= ContactoEmpresa.new
  end

  def test_valid
    assert contacto_empresa.valid?
  end
end

require "test_helper"

class MensajeTest < ActiveSupport::TestCase
  def mensaje
    @mensaje ||= Mensaje.new
  end

  def test_valid
    assert mensaje.valid?
  end
end

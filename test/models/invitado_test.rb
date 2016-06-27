require "test_helper"

class InvitadoTest < ActiveSupport::TestCase
  def invitado
    @invitado ||= Invitado.new
  end

  def test_valid
    assert invitado.valid?
  end
end

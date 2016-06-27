require "test_helper"

class GrupoTest < ActiveSupport::TestCase
  def grupo
    @grupo ||= Grupo.new
  end

  def test_valid
    assert grupo.valid?
  end
end

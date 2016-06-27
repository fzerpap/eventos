require "test_helper"

class PagoEventosControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_response :success
  end

  def test_registro_pago
    get :registro_pago
    assert_response :success
  end

  def test_validar_pago
    get :validar_pago
    assert_response :success
  end

end

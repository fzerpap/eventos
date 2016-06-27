require "test_helper"

class ZonasControllerTest < ActionController::TestCase
  def zona
    @zona ||= zonas :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:zonas)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Zona.count") do
      post :create, zona: { cupos: zona.cupos, nombre: zona.nombre, num_asiento_final: zona.num_asiento_final, num_asiento_inicial: zona.num_asiento_inicial, precio: zona.precio }
    end

    assert_redirected_to zona_path(assigns(:zona))
  end

  def test_show
    get :show, id: zona
    assert_response :success
  end

  def test_edit
    get :edit, id: zona
    assert_response :success
  end

  def test_update
    put :update, id: zona, zona: { cupos: zona.cupos, nombre: zona.nombre, num_asiento_final: zona.num_asiento_final, num_asiento_inicial: zona.num_asiento_inicial, precio: zona.precio }
    assert_redirected_to zona_path(assigns(:zona))
  end

  def test_destroy
    assert_difference("Zona.count", -1) do
      delete :destroy, id: zona
    end

    assert_redirected_to zonas_path
  end
end

require "test_helper"

class InvitadosControllerTest < ActionController::TestCase
  def invitado
    @invitado ||= invitados :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:invitados)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Invitado.count") do
      post :create, invitado: { contactos_id: invitado.contactos_id, eventos_id: invitado.eventos_id, fecha_confirmacion: invitado.fecha_confirmacion, fecha_invitacion: invitado.fecha_invitacion, tipo_confirmacion: invitado.tipo_confirmacion }
    end

    assert_redirected_to invitado_path(assigns(:invitado))
  end

  def test_show
    get :show, id: invitado
    assert_response :success
  end

  def test_edit
    get :edit, id: invitado
    assert_response :success
  end

  def test_update
    put :update, id: invitado, invitado: { contactos_id: invitado.contactos_id, eventos_id: invitado.eventos_id, fecha_confirmacion: invitado.fecha_confirmacion, fecha_invitacion: invitado.fecha_invitacion, tipo_confirmacion: invitado.tipo_confirmacion }
    assert_redirected_to invitado_path(assigns(:invitado))
  end

  def test_destroy
    assert_difference("Invitado.count", -1) do
      delete :destroy, id: invitado
    end

    assert_redirected_to invitados_path
  end
end

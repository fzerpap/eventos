require "test_helper"

class MensajesControllerTest < ActionController::TestCase
  def mensaje
    @mensaje ||= mensajes :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:mensajes)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Mensaje.count") do
      post :create, mensaje: { archivo_adjunto: mensaje.archivo_adjunto, asiento: mensaje.asiento, asunto: mensaje.asunto, coordinador: mensaje.coordinador, descripcion: mensaje.descripcion, enlace: mensaje.enlace, evento_id: mensaje.evento_id, remitente: mensaje.remitente }
    end

    assert_redirected_to mensaje_path(assigns(:mensaje))
  end

  def test_show
    get :show, id: mensaje
    assert_response :success
  end

  def test_edit
    get :edit, id: mensaje
    assert_response :success
  end

  def test_update
    put :update, id: mensaje, mensaje: { archivo_adjunto: mensaje.archivo_adjunto, asiento: mensaje.asiento, asunto: mensaje.asunto, coordinador: mensaje.coordinador, descripcion: mensaje.descripcion, enlace: mensaje.enlace, evento_id: mensaje.evento_id, remitente: mensaje.remitente }
    assert_redirected_to mensaje_path(assigns(:mensaje))
  end

  def test_destroy
    assert_difference("Mensaje.count", -1) do
      delete :destroy, id: mensaje
    end

    assert_redirected_to mensajes_path
  end
end

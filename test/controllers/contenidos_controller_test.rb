require "test_helper"

class ContenidosControllerTest < ActionController::TestCase
  def contenido
    @contenido ||= contenidos :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:contenidos)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("Contenido.count") do
      post :create, contenido: {  }
    end

    assert_redirected_to contenido_path(assigns(:contenido))
  end

  def test_show
    get :show, id: contenido
    assert_response :success
  end

  def test_edit
    get :edit, id: contenido
    assert_response :success
  end

  def test_update
    put :update, id: contenido, contenido: {  }
    assert_redirected_to contenido_path(assigns(:contenido))
  end

  def test_destroy
    assert_difference("Contenido.count", -1) do
      delete :destroy, id: contenido
    end

    assert_redirected_to contenidos_path
  end
end

require "test_helper"

class LoadVideosControllerTest < ActionController::TestCase
  def load_video
    @load_video ||= load_videos :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:load_videos)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("LoadVideo.count") do
      post :create, load_video: { fecha: load_video.fecha, nombre: load_video.nombre, video: load_video.video }
    end

    assert_redirected_to load_video_path(assigns(:load_video))
  end

  def test_show
    get :show, id: load_video
    assert_response :success
  end

  def test_edit
    get :edit, id: load_video
    assert_response :success
  end

  def test_update
    put :update, id: load_video, load_video: { fecha: load_video.fecha, nombre: load_video.nombre, video: load_video.video }
    assert_redirected_to load_video_path(assigns(:load_video))
  end

  def test_destroy
    assert_difference("LoadVideo.count", -1) do
      delete :destroy, id: load_video
    end

    assert_redirected_to load_videos_path
  end
end

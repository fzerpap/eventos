require "test_helper"

class UploadVideosControllerTest < ActionController::TestCase
  def upload_video
    @upload_video ||= upload_videos :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:upload_videos)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("UploadVideo.count") do
      post :create, upload_video: {  }
    end

    assert_redirected_to upload_video_path(assigns(:upload_video))
  end

  def test_show
    get :show, id: upload_video
    assert_response :success
  end

  def test_edit
    get :edit, id: upload_video
    assert_response :success
  end

  def test_update
    put :update, id: upload_video, upload_video: {  }
    assert_redirected_to upload_video_path(assigns(:upload_video))
  end

  def test_destroy
    assert_difference("UploadVideo.count", -1) do
      delete :destroy, id: upload_video
    end

    assert_redirected_to upload_videos_path
  end
end

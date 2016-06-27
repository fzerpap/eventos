require "test_helper"

class UploadVideosTest < ActiveSupport::TestCase
  def upload_videos
    @upload_videos ||= UploadVideos.new
  end

  def test_valid
    assert upload_videos.valid?
  end

end

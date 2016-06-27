require "test_helper"

class UploadVideoTest < ActiveSupport::TestCase
  def upload_video
    @upload_video ||= UploadVideo.new
  end

  def test_valid
    assert upload_video.valid?
  end
end

require "test_helper"

class LoadVideoTest < ActiveSupport::TestCase
  def load_video
    @load_video ||= LoadVideo.new
  end

  def test_valid
    assert load_video.valid?
  end
end

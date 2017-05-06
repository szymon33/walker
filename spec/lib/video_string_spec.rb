require "spec_helper"
require "video_string"

describe VideoString do
  let(:subject) { VideoString.new("brightcove-default(123)") }

  describe "#replace!" do
    it "is valid with one video" do
      allow(subject).to receive(:brightcove_snippet_default) { "video-123" }
      expect(subject.replace!).to eq "video-123"
    end

    it "is valid with surrounding text" do
      markdown = VideoString.new("before brightcove-default(123) after")
      allow(markdown).to receive(:brightcove_snippet_default) { "video-007" }
      expect(markdown.replace!).to eq "before video-007 after"
    end

    it "is valid with two videos" do
      markdown = VideoString.new(
        "before brightcove-default(001) after brightcove-default(001)")
      allow(markdown).to receive(:brightcove_snippet_default) { "video-001" }
      expect(markdown.replace!).to eq "before video-001 after video-001"
    end

    it "is iframe HTML tag" do
      expect(subject.replace!).to match /<iframe.+<\/iframe>/im
    end

    it "calls brightcove_snippet_default" do
      expect(subject).to receive(:brightcove_snippet_default).with("123")
      subject.replace!
    end
  end

  it "#brightcove_snippet_default" do
    expect(subject.send(:brightcove_snippet_default, "007"))
      .to include("videoId=007")
  end
end

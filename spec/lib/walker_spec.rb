require 'spec_helper'
require 'walker'

describe Walker do
  it 'example with surrounding div' do
    data = '<!--video-->
<div class="video-embed-container">
  <object class="BrightcoveExperience video-player">
  <param name="bgcolor" value="#000000">
  <param name="width" value="100%">
  <param name="playerID" value="5397585555001">
  <param name="playerKey" value="AQ~~,AAACqQLjXwE~,Nq9Z9rk3F20GNgDbGLkEDHbwMyFJR1vx">
  <param name="isVid" value="true">
  <param name="isUI" value="true">
  <param name="dynamicStreaming" value="true">
  <param name="autoStart" value="false">
  <param name="includeAPI" value="true">
  <param name="@videoPlayer" value="5397585555001">
  <param name="templateLoadHandler" value="onTemplateLoaded">
  <param name="htmlFallback" value="true">
  <param name="secureConnections" value="true">
  <param name="secureHTMLConnections" value="true">
  </object>
  <script type="text/javascript">brightcove.createExperiences();</script>
</div>'
    expect(described_class.new(data).replace!).to eq "<!--video-->\n<div class=\"video-embed-container\">\n  brightcove-default(5397585555001)\n  \n</div>"
  end

  it 'example without script' do
    data = '<!--video-->
<div class="video-embed-container">
  <object class="BrightcoveExperience video-player">
  <param name="bgcolor" value="#000000">
  <param name="width" value="100%">
  <param name="playerID" value="5397585555001">
  <param name="playerKey" value="AQ~~,AAACqQLjXwE~,Nq9Z9rk3F20GNgDbGLkEDHbwMyFJR1vx">
  <param name="isVid" value="true">
  <param name="isUI" value="true">
  <param name="dynamicStreaming" value="true">
  <param name="autoStart" value="false">
  <param name="includeAPI" value="true">
  <param name="@videoPlayer" value="5397585555001">
  <param name="templateLoadHandler" value="onTemplateLoaded">
  <param name="htmlFallback" value="true">
  <param name="secureConnections" value="true">
  <param name="secureHTMLConnections" value="true">
  </object>
</div>'
    expect(described_class.new(data).replace!).to eq "<!--video-->\n<div class=\"video-embed-container\">\n  brightcove-default(5397585555001)\n</div>"
  end
end

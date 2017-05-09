require 'spec_helper'
require 'walker'

describe Walker do
  it 'example without surrounding div' do
    data = '
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
  </object>'
    expect(described_class.new(data).replace!).to eq "\n  brightcove-public(5397585555001)"
  end

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
    expect(described_class.new(data).replace!).to eq "<!--video-->\n<div class=\"embed-responsive embed-responsive-16by9\">\n  brightcove-public(5397585555001)\n</div>"
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
    expect(described_class.new(data).replace!).to eq "<!--video-->\n<div class=\"embed-responsive embed-responsive-16by9\">\n  brightcove-public(5397585555001)\n</div>"
  end

  it 'example with other markdown tag' do
    data = 'you complete the module.

<!--video-->
<div class="video-embed-container">
  <object class="BrightcoveExperience video-player">
  <param name="bgcolor" value="#000000">
  <param name="width" value="100%">
  <param name="playerID" value="5396992326001">
  <param name="playerKey" value="AQ~~,AAACqQLjXwE~,Nq9Z9rk3F20GNgDbGLkEDHbwMyFJR1vx">
  <param name="isVid" value="true">
  <param name="isUI" value="true">
  <param name="dynamicStreaming" value="true">
  <param name="autoStart" value="false">
  <param name="includeAPI" value="true">
  <param name="@videoPlayer" value="5396992326001">
  <param name="templateLoadHandler" value="onTemplateLoaded">
  <param name="htmlFallback" value="true">
  <param name="secureConnections" value="true">
  <param name="secureHTMLConnections" value="true">
  </object>  
  <script type="text/javascript">brightcove.createExperiences();</script>
</div>

####Key points:
'
    expect(described_class.new(data).replace!).to eq \
    "you complete the module.\n\n<!--video-->\n<div class=\"embed-responsive embed-responsive-16by9\">\n  brightcove-public(5396992326001)\n</div>\n\n####Key points:\n"
  end
end

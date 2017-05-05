## Ruby. How to make markdown custom tag for complex embed video HTML and convert existing database (CMS).

### Problem description

Assuming that you already have working CMS application and you use video snippet  from 3rd party provider in its content. The snippet may look like the following:

```HTML
  <object class="BrightcoveExperience video-player">
    <param name="bgcolor" value="#000000">
    <param name="width" value="100%">
    <param name="playerID" value="5397185555001">
    <param name="playerKey" value="AQ~~,AARCqQLjXwE~,Nq9Z9rk3F20GNgDbGLkEDHbwMyFJR1vx">
    <param name="isVid" value="true">
    <param name="isUI" value="true">
    <param name="dynamicStreaming" value="true">
    <param name="autoStart" value="false">
    <param name="includeAPI" value="true">
    <param name="@videoPlayer" value="5397185555001">
    <param name="templateLoadHandler" value="onTemplateLoaded">
    <param name="htmlFallback" value="true">
    <param name="secureConnections" value="true">
    <param name="secureHTMLConnections" value="true">
  </object>

```

You want to convert your database and use like markdown tag instead. Makrdown tag is shorter yet easier to maintain. When 3rd party improve the snippet or add some new feature which you might need you would like update your records including video easily.

Markdown tag would look like this:

```
  brightcove-default(5397185555001)
```

### Solution

You could run script against your database like this:

```ruby
require "lib/walker" # you might just copy Walker class here as well

tracker = "<object class=\"BrightcoveExperience video-player\""

counter = 0
Lesson.unscoped.where("article LIKE ?", "%#{tracker}%").each do |lesson|
  article = lesson.article
  next unless article
  article = Walker.new(article).replace!

  if article != lesson.article
    counter = counter + 1
    lesson.update_column(:article, article)
  end
end

puts "#{counter} videos converted"
```

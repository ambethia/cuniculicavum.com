# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def render_flash
    [:notice, :warning, :message].collect do |key|
      content_tag(:div, flash[key], :class => key, :id => "flash") unless flash[key].blank?
    end.join
  end

  def post_url(post)
    post = post.respond_to?(:topic) ? post.topic : post
    topic_url(post, :only_path => false)
  end

  def armory_link(character)
    link_to character.name, character.armory_url, :class => character.character_class
  end

end

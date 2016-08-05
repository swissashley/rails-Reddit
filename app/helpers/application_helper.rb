module ApplicationHelper
  def auth_token
    "
      <input type='hidden'
          name='authenticity_token'
          value='#{form_authenticity_token}'
      </input>
    ".html_safe
  end

  def shorten(content)
    if content.length > 10
      return (content[0..10] + "...")
    else
      return content
    end

  end
end

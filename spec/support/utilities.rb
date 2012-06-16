# encoding: utf-8
def full_title(page_title)
  base_title = "Saassi"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
  visit signin_path
  fill_in "Sähköposti",    with: user.email
  fill_in "Salasana", with: user.password
  click_button "Kirjaudu"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

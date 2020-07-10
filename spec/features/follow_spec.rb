require 'rails_helper'

RSpec.feature "Following and unfollowing" do
  let(:ron) {create(:user, username: "Ron Weasley")}
  let(:dean) {create(:user, username: "Dean")}

  scenario "user can follow and then unfollow other user" do
    sign_in ron
    visit profile_path(dean.username)
    click_button "Follow"
    expect(page).not_to have_button("Follow")
    expect(page).to have_button("Unfollow")

    click_button "Unfollow"
    expect(page).to have_button("Follow")
    expect(page).not_to have_button("Unfollow")
  end

  scenario "users can follow each other" do
    sign_in ron
    visit profile_path(dean.username)
    click_button "Follow"
    expect(page).not_to have_button("Follow")
    expect(page).to have_button("Unfollow")

    sign_in dean
    visit profile_path(ron.username)
    click_button "Follow"
    expect(page).not_to have_button("Follow")
    expect(page).to have_button("Unfollow")
  end

end

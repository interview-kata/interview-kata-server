require "application_system_test_case"

class IssuesTest < ApplicationSystemTestCase
  setup do
    @issue = issues(:one)
  end

  test "visiting the index" do
    visit issues_url
    assert_selector "h1", text: "Issues"
  end

  test "creating a Issue" do
    visit issues_url
    click_on "New Issue"

    fill_in "Body", with: @issue.body
    fill_in "Comments count", with: @issue.comments_count
    fill_in "Html url", with: @issue.html_url
    fill_in "Labels", with: @issue.labels
    check "Locked" if @issue.locked
    fill_in "Number", with: @issue.number
    fill_in "Raw", with: @issue.raw
    fill_in "State", with: @issue.state
    fill_in "Title", with: @issue.title
    click_on "Create Issue"

    assert_text "Issue was successfully created"
    click_on "Back"
  end

  test "updating a Issue" do
    visit issues_url
    click_on "Edit", match: :first

    fill_in "Body", with: @issue.body
    fill_in "Comments count", with: @issue.comments_count
    fill_in "Html url", with: @issue.html_url
    fill_in "Labels", with: @issue.labels
    check "Locked" if @issue.locked
    fill_in "Number", with: @issue.number
    fill_in "Raw", with: @issue.raw
    fill_in "State", with: @issue.state
    fill_in "Title", with: @issue.title
    click_on "Update Issue"

    assert_text "Issue was successfully updated"
    click_on "Back"
  end

  test "destroying a Issue" do
    visit issues_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Issue was successfully destroyed"
  end
end

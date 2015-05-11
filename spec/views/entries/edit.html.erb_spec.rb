require 'rails_helper'

RSpec.describe "entries/edit", type: :view do
  before(:each) do
    @entry = assign(:entry, Entry.create!(
      :content => "MyText"
    ))
  end

  it "renders the edit entry form" do
    render

    assert_select "form[action=?][method=?]", entry_path(@entry), "post" do

      assert_select "textarea#entry_content[name=?]", "entry[content]"
    end
  end
end

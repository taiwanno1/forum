require 'rails_helper'

RSpec.describe "people/index", type: :view do
  before(:each) do
    assign(:people, [
      Person.create!(),
      Person.create!()
    ])
  end

  it "renders a list of people" do
    render
  end
end

require 'spec_helper'

describe "Creating todo lists" do
  
  def create_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "This is my todo list"
  
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo list")
    
    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end
  
  it "redirects to index page upon success" do
  create_todo_list
  expect(page).to have_content("successfully created.")
  end  
  
  it "displays an error when the todo list does not have title" do
  expect(TodoList.count).to eq(0)
  
    create_todo_list title: ""
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    
    visit "/todo_lists"
    expect(page).to_not have_content("This is what I'm doing today.")
  end
  
  it "displays an error when the todo list has a title fewer than 3 characters" do
    expect(TodoList.count).to eq(0)
  
    create_todo_list title: "hi"
    
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    
    visit "/todo_lists"
    expect(page).to_not have_content("This is what I'm doing today.")
  end
  
  it "displays an error when no description" do
    expect(TodoList.count).to eq(0)
  
    create_todo_list description:""
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
    
    visit "/todo_lists"
    expect(page).to_not have_content("This is what I'm doing today.")
  end
end
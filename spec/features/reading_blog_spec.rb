feature 'Reading the blog' do
  background do
    @post = Post.create(title: 'Awesome Post', body: 'This is awesome')
    @post.published = true
    @post.save

    Post.create(title: 'Another Awesome Post', body: 'This is awesome too')
  end

  scenario 'Reading the blog index' do
    visit root_path

    expect(page).to have_content 'Awesome Post'
    expect(page).to have_no_content 'Another Awesome Blog Post'
  end

  scenario 'Reading an individual post' do
    visit root_path
    click_link 'Awesome Post'

    expect(current_path).to eq post_path(@post)
  end
end

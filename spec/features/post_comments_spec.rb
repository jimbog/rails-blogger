feature 'Posting Comments' do
  background do
    @post = Post.create(title: 'Awesome Post', body: 'This is awesome', published: true)
  end

  scenario 'Posting a comment' do
    visit post_path(@post)

    comment = 'This is post rocks!'

    fill_in 'comment_body', with: comment
    click_button 'Add comment'

    expect(page).to have_content comment
  end
end

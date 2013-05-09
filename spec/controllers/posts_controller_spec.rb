require 'spec_helper'

describe PostsController do
  let(:user) { build_stubbed(:user) }

  before do
    request.env['warden'].stub authenticate!: user
    controller.stub current_user: user
  end

  describe "GET 'index'" do
    it "doesn't show flash notice" do
      controller.should_not_receive :display_flash_notice
      get 'index'
    end

    it "doesn't show archived posts" do
      post1 = create(:post)
      post2 = create(:post, archived: true)

      get :index
      controller.posts.to_a.should eq [post1]
    end
  end

  describe "POST mark_archived" do
    let(:blog_post) { create(:post) }

    it "changes archived attribute for post" do
      expect {
        post :mark_archived, id: blog_post
      }.to change { blog_post.reload.archived }.to(true)
    end
  end

end

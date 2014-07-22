require 'rails_helper'

RSpec.describe Post, :type => :model do
  context "同一ユーザーが" do
    it "保存してから3秒以内は保存出来ない" do
      post = Post.new(caption: 'test1', user_id:1)
      post.save
      post = Post.new(caption: 'test2', user_id:1)
      expect(post.save).to be_falsey
    end

    it "保存してから3秒以後は保存出来る" do
      post = Post.new(caption: 'test1', user_id:1)
      post.save
      allow(Time).to receive(:now) { Time.new + 4 }
      post = Post.new(caption: 'test2', user_id:1)
      expect(post.save).to be_truthy
    end
  end

  context "同一ユーザーでなければ" do
    it "保存してから3秒以内でも保存出来る" do
      post = Post.new(caption: 'test1', user_id:1)
      post.save
      post = Post.new(caption: 'test2', user_id:2)
      expect(post.save).to be_truthy
    end
  end
end

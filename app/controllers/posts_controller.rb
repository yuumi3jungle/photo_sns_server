class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate
  skip_before_action :verify_authenticity_token, if: :from_iphone?

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order(created_at: :desc).all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params_with_image_data)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.update(post_params_with_image_data)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:photo, :caption)
    end

    def post_params_with_image_data
      parameters = post_params
      if params[:post][:image_data]
        parameters[:photo] = parse_image_data(params[:post][:image_data])
      end
      parameters
    end

    def parse_image_data(image_data)
      tempfile = StringIO.new(Base64.decode64(image_data))

      def tempfile.path
        "/tmp/upload.png" 
      end

      ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, content_type:'image/png', filename:'iphone.png')
    end

    def authenticate
      if from_iphone?
        resource = User.first # TODO 
        sign_in :user, resource
       else
        authenticate_user!
      end
    end
end

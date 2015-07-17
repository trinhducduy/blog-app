class Admin::TopicsController < Admin::BaseController
  before_action :set_topic, only: [:edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
    @form_url = admin_topics_path
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      flash[:notice] = "Topic was successfully created!"
      redirect_to admin_topics_path
    else
      render :new
    end
  end

  def edit
    @form_url = admin_topic_path(@topic)
  end

  def update
    if @topic.update(topic_params)
      flash[:notice] = "Topic was successfully updated!"
      redirect_to admin_topics_path
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to :back
  end

  protected

  def set_topic
    @topic = Topic.friendly.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name, :description)
  end

end

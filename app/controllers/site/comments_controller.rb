class Site::CommentsController < SiteController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to site_ad_detail_path(@comment.ad_id), notice: 'Comentário adicionado!'
    else
      redirect_to site_ad_detail_path(@comment.ad_id), notice: 'Erro ao adicionar comentário...'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    
    if @comment.destroy
      redirect_to request.referrer, notice: 'Comentário excluído!'
    else
      render :index
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body, :ad_id)
  end
end

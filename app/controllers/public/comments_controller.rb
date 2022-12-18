class Public::CommentsController < ApplicationController
  
 def create
  post_photo = PostPhoto.find(params[:post_photo_id])
  @comment = current_poster.comments.new(comment_params)
  @comment.post_photo_id = post_photo.id
  @post = @comment.post_photo

	  
  if @comment.save
     @post.create_notification_comment!(current_poster, @comment.id)
     redirect_to post_photo_path(post_photo)
  else
     render 'post_photo/show'
  end
 end
 
 def destroy
  Comment.find(params[:id]).destroy
  redirect_to post_photo_path(params[:post_photo_id])
 end
 
 private

  def comment_params
    params.require(:comment).permit(:text)
  end

  
end

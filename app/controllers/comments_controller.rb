class CommentsController < ApplicationController
	before_action :require_user

	def create
		@post = Post.find(params[:post_id]) # el post_id viene incluido en los parametros
		#@comment = Comment.new(params.require(:comment).permit(:body))
		#@comment.post = @post
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.creator = current_user  
		if @comment.save
			flash[:notice]='Tu comentario fue añadido'
			redirect_to post_path(@post)
		else
			render 'posts/show'   # esta vista requiere los @post y @comment 
									# que este metodo contiene
		end
	end

	def vote

		comment = Comment.find(params[:id])
		Vote.create(voteable: comment, creator: current_user, vote: params[:vote])
		flash[:notice] = 'Tu voto ha sido registrado!'
		redirect_back(fallback_location: root_path)

	end

end
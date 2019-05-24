class CommentsController < ApplicationController
	before_action :require_user

	def create
		@post = Post.find_by slug: params[:post_id] # el post_id viene incluido en los parametros
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

		respond_to do |format|
			@comment = Comment.find(params[:id])
			@vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
			
			format.html do
				if @vote.valid?
					flash[:notice] = 'Tu voto ha sido registrado!'
				else
					flash[:error] = "Solo puedes votar una vez"
				end
				redirect_back(fallback_location: root_path)
			end
			format.js
		end
	end

end
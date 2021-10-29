class CommentsController < ApplicationController
    before_action :set_comment, only: [:edit, :update, :destroy]
    before_action :set_post, only: [:create, :edit, :update]

    def create
        @comment = @post.comments.create(comment_params)
        respond_to do |format|
            if  @comment.save
                format.html { redirect_to @post, notice: 'Comment was successfully created.' }
                # NOTE COMMENT STEP 1: This will run the code in `app/views/comments/create.js.erb`.
                format.js
            else
                format.html { render action: "new" }
                # NOTE COMMENT STEP 1: This will run the code in `app/views/comments/create.js.erb`.
                format.js
            end
        end
    end

    def edit
    end

    def update
        if @comment.update(comment_params)
            redirect_to @comment.post, notice: "Comment updated."
        else
            render 'edit'
        end
    end

    def destroy
        respond_to do |format|
            if @comment.destroy
                format.html { redirect_to @comment.post, notice: 'Comment was successfully destroyed.' }
                format.js
            else
                format.html { render action: "edit" }
                format.js
            end
        end
    end

    private

        def set_post
            @post = Post.find(params[:post_id])
        end

        def set_comment
            @comment = Comment.find(params[:id])
        end

        def comment_params
            params.require(:comment).permit(:body)
        end
end
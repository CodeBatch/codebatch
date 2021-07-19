class VideoCommentsController < ApplicationController
    def create
        @video = Video.find(params[:video_id])
        @video_comment = @video.video_comments.create(video_comment_params)

        redirect_to video_path(@video)
    end

    def destroy
        @video = Video.find(params[:video_id])
        @video_comment = @video.video_comments.find(params[:id])
        @video_comment.destroy

        redirect_to video_path(@video)
    end

    private
        def video_comment_params
            params.require(:video_comment).permit(:commenter,:body,:status)
        end
end

class MicropostsController < ApplicationController
    before_action :logged_in_user,only:[:create,:destroy]
    before_action :correct_user, only: :destroy
    #before_action :url_exist, only: :create

    def create
        @micropost = current_user.microposts.build(micropost_params)

        if @micropost.save && @micropost.save_http_response
            flash[:success] = "Added!"
            redirect_to root_url
        else
            @feed_items = []
            #redirect_to root_url
            render 'static_pages/home'
        end
    end

    def destroy
        @micropost.destroy
        flash[:success] = "Deleted"
        redirect_to request.referrer||root_url
    end

    private
        def micropost_params
            params.require(:micropost).permit(:url)
        end

        def correct_user
            @micropost = current_user.microposts.find_by(id: params[:id])
            redirect_to root_url if @micropost.nil?
        end

        def url_exist
            #@micropost = current_user.microposts.find_by(id: params[:id])
            redirect_to root_url if params[:micropost][:url] == ""
        end
end

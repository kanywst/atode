class MicropostsController < ApplicationController
    before_action :logged_in_user,only:[:create,:destroy]
    before_action :correct_user, only: :destroy

    def create
        agent = Mechanize.new
        page = agent.get(micropost_params[:url])
        title = page.title
        micropost_insert_params = {title: title,url: micropost_params[:url]}
        @micropost = current_user.microposts.build(micropost_insert_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = []
            render 'static_pages/home'
        end
    end

    def destroy
        @micropost.destroy
        flash[:success] = "Micropost delete"
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
end

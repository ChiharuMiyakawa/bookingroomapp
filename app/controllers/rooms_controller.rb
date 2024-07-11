class RoomsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    def index
        @rooms = Room.all
    end
  
    def show
        @room = Room.find(params[:id])
        @reservation = Reservation.new(room_id: @room.id)
    end
  
    def new
        @room = Room.new
        @rooms = Room.all
    end
  
    def edit
        @room = Room.find(params[:id])
    end
  
    def create
        @room = Room.new(room_params)
        @room.user_id = current_user.id
        attach_default_image unless @room.image.attached?
        if @room.save
            flash[:notice] = "施設を登録しました。"
            redirect_to rooms_path
        else
            flash[:alert] = "登録に失敗しました。"
            render :new
        end
    end
  
    def update
        @room = Room.find(params[:id])
        attach_default_image unless @room.image.attached?
        if @room.update(room_params)
            console
            flash[:notice] = "施設を編集しました。"
            redirect_to rooms_path
        else
            flash[:alert] = "登録に失敗しました。"
            render :edit
        end       
    end
  
    def destroy
        @room = Room.find(params[:id])
        @room.destroy
        flash[:alert] = "施設を削除しました。"
        redirect_to rooms_path
    end

    def search
        @rooms = Room.all
        if params[:area].present?
            @area = "%#{params[:area]}%"
            @rooms = @rooms.where("address LIKE ?", @area) 
        end
        if params[:keyword].present?
            @keyword = "%#{params[:keyword]}%"
            @rooms = @rooms.where("name LIKE ? OR content LIKE ? OR address LIKE ?", @keyword, @keyword, @keyword) 
        end
    end

    private

    def room_params
        params.require(:room).permit(:name, :content, :price, :address, :image)
    end

    def attach_default_image
        @room.image.attach(
          io: File.open('app/assets/images/room-default-image.png'),
          filename: 'room-default-image.png',
          content_type: 'image/png'
        )
    end  
end

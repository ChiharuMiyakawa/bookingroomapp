class ReservationsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    def index
        @reservations = Reservation.all
    end
  
    def show
    end
  
    def new
    end
  
    def edit
        @reservation = Reservation.find(params[:id])
        @room = @reservation.room
    end
  
    def create
        @reservation = Reservation.new(reservation_params)
        @reservation.user = current_user
        @room = Room.find(params[:reservation][:room_id])
        @days = (@reservation.reservation_end_date - @reservation.reservation_start_date).to_i
        @reservation.total_price = @reservation.person_num * @room.price * @days
        if @reservation.save
            flash[:notice] = "予約が完了しました。"
            redirect_to reservations_path
        else
            render 'rooms/show'
        end
    end
  
    def update
        @reservation = Reservation.find(params[:id])
        if @reservation.update(reservation_params)
            flash[:notice] = "予約を変更しました。"
            redirect_to reservations_path
        else
            render :edit
        end 
    end
  
    def destroy
        @reservation = Reservation.find(params[:id])
        if @reservation.destroy
        flash[:alert] = "予約を削除しました"
        redirect_to reservations_path  
        else
            render :index
        end      
    end

    def confirm
        Rails.logger.info "Params: #{params.inspect}"
        if params[:reservation][:id].present?
            @reservation = Reservation.find(params[:reservation][:id])
            @reservation.assign_attributes(reservation_params)
        else
            @reservation = Reservation.new(reservation_params)
        end
        @reservation.user = current_user
        @room = Room.find(params[:reservation][:room_id])
        if @reservation.valid?
            @days = (@reservation.reservation_end_date - @reservation.reservation_start_date).to_i
            @reservation.total_price = @reservation.person_num * @room.price * @days
            @reservation.assign_attributes(reservation_params)
            render 'reservations/confirm'
        else
            flash[:alert] = "登録に失敗しました。"
            if params[:reservation][:id].present?
                render 'reservations/edit'
            else
                render 'rooms/show'
            end           
        end
    end

    def reservation_params
        params.require(:reservation).permit(:reservation_start_date, :reservation_end_date, :person_num, :room_id, :total_price)
    end
end

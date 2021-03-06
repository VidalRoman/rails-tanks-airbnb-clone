class BookingsController < ApplicationController
  before_action :set_booking, only: [:edit, :update, :destroy]
  before_action :set_tank, only: [:new, :create]

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(params_bookings)
    @booking.tank = @tank
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def update
    authorize @booking
    @booking.update(booking_status: params[:booking_status])
    redirect_to dashboard_path
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to dashboard_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_tank
    @tank = Tank.find(params[:tank_id])
  end

  def params_bookings
    params.require(:booking).permit(:from_date, :to_date) # , :reviewstatus, :bookingstatus
  end
end

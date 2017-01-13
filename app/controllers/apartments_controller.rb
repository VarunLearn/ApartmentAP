class ApartmentsController < ApplicationController
  before_action :set_apartment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:page, :index, :show, :map_location, :map_locations] #add this line
  skip_authorize_resource :only => [:page, :map_location, :map_locations]
  load_and_authorize_resource # add this line

  def page
  end
  # GET /apartments
  # GET /apartments.json
  def index
    @apartments = Apartment.all
  end

  # GET /apartments/1
  # GET /apartments/1.json
  def show
  end

  def map_location
    @apartment = Apartment.find(params[:apartment_id])
    @hash = Gmaps4rails.build_markers(@apartment) do |apartment, marker|
      marker.lat(apartment.latitude)
      marker.lng(apartment.longitude)
      marker.infowindow("<em>" + apartment.address_1 + "</em>")
    end
    render json: @hash.to_json
  end

  def map_locations
    @apartments = Apartment.all
    @hash = Gmaps4rails.build_markers(@apartments) do |apartment, marker|
      marker.lat(apartment.latitude)
      marker.lng(apartment.longitude)
      #marker.infowindow("<em>" + apartment.address_1 + "</em>")
    end
    render json: @hash.to_json
  end

  # GET /apartments/new
  def new
    @apartment = current_user.apartments.build
  end
  #100 Park Blvd, San Diego, CA 92101

  # GET /apartments/1/edit
  def edit
    if @apartment.user == current_user
      render
    else
      redirect_to apartments_path, notice: "Wrong!"
    end
  end

  # POST /apartments
  # POST /apartments.json
  def create
    @apartment = current_user.apartments.build(apartment_params)

    respond_to do |format|
      if @apartment.save
        format.html { redirect_to @apartment, notice: 'Apartment was successfully created.' }
        format.json { render :show, status: :created, location: @apartment }
      else
        format.html { render :new }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartments/1
  # PATCH/PUT /apartments/1.json
  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
        format.html { redirect_to @apartment, notice: 'Apartment was successfully updated.' }
        format.json { render :show, status: :ok, location: @apartment }
      else
        format.html { render :edit }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apartments/1
  # DELETE /apartments/1.json
  def destroy
    if @apartment.user == current_user
      @apartment.destroy
      respond_to do |format|
        format.html { redirect_to apartments_url, notice: 'Apartment was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to apartments_path, notice: "Wrong!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartment
      @apartment = Apartment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_params
      params.require(:apartment).permit(:address_1, :address_2, :city, :zip, :state, :country, :name, :phone, :contact_hrs_from, :contact_hrs_to)
    end
end

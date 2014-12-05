require 'json'

class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]


  # GET /routes
  # GET /routes.json
  def index
    @routes = Route.all
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @hash = Gmaps4rails.build_markers(@route.pubs) do |pub, marker|
      marker.lat pub.latitude
      marker.lng pub.longitude
      marker.title pub.name
    end
  end

  # GET /routes/new
  def new
    # Construct a new route
    @route = Route.new
    # Construct and array to save our pubs, this will be added to the route model later
    @pubList = Array.new

    @rule = Rule.new

    # Provide the initial search object
    @search = Pub.search(params[:q])

    # Construct our initial map
    @hash = Gmaps4rails.build_markers(@pubList) do |pub, marker|
      marker.lat pub.latitude
      marker.lng pub.longitude
      marker.title pub.name
    end

  end

  # GET /routes/1/edit
  def edit

    # we then search for our pubs given our search param
    @search = Pub.search(params[:q])
    @pubs = @search.result

    # and add it to our current route
    if(@pubs.size == 1)
      # but only if only 1 pubs is found
      @route.pubs << @pubs[0]
      @route.save
    end

  end

  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(route_params)
    @pubList = JSON.parse params[:route][:pubList_id_eq]

    @pubList.each do |pub_id|
      @route.pubs << Pub.find(pub_id)
    end

    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render :show, status: :created, location: @route }
      else
        format.html { render :new }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
        format.json { render :show, status: :ok, location: @route }
      else
        format.html { render :edit }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to routes_url, notice: 'Route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_pub_to_list
    # Search for a pub given our param
    @search = Pub.search(params[:q])
    @pubs = @search.result

    respond_to do |format|
      # If our search returns a single pub
      if(@pubs.size == 1)
        # First fetch our pub list
        @pubList = JSON.parse params[:q][:pubList_id_eq]

        # If it's already in the list, then tell the user
        if(@pubList.include?(@pubs[0].id))
          @hash = "That pub's already in your list!"
          # And respond
          format.js
          return
        end

        # Then add the pub to this list
        @pubList << @pubs[0].id

        # Build a merker for the given pub
        @hash = Gmaps4rails.build_markers(@pubs) do |pub, marker|
          marker.lat pub.latitude
          marker.lng pub.longitude
          marker.title pub.name
        end
        @hash = @hash[0]
        # And respond
        format.js

      # If no pubs are found
      elsif(@pubs.size == 0)
        @pubList = JSON.parse params[:q][:pubList_id_eq]
        @hash = "Pub not found, maybe you would like to add this pub to our database?"
        # And respond
        format.js
      else
        @pubList = JSON.parse params[:q][:pubList_id_eq]
        @hash = "We found more then one pub with that name!"
        # And respond
        format.js
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def route_params
      params.require(:route).permit(:name, :q)
    end
end

module API
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    # before_action :authenticate, except: [:index, :new, :create, :show, :edit, :update, :destroy]


    
  # GET /events
  # GET /events.json
  def index
    @events = Event.includes(:pol).all.order(created_at: :desc)
    respond_to do |format|
      format.html { redirect_to api_events_path }
      format.json { render :index, status: 200 }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html { redirect_to api_event_path }
      format.json { render json: @event }
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.json { render :show, status: :created, location: @event }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.json { render :show, status: :ok, location: @event }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:headline, :source, :pol_id)
    end

    # protected
    # def authenticate
    #   authenticate_token || render_unauthorized
    # end
    
    # def authenticate_token
    #   authenticate_or_request_with_http_token('posts') do |token, options|
    #     User.find_by(auth_token: token)
    #   end
    # end
    
    # def render_unauthorized
    #   self.headers['WWW-Authenticate'] = 'Token realm="posts"'
    #   respond_to do |format|
    #     format.json { render json: 'Bad credentials', status: 401 }
    #   end
    # end

  end
end
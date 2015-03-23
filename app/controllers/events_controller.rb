
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    # before_action :authenticate, except: [:index, :new, :create, :show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]


  # GET /events
  # GET /events.json
  def index
    @events = Event.includes(:pol).all.paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
    @top_event = Event.where(top: true).order('id asc').limit(1).first
    respond_to do |format|
      format.html
    end
  end

  # GET /events/new
  def new
    if current_user.admin?
      @event = Event.new
      @pacs = Pac.all
    end
  end

  # POST /events
  # POST /events.json
  def create
    if current_user.admin?
      @event = Event.new params.require(:event).permit(:headline, :source, :pol_id, :summary, :top)

      params["event"]["pac_ids"]["for_id"] = params["event"]["pac_ids"]["for_id"].reject(&:empty?).map(&:to_i)
      params["event"]["pac_ids"]["against_id"] = params["event"]["pac_ids"]["against_id"].reject(&:empty?).map(&:to_i)

      params["event"]["pac_ids"]["for_id"].each do |pac_id|
        EventPac.create(pac_id: pac_id, event_id: @event.id, support: true)
      end
      params["event"]["pac_ids"]["against_id"].each do |pac_id|
        EventPac.create(pac_id: pac_id, event_id: @event.id, support: false)
      end

      respond_to do |format|
        if @event.save
          screenshot_init = Screencap::Fetcher.new(@event.source)
          screenshot = screenshot_init.fetch(output: "app/assets/images/screenshots/" + @event.id.to_s + ".png")

          format.html { redirect_to :back, notice: 'Event was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @comments = @event.comments

    @screenshot = File.exists?("app/assets/images/screenshots/" + @event.id.to_s + ".png")

    respond_to do |format|
      format.html
    end
  end


  # GET /events/1/edit
  def edit
    if current_user.admin?
      @event = Event.find(params[:id])
      @pacs = Pac.all
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if current_user.admin?
      pacs = EventPac.where(event_id: @event.id)
      pacs.destroy_all

      params["event"]["pac_ids"]["for_id"] = params["event"]["pac_ids"]["for_id"].reject(&:empty?).map(&:to_i)
      params["event"]["pac_ids"]["against_id"] = params["event"]["pac_ids"]["against_id"].reject(&:empty?).map(&:to_i)

      params["event"]["pac_ids"]["for_id"].each do |pac_id|
        EventPac.create(pac_id: pac_id, event_id: @event.id, support: true)
      end
      params["event"]["pac_ids"]["against_id"].each do |pac_id|
        EventPac.create(pac_id: pac_id, event_id: @event.id, support: false)
      end
      respond_to do |format|
        if @event.update params.require(:event).permit(:headline, :source, :pol_id, :summary, :top)
          format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    if current_user.admin?
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:headline, :source, :pol_id, :summary, :top, pac_ids: {for_id: [], against_id: []})
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

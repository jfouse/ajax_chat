class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    # by default, we want to keep track of the last messages we sent and only 
    # send updates, rather than sending the full set every time.  but the first
    # call for an admin needs to get previous history as part of the first response
    if session[:last_message_sent] == nil
      # ...then this is the first call.  who's asking?
      if session[:admin] == true
        @messages = Message.all
        session[:last_message_sent] = @messages.count > 0 ? @messages.last.id.to_s : 0
      else
        session[:last_message_sent] = Message.count > 0 ? Message.last.id.to_s : 0
        @messages = []
      end
    else
      # ...then we've already sent stuff, so only send anything new
      @messages = Message.where("id > ?", session[:last_message_sent])
      if @messages.count > 0
        session[:last_message_sent] = @messages.last.id.to_s
        # otherwise let it stay what it was
        #
        # FIXME sometimes (often?) the session value gets updated here, but then
        # the next request comes in and it turns out it wasn't updated after all,
        # leading to the last message being sent again.  Only seems to send the 
        # same message twice, then the update "sticks" or something.  Maybe I found
        # a bug in Rails?  I'll be rich and famous!!
      end
    end
    # @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.ip = request.ip
    @message.user = @current_user

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:text)
    end

end

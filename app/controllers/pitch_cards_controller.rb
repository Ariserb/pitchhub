class PitchCardsController < ApplicationController
  include ActionView::Helpers::TextHelper
  layout 'backend/base'

  before_action :authenticate_user!
  before_action :set_pitch_card, only: [:show, :edit, :update, :destroy]

  # GET /pitch_cards
  # GET /pitch_cards.json
  def index
    # TODO will most likely implement "more" button functionality rather than pagination
    @pitch_cards = PitchCard.all
  end

  # GET /pitch_cards/1
  # GET /pitch_cards/1.json
  def show
  end

  # GET /pitch_cards/new
  def new
    @pitch_card   = PitchCard.new

    # [ [ pitch point name, pitch point tool tip, pitch point place holder], ... ]
    @pitch_points = ApplicationController.helpers.pitch_points_hash
    # build the pitch card's points
    @pitch_points.length.times{@pitch_card.pitch_points.build}

  end

  # GET /pitch_cards/1/edit
  def edit
  end

  # POST /pitch_cards
  # POST /pitch_cards.json
  def create
    @pitch_card = PitchCard.new(pitch_card_params)

    # Inject the scope objects
    @scopes = ApplicationController.helpers.scopes(current_user)
    @pitch_card.inject_scopes(@scopes)
    # Set the current user as the PitchCard's initiator
    @pitch_card.initiator = current_user

    respond_to do |format|
      if @pitch_card.save
        format.html { redirect_to @pitch_card, notice: 'Pitch Card was successfully created.' }
        format.json { render :show, status: :created, location: @pitch_card }
      else
        # PaperClip spits out redundant errors, so we compensate by subtracting by the redundant count
        num_errors = @pitch_card.errors.count - @pitch_card.errors[:pitch_card_image].count
        flash.now[:alert] = pluralize(num_errors, "error") + ' found, please fix before submitting'
        format.html { render :new }
        format.json { render json: @pitch_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pitch_cards/1
  # PATCH/PUT /pitch_cards/1.json
  def update
    # Inject the scope objects
    @scopes = ApplicationController.helpers.scopes(current_user)
    @pitch_card.inject_scopes(@scopes)

    respond_to do |format|
      if @pitch_card.update(pitch_card_params)
        format.html { redirect_to @pitch_card, notice: 'Pitch card was successfully updated.' }
        format.json { render :show, status: :ok, location: @pitch_card }
      else
        # PaperClip spits out redundant errors, so we compensate by subtracting by the redundant count
        num_errors = @pitch_card.errors.count - @pitch_card.errors[:pitch_card_image].count
        flash.now[:alert] = pluralize(num_errors, "error") + ' found, please fix before submitting'
        format.html { render :edit }
        format.json { render json: @pitch_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pitch_cards/1
  # DELETE /pitch_cards/1.json
  def destroy
    @pitch_card.destroy
    respond_to do |format|
      format.html { redirect_to pitch_cards_url, notice: 'Pitch card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /initiated
  # GET /initiated.json
  def initiated
    @pitch_cards = current_user.init_pitch_cards.page params[:page]
    render 'index'
  end

  # GET /collabs
  # GET /collabs.json
  def collabs
    @pitch_cards = current_user.collab_pitch_cards.page params[:page]
    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pitch_card
      @pitch_card = PitchCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pitch_card_params
      # Screen the baddies
      params.require(:pitch_card).permit(:status, :i_scope, :c_scope, :pitch_card_image, pitch_points_attributes: [:id, :name, :selected, :value])
    end

end

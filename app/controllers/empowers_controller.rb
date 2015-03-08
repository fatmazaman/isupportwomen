class EmpowersController < ApplicationController
  before_action :find_empower, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :home]

  before_action :authorized_user, only: [:edit, :update, :destroy]

  # caches_action :home

  def index
    @empower = Empower.all.order("created_at DESC")
  end

  def show
  end

  def new
    @empower = current_user.empowers.build
  end

  def create
    @empower = current_user.empowers.build(empower_params)

    if @empower.save
      redirect_to @empower, notice: "Successfully Done!!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @empower.update(empower_params)
      redirect_to @empower
    else
      render 'edit'
    end
  end

  def destroy
    @id = @empower.id
    @path = Path.find_by_empower_id(@id)
    @note = Note.find_by_empower_id(@id)

    if !(@note.nil?)
      @note.destroy
    end
    
    if !(@path.nil?)
      @path.destroy
    end

    @empower.destroy
    respond_to do |format|
      format.html { redirect_to empowers_path, notice: 'successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @empower = Empower.find(params[:id])
    @empower.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @empower = Empower.find(params[:id])
    @empower.downvote_by current_user
    redirect_to :back
  end

  private

  def authorized_user
    @empower = current_user.empowers.find_by(id: params[:id])
    redirect_to empowers_path, notice: "Not authorized to edit this link" if @empower.nil?
  end

  def empower_params
    params.require(:empower).permit(:category, :title, :description, :image, paths_attributes: [:id, :name, :_destroy],
    notes_attributes: [:id, :step, :_destroy])
  end

  def find_empower
    @empower = Empower.find(params[:id])
  end
end

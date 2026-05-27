# frozen_string_literal: true

class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :only_contributor, only: %i[edit update destroy]
  def index
    @prototypes = Prototype.includes(:user)
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path(prototype)
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :image, :concept, :catch_copy).merge(user_id: current_user.id)
  end

  def only_contributor
    @prototype = Prototype.find(params[:id])
    return if @prototype.user == current_user

    redirect_to root_path
  end
end

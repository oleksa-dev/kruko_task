# frozen_string_literal: true

class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: :show

  def index
    @lists = current_user.lists

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def new
    @list = current_user.lists.new

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def create
    @list = current_user.lists.new(create_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
      else
        format.html { render action: 'new', alert: @list.errors.full_messages}
      end
    end
  end

  def show
    set_list

    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  private

  def create_params
    params.require(:list).permit(:name)
  end

  def list_param
    params.require(:id)
  end

  def set_list
    @list ||= current_user.lists.find(list_param)
  end
end

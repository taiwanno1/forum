class PosController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :find_po, :only => [:show, :update, :destroy, :subscribe, :unsubscribe]

  def index

    if params[:po_id]
      @po = Po.find(params[:po_id])
    else
      @po = Po.new
    end

    # @comments = Comment.all

    prepare_variable_for_index_template

  end

  def create
    @po = Po.new (po_params)
    @po.user = current_user # @po.user_id = current_user.id
    @cats = Cat.all

    if @po.save
      flash[:notice] = "新增成功"
      respond_to do |format|
        # format.html {redirect_to pos_path(:page => params[:page])}
        format.js
      end
    else
      flash[:notice] = "新增失敗"
    end


  end

  def update
    if params[:remove_logo] == "1"
      @po.logo = nil
    end

    if @po.update(po_params)
      flash[:notice] = "編輯成功"
    else
      flash[:notice] = "編輯gg"
    end
    redirect_to pos_path(:page => params[:page])
  end

  def destroy
    flash[:alert] = "Po killed"
    @po.destroy

    respond_to do |format|
      format.html { redirect_to pos_path(:page => params[:page]) }
      format.js
    end
  end

  def subscribe
    subscription = @po.find_subscription_by(current_user)
    if subscription
      # do nothing
    else
      @subscription = @po.subscriptions.create!(:user => current_user)
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js {render "subscription"}
    end
  end

  def unsubscribe
    @subscription = @po.find_subscription_by(current_user)
    @subscription.destroy
    @subscription = nil

    respond_to do |format|
      format.html { redirect_to :back }
      format.js {render "subscription"}
    end
  end

# ----------------------------------------------------

  private

  def find_po
    @po = Po.find(params[:id])
  end

  def po_params
    params.require(:po).permit(:title, :logo, :article, :cat_id,
                               :start_on, :cat_ids => [])
  end

  def prepare_variable_for_index_template

    @pos = Po.all
    @cats = Cat.all

    if params[:cat_id]
      @pos = Cat.find(params[:cat_id]).pos
    end

    if params[:order] == 'comments_count'
      @pos = @pos.order('comments_count DESC')
    elsif params[:order] == 'updated_at'
      @pos = @pos.order('updated_at DESC')
    else
      @pos = @pos.order('id DESC')
    end

    @pos = @pos.page(params[:page]).per(5)
  end

end

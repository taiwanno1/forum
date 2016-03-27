class PosController < ApplicationController
  before_action :authenticate_user!, :except => [:index]
  before_action :find_po, :only => [:show, :update, :destroy]

  def index

    if params[:po_id]
      @po = Po.find(params[:po_id])
    else
      @po = Po.new
    end

    @comments = Comment.all

    prepare_variable_for_index_template

  end

  def create
    @po = Po.new (po_params)
    @po.user = current_user
    @cats = Cat.all
    if @po.save
      flash[:notice] = "新增成功"
    else
      flash[:notice] = "新增失敗"
    end
    redirect_to pos_path(:page => params[:page])
  end

  def update
    if @po.update(po_params)
      flash[:notice] = "編輯成功"
    else
      flash[:notice] = "編輯gg"
    end
    redirect_to po_path( :po_id => @po )
  end

  def destroy
    flash[:alert] = "Po killed"
    @po.destroy
    redirect_to pos_path(:page => params[:page])
  end


private

  def find_po
    @po = Po.find(params[:id])
  end

  def po_params
    params.require(:po).permit(:title, :article, :cat_ids => [])
  end

  def prepare_variable_for_index_template

    @pos = Po.all
    @cats = Cat.all



    if params[:cat_id]
      @pos = Cat.find(params[:cat_id]).pos
    end

    if params[:order]
      @comments_sort = @comments.ids
      sort_by = (params[:order] == '@comments_sort') ? '@comments_sort' : 'id'
      @pos = @pos.order(sort_by)
    end

    @pos = @pos.page(params[:page]).per(5)
  end

end

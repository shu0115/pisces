class ListItemsController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @list = List.first( :conditions => { :user_id => session[:user_id], :id => params[:list_id] } )
    redirect_to :controller => "lists" and return if @list.blank?

    @list_item = ListItem.new
    @list_items = ListItem.get_list( :user_id => session[:user_id], :list_id => params[:list_id], :page => params[:page], :item_status => params[:item_status] )
  end

  #------#
  # edit #
  #------#
  def edit
    @list_item = ListItem.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )
    @list_items = ListItem.get_list( :user_id => session[:user_id], :list_id => params[:list_id], :page => params[:page], :item_status => params[:item_status] )

    render :partial => "list"
  end

  #--------#
  # create #
  #--------#
  def create
    @list_item = ListItem.new( params[:list_item] )
    @list_item.user_id = session[:user_id]

    unless @list_item.save
      flash[:notice] = "リストアイテムの新規作成に失敗しました。"
      redirect_to :controller => "list" and return
    else
      redirect_to :action => "index", :list_id => @list_item.list_id, :list_page => params[:list_page] and return
    end

  end

  #--------#
  # update #
  #--------#
  def update
    @list_item = ListItem.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )

    render :partial => 'list' and return if @list_item.blank?
    
    unless @list_item.update_attributes( params[:list_item] )
      flash[:notice] = "リストの更新に失敗しました。"
    end

    @list_items = ListItem.get_list( :user_id => session[:user_id], :list_id => params[:list_id], :page => params[:page], :item_status => params[:item_status] )
    render :partial => "list"
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @list_item = ListItem.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )

    redirect_to :action => "index", :id => params[:list_id] and return if @list_item.blank?

    unless @list_item.destroy
      flash[:notice] = "リストアイテムの削除に失敗しました。"
    end
    
    redirect_to :action => "index", :list_id => params[:list_id], :page => params[:page], :item_status => params[:item_status], :list_page => params[:list_page] and return
  end

  #------------#
  # set_status #
  #------------#
  def set_status
    @list_item = ListItem.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )

    render :partial => "list" and return if @list_item.blank?

    unless @list_item.update_attributes( :status => params[:set_status], :complete_date => params[:complete_date] )
      flash[:notice] = "ステータスの更新に失敗しました。"
    end

    @list_items = ListItem.get_list( :user_id => session[:user_id], :list_id => @list_item.list_id, :page => params[:page], :item_status => params[:item_status] )
    render :partial => "list"
  end

end

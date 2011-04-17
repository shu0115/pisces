class ListsController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @lists = List.paginate( :conditions => { :user_id => session[:user_id] }, :page => params[:page], :per_page => $per_page, :order => "created_at DESC" )
  end

  #------#
  # show #
  #------#
  def show
    @list = List.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )
  end

  #-----#
  # new #
  #-----#
  def new
    @list = List.new
  end

  #------#
  # edit #
  #------#
  def edit
    @list = List.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )
  end

  #--------#
  # create #
  #--------#
  def create
    @list = List.new( params[:list] )
    @list.user_id = session[:user_id]

    if @list.save
      redirect_to :action => "index" and return
    else
      flash[:notice] = "リストの新規作成に失敗しました。"
      redirect_to :action => "new" and return
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @list = List.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )

    redirect_to :action => "index" and return if @list.blank?
    
    if @list.update_attributes( params[:list] )
      redirect_to :action => "index", :page => params[:page] and return
    else
      flash[:notice] = "リストの更新に失敗しました。"
      redirect_to :action => "edit" and return
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @list = List.first( :conditions => { :id => params[:id], :user_id => session[:user_id] } )

    redirect_to :action => "index" and return if @list.blank?

    unless @list.destroy
      flash[:notice] = "リストの削除に失敗しました。"
    end
    
    redirect_to :action => "index", :page => params[:page] and return
  end
end

class ProtectController < ApplicationController

  skip_filter :authorize, :only => [ :item_list, :show_key ]

  #-------#
  # index #
  #-------#
  def index
    @lists = List.paginate( :conditions => { :user_id => session[:user_id], :mode => "protect" }, :page => params[:page], :per_page => $per_page, :order => "created_at DESC" )
  end

  #-----------#
  # item_list #
  #-----------#
  def item_list
    list = List.first( :conditions => { :id => params[:id], :mode => "protect" } )

    redirect_to :action => "index" and return if list.blank?
    
    # 閲覧キーチェック
    if !list.show_key.blank? and session["show_key_#{list.id}"] != "OK"
    #if true
      redirect_to :action => "show_key", :id => list.id and return        
    end
    
    @list_items = ListItem.get_list( :user_id => session[:user_id], :list_id => params[:id], :page => params[:page], :item_status => params[:item_status] )
  end
  
  #----------#
  # show_key #
  #----------#
  def show_key
    # リスト情報取得
    @list = List.find_by_id_and_mode( params[:id], "protect" )

    # 閲覧キー照合
    if @list.show_key == params[:show_key]
      session["show_key_#{@list.id}"] = "OK"
      redirect_to :action => "item_list", :id => @list.id and return
    else
      unless params[:show_key].blank?
       flash[:show_key_notice] = "閲覧キーが正しくありません。<br /><br />"
      end
    end
  end

end

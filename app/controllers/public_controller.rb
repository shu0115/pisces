class PublicController < ApplicationController
  
  skip_filter :authorize

  #-------#
  # index #
  #-------#
  def index
    @lists = List.paginate( :conditions => { :mode => "public" }, :page => params[:page], :per_page => $per_page, :order => "created_at DESC" )
  end

  #-----------#
  # item_list #
  #-----------#
  def item_list
    list = List.first( :conditions => { :id => params[:id], :mode => "public" } )

    redirect_to :action => "index" and return if list.blank?
    
    @list_items = ListItem.get_list( :list_id => params[:id], :page => params[:page], :item_status => params[:item_status] )
  end

end

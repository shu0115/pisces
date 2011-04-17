class ListItem < ActiveRecord::Base

  #---------------#
  # self.get_list #
  #---------------#
  def self.get_list( args )
    condition_text = ""
    order_text = "expected_date ASC, created_at ASC"
#    order_text = "created_at DESC"
    condition_hash = Hash.new
    
    # ユーザID
    unless args[:user_id].blank?
      condition_text += " AND user_id = :user_id "
      condition_hash[:user_id] = args[:user_id]
    end

    # リストID
    unless args[:list_id].blank?
      condition_text += " AND list_id = :list_id "
      condition_hash[:list_id] = args[:list_id]
    end

    # 最初の「AND」を消去
    condition_text = condition_text.sub( "AND", "" )
    
    # ステータス
    if args[:item_status] == "完了"
      condition_text += " AND status = :status"
      condition_hash[:status] = "完了"
    elsif args[:item_status] == "未完了"
      condition_text += " AND ( status = '' OR status IS NULL )"
    end

    return ListItem.paginate( :conditions => [ condition_text, condition_hash ], :page => args[:page], :per_page => $per_page, :order => order_text )
  end

end

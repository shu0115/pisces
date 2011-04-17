class List < ActiveRecord::Base
  
  private
  #----------------#
  # self.get_title #
  #----------------#
  # リストタイトル取得
  def self.get_title( list_id )
    list = self.find( :first, :select => "title", :conditions => { :id => list_id } )
    unless list.blank?
      return list.title
    else
      return ""
    end
  end

end

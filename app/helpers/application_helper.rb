include Carmen

module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def bootstrap_class_for flash_type
    { success: "success", error: "error", alert: "warning", notice: "info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end

  def set_resource_through_template
    @resource = current_user
    @resource.build_store unless !@resource.store.blank?    
  end

  def seller?
    current_user.has_role? :seller
  end

  def buyer?
    current_user.has_role? :buyer
  end

  def admin?
    current_user.has_role? :admin
  end

  def get_states
    ind = Country.named('India')
    ind.subregions.select{|t| t.type=="state"}.map(&:name)
  end

  def set_image(product)
    if (product.galleries.first.photo.url.include? "missing")
      asset_path("bg_cover")      
    else
      product.galleries.first.photo.url 
    end
  end

  def set_offers_option
    [["Offer on product","product_offer"],["Offer on price","price_offer"]]
  end

  def product_offer_class(product_offer, current_offer)
    product_offer==current_offer ? "" : "hidden"
  end

  def visiblily_for_image(choice_type, current_choice)
    choice_type==current_choice ? "display:none;" : ""
  end

  def user_name(name)
    name.blank? ? "Anonymous" : name
  end

  def main_li_tabs count
    count <=4 ? "new-menu li_active" : "extra-menu li_inactive" 
  end

  def unread_notifications id
    user = get_user id
    if user.has_role? "seller"
      user.notifications_present? ? user.seller_notifications.seller_unread.count : 0
    else
      user.notifications_present? ? user.buyer_notifications.buyer_unread.group_by(&:order_id).count : 0
    end

  end

  def get_user id
    User.find(id)
  end
end
module MenuItemHelper

  def self.sort_into_types(menu_items)
    sorted_types = {
      :starter => [],
      :main => [],
      :dessert => []
    }

    menu_items.each do |menu_item|
      sorted_types[menu_item.meal_type.to_sym] << menu_item
    end

    sorted_types
  end

  def self.menu_item_request_invalid?(request_menu_items)
    error_message = false

    begin
      raise "Menu items not supplied correctly" if request_menu_items.nil? || !request_menu_items.kind_of?(Array) || request_menu_items.count != 3

      menu_items = request_menu_items.map do |menu_item|
        raise "Menu items not supplied correctly" if menu_item[:id].nil?
        menu_item[:id]
      end

      raise "Menu items not supplied correctly" if (menu_items = MenuItem.where(:id => menu_items)).count != request_menu_items.count

      sorted_menu_items = self.sort_into_types(menu_items)

      sorted_menu_items.keys.each do |type|
        raise "You cannot have more than one menu item per type" if sorted_menu_items[type].count > 1
      end
    rescue => error
      error_message = error.message
    end

    error_message
  end
end

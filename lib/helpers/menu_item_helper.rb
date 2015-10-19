module MenuItemHelper

  def self.sort_into_types(menu_items)
    sorted_types = {
      :starter => [],
      :main => [],
      :desert => []
    }

    menu_items.each do |menu_item|
      sorted_types[menu_item.meal_type.to_sym] << menu_item
    end

    return sorted_types
  end

end

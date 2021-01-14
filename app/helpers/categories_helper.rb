module CategoriesHelper
  def arr_categories
    Category.all.map do |category|
      [category.name, category.id]
    end
  end
  
  def all_categories
    Category.all
  end

  def url_form category
    return admin_categories_path if category.new_record?
    admin_category_path category
  end
end

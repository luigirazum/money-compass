module CategoriesHelper
  def render_all_categories
    if @categories.size.positive?
      render partial: 'category', layout: 'li_link_item', collection: @categories
    else
      render 'application/empty_collection', subject: 'user', target: 'categories'
    end
  end
end

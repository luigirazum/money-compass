module PaymentsHelper
  def render_payments_by_category
    if @payments.size.positive?
      render partial: 'payment', layout: 'list_item', collection: @payments
    else
      render 'application/empty_collection', subject: 'category', target: 'payments'
    end
  end
end

class PaymentsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @payments = @category.payments
    session[:initial_category] = @category
    delete_new_payment_session
    delete_new_category_session
  end

  def new
    @category = new_category
    @payment = new_payment
  end

  def create
    @category = Category.find(category_params[:category])
    @payment = @category.payments.new(payment_params)

    if @payment.save
      delete_new_payment_session
      delete_new_category_session
      delete_initial_category_session
      redirect_to category_payments_path(@category), notice: 'The <strong>payment</strong> was succesfully added!'
    else
      flash[:alert] = @payment.errors.full_messages.first
      session[:new_payment] = @payment
      session[:new_category] = @payment.category
      redirect_to new_category_payment_path(session[:initial_category])
    end
  end

  private

  def category_params
    params.require(:payment).permit(:category)
  end

  def payment_params
    params.require(:payment).permit(:name, :amount)
  end

  def new_category
    return Category.find(params[:category_id]) if session[:new_category].nil?

    session_params = session[:new_category].filter do |key|
      %w[id].include? key
    end

    Category.find(session_params['id'])
  end

  def new_payment
    return @category.payments.new if session[:new_payment].nil?

    session_params = session[:new_payment].filter do |key|
      %w[name amount].include? key
    end

    @category.payments.new(session_params)
  end

  def delete_new_category_session
    session.delete(:new_category) if session[:new_category]
  end

  def delete_new_payment_session
    session.delete(:new_payment) if session[:new_payment]
  end

  def delete_initial_category_session
    session.delete(:initial_category) if session[:initial_category]
  end
end

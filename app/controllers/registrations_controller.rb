class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    super
    if resource.save
      customer = Stripe::Customer.create(
        :description => resource.id,
        :email => resource.email
      )
      resource.customertoken = customer.id
      resource.save
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end

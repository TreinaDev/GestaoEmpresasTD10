class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :internet_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :bad_request

  private

  def internal_server_error
    render status: :internal_server_error, json: { errors: I18n.t('errors.internal_server_error') }
  end

  def not_found
    render status: :not_found, json: { errors: I18n.t('errors.not_found') }
  end

  def bad_request
    render status: :bad_request, json: { errors: I18n.t('errors.bad_request') }
  end
end

class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return500
  rescue_from ActiveRecord::RecordNotFound, with: :return404

  private

  def return500
    render status: :internal_server_error, json: { errors: I18n.t('errors.internal_server_error') }
  end

  def return404
    render status: :not_found, json: { errors: I18n.t('errors.not_found') }
  end
end

class Api::V1::MunchiesController < ApplicationController
  def index
    raise Exceptions::InvalidParams unless valid?(params)
    render json: MunchieSerializer.new(MunchieFacade.get_munchie(params))
  end

  private

  def valid?(params)
    params[:start].present? && params[:destination].present?
  end
end

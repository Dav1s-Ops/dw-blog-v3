class ErrorsController < ApplicationController
  def not_found
    respond_to do |format|
      format.html { render :not_found, status: :not_found }
      format.json { render json: { error: "Page not found" }, status: :not_found }
    end
  end

  def internal_server_error
    respond_to do |format|
      format.html { render :internal_server_error, status: :internal_server_error }
      format.json { render json: { error: "Internal server error" }, status: :internal_server_error }
    end
  end
end

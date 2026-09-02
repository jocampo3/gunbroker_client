module Api
  module V1
    class GunbrokerController < ApplicationController
      before_action :authenticate_api_key!
      before_action :set_service

      def token
        token = @service.generate_token
        render json: { accessToken: token }
      end

      def product
        result = @service.get_product(params.require(:upc))
        render json: result
      end

      def item
        result = @service.get_item(params[:id])
        if result
          render json: result
        else
          render json: { error: "Item not found" }, status: :not_found
        end
      end

      def inventory
        items = @service.get_inventory
        render json: items
      end

      def destroy_listing
        result = @service.end_listing(params[:id])
        render json: result
      end

      private

      def authenticate_api_key!
        api_key = request.headers["HTTP_X_API_KEY"]
        expected = ENV["GUNBROKER_API_KEY"]

        return if expected.present? && ActiveSupport::SecurityUtils.secure_compare(api_key.to_s, expected)

        render json: { error: "Unauthorized" }, status: :unauthorized
      end

      def set_service
        username = request.headers["X-Username"] || params[:username]
        password = request.headers["X-Password"] || params[:password]

        unless username.present? && password.present?
          render json: { error: "Username and password are required" }, status: :bad_request and return
        end

        @service = GunbrokerService.new(username, password)
      end
    end
  end
end

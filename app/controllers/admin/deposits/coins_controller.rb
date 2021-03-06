module Admin
  module Deposits
    class CoinsController < ::Admin::BaseController
      #load_and_authorize_resource :class => "::Deposits::#{params[:type].capitalize}".constantize

      before_action :find_deposits, only: [:index]
      before_action :find_deposit, only: [:show, :update]

      def find_deposits
        currency_id = Currency.where(key: params[:type]).first.id
        @coins = Deposit.where(currency: currency_id)
      end

      def find_deposit
        @coin = channel.kls.find(params[:id])
      end

      def channel
        @channel ||= DepositChannel.find_by_key(params[:type])
      end

      def index
        @coins = @coins.includes(:member).
            where('created_at > ?', 365.days.ago).
            order('id DESC').page(params[:page]).per(20)
      end

      def update
        @coin.accept! if @coin.may_accept?
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end

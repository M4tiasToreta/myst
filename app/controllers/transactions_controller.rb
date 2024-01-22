class TransactionsController < ApplicationController
  def reset
    render plain: 'OK', status: :ok
  end

  def event
    event_respose = handle_event

    if event_respose.present?
      render json: event_respose, status: :created
    else
      render plain: '0', status: :not_found
    end
  end

  private

  def handle_event
    handle = TransactionsHandlerService.new(*params_to_handle)

    handle.call
  end

  def params_to_handle
    {
      :type => params[:type],
      :origin => params[:origin],
      :destination => params[:destination],
      :amount => params[:amount]
    }
  end
end

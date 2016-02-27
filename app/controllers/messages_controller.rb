class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @message = Message.create(message_params)

    Pusher['private-chat-'+@message.stream_id.to_s].trigger('client-new_message', {
      username: @message.username,
      contents: @message.contents,
      user_id: @message.user_id
    })

    respond_to :js
  end


  def message_params
    params.require(:message).permit(:flag, :contents, :username, :stream_id, :user_id)
  end
end

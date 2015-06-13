module ActiveModel
  class Errors
    attr_reader :message_codes
    alias_method :orig_add, :add

    def add(attribute, message = nil, options = {})
      ap attr: attribute, msg: message, opt: options
      @message_codes ||= {}
      (@message_codes[attribute] ||= []) << message
      orig_add(attribute, message, options)
     end
  end
end

class StaticPagesController < ApplicationController
  def home
    ap 'here'
    Foobar.new.stuff
    user = User.new
    ap user.valid?
    ap user.errors
    ap user.errors.message_codes
    ap user
  end

  def help
  end

  def about
  end

  def contact
  end
end

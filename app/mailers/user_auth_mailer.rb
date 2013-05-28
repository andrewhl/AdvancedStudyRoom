class UserAuthMailer < Devise::Mailer

  def confirmation_instructions(record, opts={})
    opts = intercept_email(opts) unless Rails.env.production?
    super(record, opts)
  end

  def reset_password_instructions(record, opts={})
    opts = intercept_email(opts) unless Rails.env.production?
    super(record, opts)
  end

  def unlock_instructions(record, opts={})
    opts = intercept_email(opts) unless Rails.env.production?
    super(record, opts)
  end

  private

    def intercept_email(opts)
      opts.merge(to: ENV['ASR_ALERTS_RECIPIENT'])
    end

end
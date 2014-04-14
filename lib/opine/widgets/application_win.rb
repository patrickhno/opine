class Opine::Native::Application < Opine::Application
  def initialize(options,&block)
    super

    instance_eval(&block) if block

    msg = Stench::WinBase::MSG.new
    while Stench::WinBase::GetMessage(msg, Stench::WinBase::NULL, 0, 0) > 0
      Stench::WinBase::TranslateMessage(msg)
      Stench::WinBase::DispatchMessage(msg)
    end
  end
end

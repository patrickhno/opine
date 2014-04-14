class Opine::Native::Alert < Opine::Alert
  def initialize(options,&block)
    super
    Stench::WinBase::MessageBoxW(
      Stench::WinBase::NULL,
      text.encode("UTF-16LE"),
      "".encode("UTF-16LE"),
      Stench::WinBase::MB_OK
    )
  end
end


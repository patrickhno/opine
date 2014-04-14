class Opine::Native::Window < Opine::Window

  class Window
    attr_accessor :widget

    include Stench::WinBase

    CLASS_NAME = "OpineWindow"
    WINDOWS = []

    def P(a); ::FFI::Pointer.new(a); end

    def initialize(widget) #(title)
      @widget = widget

      @white = GetStockObject(WHITE_BRUSH)

      @wc = WNDCLASSEX.new
      @wc[:lpfnWndProc]   = method(:window_proc)
      @wc[:hInstance]     = Stench::HINST
      @wc[:hIcon]         = LoadImage(NULL, P(IDI_APPLICATION), IMAGE_ICON, 0, 0, LR_SHARED)
      @wc[:hCursor]       = LoadImage(NULL, P(IDC_ARROW), IMAGE_CURSOR, 0, 0, LR_SHARED)
      @wc[:hbrBackground] = @white
      @wc[:lpszClassName] = FFI::MemoryPointer.from_string("#{CLASS_NAME}:#{__id__}")
      @wc[:hIconSm]       = LoadImage(NULL, P(IDI_APPLICATION), IMAGE_ICON, 0, 0, LR_SHARED);

      @hwnd = CreateWindowEx(
          WS_EX_LEFT, P(@wc.atom), title, WS_OVERLAPPEDWINDOW | WS_VISIBLE,
          CW_USEDEFAULT, CW_USEDEFAULT, width, height, NULL, NULL, Stench::HINST, nil)

      raise "CreateWindowEx Error" if @hwnd == 0
      WINDOWS << self
    end

    def window_proc(hwnd, umsg, wparam, lparam)
      case umsg
        when WM_DESTROY
          @hwnd = nil
          WINDOWS.delete(self)
          PostQuitMessage(0) if WINDOWS.empty?
          return 0
        else
          return DefWindowProc(hwnd, umsg, wparam, lparam)
      end
      0
    end

    def hwnd
      @hwnd ? (IsWindow(@hwnd).nonzero? ? @hwnd : (@hwnd = nil)) : nil
    end

    def close
      DestroyWindow(@hwnd) if hwnd
    end

    def method_missing method,*args
      widget.send(method,*args)
    end
  end

  def initialize(options,&block)
  	super

    @window = Window.new(self)
  end
end


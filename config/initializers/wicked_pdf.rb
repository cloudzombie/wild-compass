case RUBY_PLATFORM

# OS X machine
when 'darwin', /darwin/
  binary_path = Rails.root.join('bin', 'wkhtmltopdf-0.9.9-OS-X-i386').to_s

# 64-bit linux machine 
when '64-linux', /64-linux/
  binary_path = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s

# Windows
when 'mingw', 'x64_mingw', /mingw/
  binary_path = 'C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe'

else
  binary_path = '/usr/local/bin/wkhtmltopdf'

end

WickedPdf.config = { exe_path: binary_path }
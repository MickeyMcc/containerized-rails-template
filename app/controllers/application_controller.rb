class ApplicationController < ActionController::Base
  include Authenticated

  # Security headers
  before_action :set_security_headers

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def set_security_headers
    # Prevent clickjacking
    response.set_header('X-Frame-Options', 'DENY')
    
    # Prevent MIME-type sniffing
    response.set_header('X-Content-Type-Options', 'nosniff')
    
    # Enable XSS protection
    response.set_header('X-XSS-Protection', '1; mode=block')
    
    # Referrer policy for privacy
    response.set_header('Referrer-Policy', 'strict-origin-when-cross-origin')
    
    # Feature policy (Permissions Policy)
    response.set_header('Permissions-Policy', 'geolocation=(), microphone=(), camera=()')
  end
end

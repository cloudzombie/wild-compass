require 'open-uri'
require 'chunky_png'

module Labelizable
  include ActiveSupport::Concern

  DPI = 300

  def label
    # Create background
    label = ChunkyPNG::Image.new(3 * DPI, 1 * DPI, ChunkyPNG::Color::WHITE)
    
    # Load datamatrix
    dmtx = ChunkyPNG::Image.from_blob(self.datamatrix)

    # Resize datamatrix
    resized_dmtx = dmtx.resize(180, 180)

    # Compose
    label.compose!(resized_dmtx, 0.2 * DPI, 0.2 * DPI)

    # Serve
    label.to_datastream
  end

end
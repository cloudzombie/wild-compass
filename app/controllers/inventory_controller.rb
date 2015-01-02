class InventoryController < ApplicationController
  
  expose(:plants) {   Plant.all }
  expose(:jars)   {   Jar.all   }
  expose(:bags)   {   Bag.all   }
  expose(:lots)   {   Lot.all   }

  def home
    respond_to do |format|
      format.html
      format.pdf do
        render( pdf:         'report.pdf',
                disposition: 'inline',
                template:    'inventory/report.pdf.erb',
                layout:      'report.html'
        )
      end
    end
  end

  # Create downloadable pdf if inventory.
  def download
  	html = render_to_string 'inventory/home', layout: 'report.html'
  	pdf = WickedPdf.new.pdf_from_string(html)

  	send_data( pdf,
               filename:    'report.pdf',
               disposition: 'attachment'
  	)
  end
end

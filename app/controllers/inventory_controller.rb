class InventoryController < ApplicationController
  include Authorizable
  
  expose(:strains) { Strain.all }

  expose(:categories) { ['Trim', 'Buds'] }
  
  expose(:brands) { Brand.all }

  expose(:inventory) { Inventory.new }
  
  def home
    respond_to do |format|
      format.html
      format.json
      format.js
      format.pdf do
        render( pdf:          'report.pdf',
                margin: {
                  top: 25,
                  bottom: 25,
                  left: 25,
                  right: 25
                },
                page_size: 'Letter',
                font_size: 12,
                footer: {
                  right: 'Page [page]'
                },
                show_as_html:  params[:debug].present?,
                disposition:  'inline',
                template:     "inventory/report/#{controller_name}.pdf.erb",
                layout:       'report.html'
        )
      end
    end
  end

  # Create downloadable pdf if inventory.
  def download
  	html = render_to_string "inventory/report/#{controller_name}.pdf.erb", layout: 'report.html'
  	pdf = WickedPdf.new.pdf_from_string(html)
  	send_data( pdf, filename: 'report.pdf', disposition: 'attachment' )
  end
    
end

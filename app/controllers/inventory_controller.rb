class InventoryController < ApplicationController

  helper_method :total_weight
  
  expose(:plants) { Plant.all }
  expose(:jars) { Jar.all }
  expose(:bags) { Bag.all }
  expose(:lots) { Lot.all }
  expose(:containers) { Container.all }
  expose(:strains) { Strain.all }
  expose(:categories) { ['Trim', 'Buds'] }

  def home
    respond_to do |format|
      format.html
      format.pdf do
        render( pdf:          'report.pdf',
                show_as_html: params[:debug].present?,
                disposition:  'inline',
                template:     'inventory/pdf/report.pdf.erb',
                layout:       'report.html'
        )
      end
    end
  end

  # Create downloadable pdf if inventory.
  def download
  	html = render_to_string 'inventory/pdf/report.pdf', layout: 'report.html'
  	pdf = WickedPdf.new.pdf_from_string(html)
  	send_data( pdf, filename: 'report.pdf', disposition: 'attachment' )
  end



  private

    def total_weight
      Plant.total_weight + Bag.total_weight + Jar.total_weight + Lot.total_weight
    end
end

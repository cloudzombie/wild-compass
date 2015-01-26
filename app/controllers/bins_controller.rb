class BinsController < ApplicationController

  expose(:bin, params: :bin_params) { id_param.nil? ? Bin.new : Bin.find(id_param) }
  expose(:bins) { Bin.all }

  def create
    self.bin = Bin.new(bin_params)
    bin.save
    respond_with(bin)
  end

  def update
    bin.update(bin_params)
    respond_with(bin)
  end

  def destroy
    bin.destroy
    respond_with(bin)
  end

  def label
    respond_to do |format|
      format.pdf do
        render( pdf:          'label.pdf',
                show_as_html: params[:debug].present?,
                disposition:  'inline',
                template:     'bins/pdf/label.pdf.erb',
                layout:       'label.html'
        )
      end
    end
  end

  def label_stream
    send_data bin.label, type: 'image/png', disposition: 'attachment'
  end

  private

    def id_param
      params[:id]
    end

    def bin_params
      params.require(:bin).permit(:name, :location_id)
    end
end

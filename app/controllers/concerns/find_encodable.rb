module FindEncodable
  extend ActiveSupport::Concern

  def find(resource)
    if params[:id].nil?
      resource.new
    else 
      resource.find_by(datamatrix_hash: params[:id].downcase) || resource.find(params[:id])
    end
  end

end
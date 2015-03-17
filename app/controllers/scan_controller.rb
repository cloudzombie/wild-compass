class ScanController < ApplicationController

  respond_to :html, :xml, :json

  def scan
    respond_to do |format|
      format.html 
      format.json { render json: find_scannable }
      format.xml { render xml: find_scannable }
    end
  end

  private

    def find_scannable
      scannable = []
      [ Plant, Bag, Jar, Bin, Seed ].each do |model|
        scannable << model.find_by( datamatrix_hash: params[:scanned_hash] )
      end
      scannable.compact.first
    end
end

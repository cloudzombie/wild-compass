module Process::Scan
end

class Wild::Compass::Process::Scan

  class ScanError < StandardError
  end

  def initialize(scan)

  end

  private

    def find_scannable
      scannable = []
      [ Plant, Bag, Jar, Bin, Seed ].each do |model|
        scannable << model.find_by( datamatrix_hash: params[:scanned_hash] )
      end
      result = scannable.compact.first
      if result.nil?
        raise ActiveRecord::RecordNotFound
      else
        result
      end
    end
    
end
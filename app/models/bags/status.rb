class Bags::Status < ActiveRecord::Base

  def to_s
    status
  end

  private

    def status
      if is_destroyed?
        "Destroyed"
      elsif sent_to_lab?
        "Sent to lab"
      elsif quarantined?
        "Quarantined"
      elsif recalled?
        "Recalled"
      elsif tested?
        "Tested"
      elsif released?
        "Released"
      elsif cleared?
        "Cleared"
      else
        ""
      end
    end

end

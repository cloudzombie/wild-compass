module BagsHelper
  def test_for(bag)
    if bag.tested?
      "<small class=\"badge alert-info\">T</small>".html_safe
    else
      ''
    end
  rescue
    "<small class=\"badge alert-danger\">E-T</small>".html_safe
  end

  def archive_for(bag)
    if bag.archived?
      "<small class=\"badge alert-primary\">A</small>".html_safe
    else
      ''
    end
  rescue
    "<small class=\"badge alert-danger\">E-A</small>".html_safe
  end

end

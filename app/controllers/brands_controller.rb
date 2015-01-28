class BrandsController < ApplicationController

  before_action :authorized?
  
  expose(:brand, params: :brand_params) { id_param.nil? ? Brand.new : Brand.find(id_param) }
  expose(:brands) { Brand.all }

  def create
    self.brand = Brand.new(brand_params)
    
    respond_to do |format|
      if brand.save
        format.html { redirect_to brand, notice: 'Brand was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if brand.update(brand_params)
        format.html { redirect_to brand, notice: 'Brand was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url, notice: 'Brand was successfully destroyed.' }
    end
  end

  def available
    respond_to do |format|
      if brand.available?
        format.html { redirect_to brands_url, notice: "brand available" }
      else
        format.html { redirect_to brands_url, notice: "brand not available" }
      end
    end
  end

  private

    def authorized?
      authorize! action_name.to_sym, Brand
    end

    def brand_params
      params.require(:brand).permit(:name, :description)
    end

    def id_param
      params[:id]
    end
end

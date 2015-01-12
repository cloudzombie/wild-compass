class BrandsController < ApplicationController
  expose(:brand, params: :brand_params) { id_param.nil? ? Brand.new : Brand.find(id_param) }
  expose(:brands) { Brand.all }

  def create
    self.brand = Brand.new(brand_params)
    authorize! :create, brand
    
    respond_to do |format|
      if brand.save
        format.html { redirect_to brand, notice: 'Brand was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize! :update, brand

    respond_to do |format|
      if brand.update(brand_params)
        format.html { redirect_to brand, notice: 'Brand was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize! :destroy, brand

    brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url, notice: 'Brand was successfully destroyed.' }
    end
  end

  def available
    authorize! :available, brand

    respond_to do |format|
      if brand.available?
        format.html { redirect_to brands_url, notice: "brand available" }
      else
        format.html { redirect_to brands_url, notice: "brand not available" }
      end
    end
  end

  private

    def brand_params
      params.require(:brand).permit(:name, :description)
    end

    def id_param
      params[:id]
    end
end

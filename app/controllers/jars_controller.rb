class JarsController < ApplicationController
  
  expose(:jar, params: :jar_params) do
    unless params[:id].nil?
      Jar.find(params[:id])
    else
      Jar.new
    end
  end

  expose(:jars) { Jar.all }

  def create
    self.jar = Jar.new(jar_params)

    respond_to do |format|
      if jar.save
        format.html { redirect_to jar, notice: 'jar was successfully created.' }
        format.json { render :show, status: :created, location: jar }
      else
        format.html { render :new }
        format.json { render json: jar.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if jar.update(jar_params)
        format.html { redirect_to jar, notice: 'jar was successfully updated.' }
        format.json { render :show, status: :ok, location: jar }
      else
        format.html { render :edit }
        format.json { render json: jar.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    jar.destroy
    respond_to do |format|
      format.html { redirect_to jars_url, notice: 'jar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def jar_params
      params.require(:jar).permit(:name, :weight)
    end
end

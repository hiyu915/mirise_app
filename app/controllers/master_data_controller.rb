class MasterDataController < ApplicationController
  def new
    @type = params[:type] || "setting"
    @setting = Setting.new
    @product = Product.new

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    case params[:type]
    when "setting"
      @record = Setting.new(setting_params)
    when "product"
      @record = Product.new(product_params)
    end

    if @record.save
      # type に応じてリダイレクト先を切り替える
      redirect_to master_data_path(type: params[:type]), notice: "登録が完了しました", status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @type = params[:type] || "setting"
    @records =
      case @type
      when "setting"
        Setting.order(created_at: :desc)
      else
        Product.order(created_at: :desc)
      end
  end

  def edit
    @type = params[:type]
    @record = @type == "setting" ? Setting.find(params[:id]) : Product.find(params[:id])
  end

  def update
    @type = params[:type]
    @record = @type == "setting" ? Setting.find(params[:id]) : Product.find(params[:id])

    if @record.update(@type == "setting" ? setting_params : product_params)
      redirect_to master_data_path(type: @type), notice: "更新が完了しました。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @type = params[:type]
    @record = @type == "setting" ? Setting.find(params[:id]) : Product.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to master_data_path(type: @type), notice: "削除しました。" }
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:name, :price, :pos_numbers, :anshin_price)
  end

  def product_params
    params.require(:product).permit(:name, :price)
  end
end

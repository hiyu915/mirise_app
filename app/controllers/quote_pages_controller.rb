class QuotePagesController < ApplicationController
  before_action :load_selected_items, only: [ :top, :confirm ]

  def top
    @selected_products = session[:selected_products] || []
  end

  def add_setting
    @type = params[:type] || "general"
    @settings = Setting.all
  end

  def add_setting_item
    session[:selected_settings] ||= []
    type = params[:type].presence_in([ "safe", "general" ]) || "general"

    session[:selected_settings] << {
      id: params[:id].to_i,
      type: type
    }

    flash[:notice] = "設定「#{Setting.find(params[:id]).name}（#{type == 'safe' ? '安心' : '一般'}）」を追加しました"
    redirect_to quote_pages_add_setting_path(type: type)
  end

  def remove_setting_item
    return redirect_to root_path unless session[:selected_settings].present?

    id = params[:id].to_i
    type = params[:type] # ← 追加

    session[:selected_settings] = session[:selected_settings].map(&:stringify_keys).reject do |item|
      item["id"].to_i == id && item["type"] == type # ← 両方一致した場合のみ削除
    end

    flash[:notice] = "設定を削除しました"
    redirect_to root_path
  end

  def add_product
    @products = Product.all
  end

  def add_product_item
    product = Product.find(params[:id])
    type = params[:type] == "safe" ? "safe" : "general"

    session[:selected_products] ||= []
    session[:selected_products] << {
      id: product.id,
      name: product.name,
      price: (type == "safe" ? product.anshin_price : product.price),
      type: type
    }

    redirect_to quote_pages_add_product_path, notice: "製品を追加しました。"
  end

  def remove_product_item
    return redirect_to root_path unless session[:selected_products].present?

    id = params[:id].to_i
    index = session[:selected_products].index { |item| item["id"].to_i == id }
    if index
      session[:selected_products].delete_at(index)
      flash[:notice] = "製品を削除しました"
    else
      flash[:alert] = "削除対象が見つかりません"
    end

    redirect_to root_path
  end

  def confirm
  end

  private

  def load_selected_items
    @selected_settings = load_items(session[:selected_settings], Setting)
    @selected_products = load_items(session[:selected_products], Product)
  end

  def load_items(session_data, model)
    return [] unless session_data.present?

    session_data.map do |data|
      record = model.find_by(id: data["id"])
      next unless record

      record.attributes.merge("type" => data["type"])
    end.compact
  end
end

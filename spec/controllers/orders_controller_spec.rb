require "rails_helper"
include SessionsHelper
include CartsHelper

RSpec.describe OrdersController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  let!(:product) {FactoryBot.create :product}

  describe "GET #new" do
    let(:delivery_addresses) {FactoryBot.create :delivery_address}

    context "success when valid attributes" do
      before do
        log_in user
        session[:cart] = {Product.first.id.to_s => 1}
        get :new
      end

      it "assign @delivery_addresses" do
        expect(assigns(:delivery_addresses)).not_to be_nil
      end

      it "assign @products_load_in_cart" do
        expect(assigns(:products_load_in_cart)).not_to be_nil
      end

      it {should render_template("new")}
    end

    context "fail when user login not yet" do
      before do
        get :new
      end

      it "is store forwarding_url" do
        expect(session[:forwarding_url]).not_to be_nil
      end

      it "show flash error" do
        expect(flash[:error]).to eq I18n.t("not_log_in")
      end

      it {should redirect_to(login_path)}
    end

    context "when cart empty" do
      before do
        log_in user
        session[:cart] = nil
        get :new
      end

      it "show flash warning" do
        expect(flash[:warning]).to eq I18n.t("cart_empty")
      end

      it {should redirect_to(carts_path)}
    end
  end

  describe "POST #create" do
    let(:order_params) {FactoryBot.build(:order).as_json}

    context "success when valid attributes" do
      before do
        session[:cart] = {Product.first.id.to_s => 1}
        log_in user
        post :create, params: {
          order: order_params
        }
      end

      it "assign @orders" do
        expect(assigns(:order)).not_to be_nil
      end

      it "assign @carts " do
        expect(assigns(:carts).present?).to be false
      end

      it "minus product quantity when create order details success" do
        expect(Product.find_by(id: product.id).quantity).to eq(product.quantity - 1)
      end

      it "show flash success" do
        expect(flash[:success]).to eq(I18n.t("order_success"))
      end

      it {should redirect_to(root_path)}
    end

    context "error when invalid order params" do
      before do
        session[:cart] = {Product.first.id.to_s => 1}
        @products_load_in_cart = Product.load_by_ids session_cart.keys
        log_in user
        post :create, params: {
          order: {delivery_address_id: 100}
        }
      end

      it "show flash warning" do
        expect(flash[:warning]).to eq(I18n.t("not_found_address"))
      end

      it {should render_template("new")}
    end

    context "error when invalid product quantity" do
      before do
        session[:cart] = {Product.first.id.to_s => 1000}
        log_in user
        post :create, params: {
          order: order_params
        }
      end

      it "show flash warning" do
        expect(flash[:warning]).to eq(I18n.t("max_quantity"))
      end

      it {should redirect_to(carts_path)}
    end

    context "fail when user login not yet" do
      before do
        get :new
      end

      it "is store forwarding_url" do
        expect(session[:forwarding_url]).not_to be_nil
      end

      it "show flash error" do
        expect(flash[:error]).to eq I18n.t("not_log_in")
      end

      it {should redirect_to(login_path)}
    end

    context "when cart empty" do
      before do
        log_in user
        session[:cart] = nil
        get :new
      end

      it "show flash warning" do
        expect(flash[:warning]).to eq I18n.t("cart_empty")
      end

      it {should redirect_to(carts_path)}
    end
  end
end

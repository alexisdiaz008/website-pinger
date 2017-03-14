class TestUrlsController < ApplicationController
  before_action :set_test_url, only: [:show, :edit, :update, :destroy]

  def index
    @test_urls = TestUrl.all
  end

  def show
  end

  def new
    if params[:request]
      @url=params[:url_text]
      @request=params[:request]
    end
    @test_url = TestUrl.new
  end

  def edit
  end

  def create
    @test_url = TestUrl.new(test_url_params)
    if @test_url.save
      redirect_to @test_url
      flash[:notice]='Test url was successfully created.'
    else
      redirect_to new_test_url_path
      flash[:alert]='Test url was not successfully created.'
    end
  end

  def update
    respond_to do |format|
      if @test_url.update(test_url_params)
        redirect_to @test_url
        flash[:notice]='Test url was successfully updated.'
      else
        redirect_to new_test_url_path
        flash[:alert]='Test url was not successfully updated.'
      end
    end
  end

  def destroy
    @test_url.destroy
    flash[:notice] = "Test Url successfully destroyed!"
    redirect_to test_urls_path
  end

  private

    def set_test_url
      @test_url = TestUrl.find(params[:id])
    end

    def test_url_params
      params.require(:test_url).permit(:url, :request, :response_code, :response_body, :frequency)
    end
end

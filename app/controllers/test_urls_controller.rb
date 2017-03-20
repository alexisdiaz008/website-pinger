class TestUrlsController < ApplicationController
  before_action :set_test_url, only: [:show, :edit, :update, :destroy]
  before_action :set_form_if_url, only: [:new]
  def index
    @test_urls = TestUrl.all
  end

  def show
  end

  def new
    @test_url = TestUrl.new
  end

  def edit
  end

  def create
    @test_url = TestUrl.create(test_url_params)
    if @test_url.save
      @test_url.set_task
      flash[:notice]='Test url was successfully created.'
      redirect_to @test_url
    else
      flash[:alert]='Test url was not successfully created.'
      redirect_to new_test_url_path
    end
  end

  def update
    respond_to do |format|
      if @test_url.update(test_url_params)
        @test_url.set_task
        flash[:notice]='Test url was successfully updated.'
        redirect_to @test_url
      else
        flash[:alert]='Test url was not successfully updated.'
        redirect_to new_test_url_path
      end
    end
  end

  def destroy
    @test_url.destroy
    flash[:notice] = "Test Url successfully destroyed!"
    redirect_to test_urls_path
  end

  private
    def set_form_if_url
      if params[:url_text]
        @url=params[:url_text]
        @request=params[:request]
        @response=HTTParty.get(params[:url_text])
      end
    end

    def set_test_url
      @test_url = TestUrl.find(params[:id])
    end

    def test_url_params
      params.require(:test_url).permit(:url, :request, :response_code, :response_body, :frequency)
    end
end

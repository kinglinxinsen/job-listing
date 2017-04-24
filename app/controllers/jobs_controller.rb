class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
before_action :validate_search_key, only: [:search]
 before_action :authenticate_user!, except: [:index, :show]
  def show
    @job = Job.find(params[:id])
    if @job.is_hidden
      flash[:warning] = "This Job already archieved"
      redirect_to root_path
    end
  end
  def index
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.order('wage_lower_bound DESC')
    when 'by_upper_bound'
      Job.published.order('wage_upper_bound DESC')
    when 'by_developer'
      Job.where(:category => "财务类").recent.paginate(:page => params[:page], :per_page => 5)
    when 'by_healthcare'
      Job.where(:category => "healthcare").recent.paginate(:page => params[:page], :per_page => 5)
    when 'by_customer-service'
      Job.where(:category => "customer-service").recent.paginate(:page => params[:page], :per_page => 5)
    when 'by_sales-marketing'
      Job.where(:category => "sales-marketing").recent.paginate(:page => params[:page], :per_page => 5)
    when 'by_legal'
      Job.where(:category => "legal").recent.paginate(:page => params[:page], :per_page => 5)
    when 'by_non-profit'
      Job.where(:category => "non-profit").recent.paginate(:page => params[:page], :per_page => 5)
    when 'by_human-resource'
      Job.where(:category => "human-resource").recent.paginate(:page => params[:page], :per_page => 5)
    else
      Job.published.order('created_at DESC')
    end
  end
  def new
    @job = Job.new
  end
  def create
    @job = Job.new(job_params)
   if @job.save
     redirect_to jobs_path
   else
     render :new
   end
 end
 def edit
   @job = Job.find(params[:id])
 end
 def update
   @job = Job.find(params[:id])
   if @job.update(job_params)
     redirect_to jobs_path
   else
     render :edit
   end
 end
 def destroy
   @job = Job.find(params[:id])
    @job.destroy
  redirect_to jobs_path
end


def search
    if @query_string.present?
    search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 5 )
    end
  end


  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_cont => query_string }
  end


 private

 def job_params
   params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email,:is_hidden,:category,:company,:city)
 end

end

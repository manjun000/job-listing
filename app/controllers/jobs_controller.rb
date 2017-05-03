class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :validate_search_key, only: [:search]

  def show
    @job = Job.find(params[:id])
    if @job.is_hidden
      flash[:warning] = "This Job already archieved"
      redirect_to root_path
    end
  end

   def index
     #不分类
     @jobs = Job.published
     #分类
     if params[:category].present?
       @category_id = Category.find_by(name: params[:category]).id
       @jobs = @jobs.where(:category_id => @category_id)
     end
     #排序
     @jobs = case params[:order]
             when 'by_lower_bound'
               @jobs.order('wage_lower_bound DESC').paginate(:page => params[:page], :per_page => 8)
             when 'by_upper_bound'
               @jobs.order('wage_upper_bound DESC').paginate(:page => params[:page], :per_page => 8)
             else
               @jobs.recent.paginate(:page => params[:page], :per_page => 10)
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
       @job = Job.find(params)
       @job.destroy
       redirect_to jobs_path
    end

    def search
      if @query_string.present?
        search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
        @jobs = search_result.recent.paginate(:page => params[:page], :per_page => 5)
      end
    end

protected
  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "")
    if params[:q].present?
      @search_criteria = { title_or_company_or_city_cont: @query_string}
    end
  end

  def search_criteria(query_string)
    {:title_cont => query_string}
  end

private

def job_params
  params. require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden,  :company, :city, :category_id)
end
end

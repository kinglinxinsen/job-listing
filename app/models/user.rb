class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
def admin?
  is_admin
end
has_many :resumes
has_many :jobs

has_many :job_relationships
  has_many :applied_jobs, :through => :job_relationships, :source => :job

  def has_applied?(job)
    applied_jobs.include?(job)
  end

  def apply!(job)
    applied_jobs << job
  end
end

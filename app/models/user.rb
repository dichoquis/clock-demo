class User < ActiveRecord::Base
  has_many :time_sheets
  has_many :tasks

  enum role: {employee: 0, admin: 1}
  enum status: {active: 0, archived: 1}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A[a-zA-Z0-9]+\Z/i

  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, length: {maximum: 50}

  validates :username, presence: true, uniqueness: true, length: {maximum: 30}, format: {with: VALID_USERNAME_REGEX}, on: :create
  validates :password, presence: true, length: {maximum: 30}, on: :create
  validates :timezone, inclusion: {in: ActiveSupport::TimeZone.zones_map.keys}, on: :create
  validates :first_name, presence: true, length: {maximum: 30}, on: :create
  validates :last_name, presence: true, length: {maximum: 30}, on: :create
  validates :phone_number, length: {maximum: 20}, on: :create
  validates :title, length: {maximum: 30}, on: :create

  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end

  def role_label
    role == :admin ? 'users.form.role.admin' : 'users.form.role.employee'
  end

end

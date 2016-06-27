

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :registerable, :recoverable,
          :rememberable, :trackable, :validatable, :session_limitable

  devise :database_authenticatable,:authentication_keys => [:username]

  mount_uploader :avatar, AvatarUploader

  belongs_to :role
  belongs_to :empresa
  belongs_to :contacto
  has_many :equipo_gestores

  validates :username, presence: {message: 'es obligatorio'},
            uniqueness: {message: 'ya en uso.'}
  validates :email, presence: {message: 'Obligatorio'}
  validates :name, presence: {message: 'Obligatorio'}
  validates :role_id, presence: {message: 'Obligatorio'}
  #validate :admin

  def admin
    if Role.find_by(id: role_id) != Role.where(name: 'Super Usuario').first
      if empresa_id.nil?
        errors.add(:empresa_id, "Debe asignar una empresa al usuario")
      end
    end
  end

  def self.administradores_clientes
    User.joins(:role).where(roles: {role_type: Role.role_types[:administrador_cliente]})
  end



end

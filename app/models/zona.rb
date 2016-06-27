class Zona < ActiveRecord::Base
  belongs_to :evento

  validates :nombre, :cupos, presence: true
  validates :nombre, uniqueness: {message:'Otra zona ha sido registrado con este nombre.'}
end

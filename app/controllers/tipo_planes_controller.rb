class TipoPlanesController < ApplicationController
  before_action :set_tipo_plan, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tipo_planes = TipoPlan.all
    @tipo_plan = TipoPlan.new
    respond_with(@tipo_planes, @tipo_plan)
  end

  def show
    respond_with(@tipo_plan)
  end

  def new
    @tipo_plan = TipoPlan.new
    respond_with(@tipo_plan)
  end

  def edit
  end

  def create
    @tipo_plan = TipoPlan.new(tipo_plan_params)
    @tipo_plan.save
    respond_with(@tipo_plan)
  end

  def update
    @tipo_plan.update(tipo_plan_params)
    respond_with(@tipo_plan)
  end

  def destroy
    @tipo_plan.destroy
    respond_with(@tipo_plan)
  end


  private
    def set_tipo_plan
      @tipo_plan = TipoPlan.find(params[:id])
    end

    def tipo_plan_params
      params.require(:tipo_plan).permit(:nombre, :invitacion, :confirmacion, :inscripcion, :pago, :validar_pago, :baja, :precheck_in, :check_in, :contenido, :estadisticas)
    end

    def self.permission
      :TipoPlan
    end
end

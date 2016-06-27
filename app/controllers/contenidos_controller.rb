class ContenidosController < ApplicationController
  before_action :set_contenido, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @contenidos = Contenido.all
    respond_with(@contenidos)
  end

  def show
    respond_with(@contenido)
  end

  def new
    @contenido = Contenido.new
    @contenido.contenido_eventos.build
    respond_with(@contenido)
  end

  def edit
  end

  def create
    @contenido = Contenido.new(contenido_params)
    @contenido.save
    respond_with(@contenido)
  end

  def update
    @contenido.update(contenido_params)
    respond_with(@contenido)
  end

  def destroy
    @contenido.destroy
    respond_with(@contenido)
  end

  def index_contenido_eventos
  end

  def buscar_contenido_eventos
    @contenido_eventos = Contenido.buscar_contenido(params[:evento_id].to_i)
    render json: [contenido: @contenido_eventos]
  end


  private
    def set_contenido
      @contenido = Contenido.find(params[:id])
    end

    def contenido_params
      params[:contenido].permit(:titulo, :autor,  :palabras_claves, :nombre_archivo, :descripcion,  :tipo_archivo,
                                :empresa_id,
                                :tipo_contenido_id,
                                :contenido_eventos_attributes => [:id, :evento_id]
      )
    end

    def self.permission
      :Contenido
    end
end

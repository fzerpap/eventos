module DynamicSelect
  class DynamicPaisController < ApplicationController
    respond_to :json

    def estado
      estados = Estado.where(pais_id: params[:pais_id])
      render json: [estados: estados]
    end

    def codigo_pais
      codigo = Pais.find(params[:pais_id]).codigo
      render json: [codigo: codigo]
    end


  end
end
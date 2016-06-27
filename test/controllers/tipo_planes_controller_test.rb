require "test_helper"

class TipoPlanesControllerTest < ActionController::TestCase
  def tipo_plan
    @tipo_plan ||= tipo_planes :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_planes)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference("TipoPlan.count") do
      post :create, tipo_plan: { check_in,: tipo_plan.check_in,, confirmacion,: tipo_plan.confirmacion,, contenido,: tipo_plan.contenido,, estadisticas: tipo_plan.estadisticas, inscripcion,: tipo_plan.inscripcion,, invitacion,: tipo_plan.invitacion,, nombre: tipo_plan.nombre, num_invitaciones: tipo_plan.num_invitaciones, pago,: tipo_plan.pago,, validar_pago,: tipo_plan.validar_pago, }
    end

    assert_redirected_to tipo_plan_path(assigns(:tipo_plan))
  end

  def test_show
    get :show, id: tipo_plan
    assert_response :success
  end

  def test_edit
    get :edit, id: tipo_plan
    assert_response :success
  end

  def test_update
    put :update, id: tipo_plan, tipo_plan: { check_in,: tipo_plan.check_in,, confirmacion,: tipo_plan.confirmacion,, contenido,: tipo_plan.contenido,, estadisticas: tipo_plan.estadisticas, inscripcion,: tipo_plan.inscripcion,, invitacion,: tipo_plan.invitacion,, nombre: tipo_plan.nombre, num_invitaciones: tipo_plan.num_invitaciones, pago,: tipo_plan.pago,, validar_pago,: tipo_plan.validar_pago, }
    assert_redirected_to tipo_plan_path(assigns(:tipo_plan))
  end

  def test_destroy
    assert_difference("TipoPlan.count", -1) do
      delete :destroy, id: tipo_plan
    end

    assert_redirected_to tipo_planes_path
  end
end

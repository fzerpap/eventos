class InscripcionEventoMailerPreview < ActionMailer::Preview

  def send_msg_aceptacion_evento_preview()
    InscripcionEventoMailer.send_msg_aceptacion_evento(InscripcionEvento.first)

  end

end

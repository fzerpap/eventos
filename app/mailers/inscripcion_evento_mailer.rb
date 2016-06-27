class InscripcionEventoMailer < ActionMailer::Base

  default from: "basilea@unibasilea.com.ve"

  def send_msg_aceptacion_evento(inscripcion_evento)
    @inscripcion_evento = inscripcion_evento
    attachments['HorariosEscuelaInfluencia.pdf'] = File.read('app/mailers/HorariosEscuelaInfluencia.pdf')
    mail(to: @inscripcion_evento.contacto.nombres+" "+@inscripcion_evento.contacto.apellidos+" "+"<"+@inscripcion_evento.contacto.email+">",
         subject: 'Carta de Aceptación - '+@inscripcion_evento.evento.nombre)
  end

  def send_simple_message_with_mailgun
    RestClient.post "https://api:key-14e8403446916e2264c58e4de0c6afc0"\
    "@api.mailgun.net/v3/sandbox28337c45e35243afadc7bcfde97efa0f.mailgun.org/messages",
                    :from => "Mailgun Sandbox <postmaster@sandbox28337c45e35243afadc7bcfde97efa0f.mailgun.org>",
                    :to => "Francisco Zerpa <fzerpap@gmail.com>",
                    :subject => "Hello Francisco Zerpa",
                    :text => "Congratulations Francisco Zerpa, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
  end
end

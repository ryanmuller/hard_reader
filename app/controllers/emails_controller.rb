class EmailsController < ApplicationController
   skip_before_filter :verify_authenticity_token
   before_filter :fetch_user

   def post
     return head(:forbidden) unless @user

     if params["recipient"] == Note::TO_READ_EMAIL_ROUTE
       make_note
     else
       make_summary
     end
     render :text => "OK"
   end

   private

   def make_note
     if fetch_url
       @note = Note.create user: @user, url: @url
       NoteMailer.delay.to_read_email(@note)
     end
   end

   def make_summary
     if fetch_note
       @note.update_attributes summary: actual_body
     end
   end
   
   def actual_body
     params["stripped-text"]
   end

   def note_id_by_recipient
     Note.id_by_email_route(params["recipient"])
   end

   def fetch_note
     @note ||= @user.notes.find note_id_by_recipient
   end

   def fetch_user
     @user ||= User.find_by email: params["sender"]
   end

   def fetch_url
     @url ||= Note.extract_url(actual_body)
   end
end

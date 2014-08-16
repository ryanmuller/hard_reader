class EmailsController < ApplicationController
   skip_before_filter :verify_authenticity_token
   before_filter :fetch_user

   def post
     return head(:forbidden) unless @user

     if params["to"] == "read@mg.learnstream.org"
       make_note
     else
       make_summary
     end
   end

   private

   def make_note
     if fetch_url
       @note = Note.create user: @user, url: @url
       NoteMailer.delay.to_read_email(note)
     end
     render :text => "OK"
   end

   def make_summary
     if fetch_note
       @note.update_attributes summary: actual_body
     end
     render :text => "OK"
   end
   
   def actual_body
     params["stripped-text"]
   end

   def note_id_by_receiver
     Note.id_by_email_route(params["to"])
   end

   def fetch_note
     @note ||= @user.notes.find note_id_by_receiver
   end

   def fetch_user
     @user ||= User.find_by email: params["from"]
   end

   def fetch_url
     @url ||= Array(Note.STRICT_URL_PATTERN.match(actual_body))[0] \
       || Array(Note.LIBERAL_URL_PATTERN.match(actual_body))[0]
   end
end
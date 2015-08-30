class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    set_user_and_track(@note)
    flash[:errors] = @note.errors.full_messages unless @note.save
    redirect_to track_url(@note.track)
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy!
    redirect_to track_url(@note.track)
  end

  private
  def note_params
    params.require(:note).permit(:body, :track_id)
  end

  def set_user_and_track(note)
    note.user_id = current_user.id
    note.track_id = note.track.id
  end
end

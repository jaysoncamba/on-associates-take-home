# Task: Consider that multiple models make use of the polymorphic :notable and move all the related implementation into a concern.

# #I've assumed: todos and reminder are type of notes
class Task5 < ActiveRecord::Base
  include Noteable
end

class Note
  # attributes noteable_id, noteable_type, note_type
  belongs_to :noteable, polymorphic: true

  scope :for ->(types) { where(note_type: types) }
end

module Noteable
  extend ActiveSupport::Concern

  included do
    has_many :notes, as: :noteable, dependent: :destroy
  end

  def has_simple_notes?
    notes.for(%w[to_do reminder]).not.exists?
  end

  def has_to_do_notes?
    notes.for(['to_do']).exists?
  end

  def has_reminder_notes?
    notes.for(['reminder']).exists?
  end
end

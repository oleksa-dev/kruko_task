# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :user

  has_many :items, dependent: :destroy
  has_many :products, through: :items

  validates :name, presence: true, allow_blank: false
end

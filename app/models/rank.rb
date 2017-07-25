class Rank < ActiveRecord::Base
  validates :name, presence: true
  validate :score_to_greater, :not_over_lapping

  private

  def score_to_greater
    if score_from >= score_to
        errors.add(:bad_Score, 'score_to must be larger then score_from')
  end


  def not_over_lapping
    if(!Rank.where("(? >= score_from AND ? <= score_to) OR (? >= score_from AND ? <= score_to)", score_from, score_from, score_to, score_to).empty?)
        errors.add(:overlapping, 'the score is overlapping with some of the other scores')
  end
  end
  end
  end
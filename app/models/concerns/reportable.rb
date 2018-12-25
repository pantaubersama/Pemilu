module Reportable
  # You will need to create counter cache for your model
  # 
  # change_table :your_models do |t|
  #   t.integer :cached_scoped_report_votes_total, default: 0
  #   t.integer :cached_scoped_report_votes_score, default: 0
  #   t.integer :cached_scoped_report_votes_up, default: 0
  #   t.integer :cached_scoped_report_votes_down, default: 0
  #   t.integer :cached_weighted_report_score, default: 0
  #   t.integer :cached_weighted_report_total, default: 0
  #   t.float :cached_weighted_report_average, default: 0.0
  # end

  extend ActiveSupport::Concern

  included do

  end

  def reported_by u
    self.vote_by voter: u, vote_scope: "report", vote: "bad"
  end

  def report_count
    self.cached_scoped_report_votes_total
  end

  class_methods do
    
  end
end
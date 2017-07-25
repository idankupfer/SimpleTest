require 'rails_helper'

RSpec.describe "Add Ranks", type: :request do
  describe "adding rank with invalid score" do
    it "should not work" do
      get new_rank_path
      expect do
        post ranks_path, rank: {
          name:            "bbb",
          score_to:        "0",
          score_from:      "0",
        }
      end.to_not change{ Rank.count }
      expect(response).to render_template(:new)
    end
  end

  describe "adding rank with valid score" do
    it "should work and" do
      get new_rank_path
      expect do
        post_via_redirect ranks_path, rank: {
          name:            "ZZZZAAAZZZ",
          score_to:             "99",
          score_from:                 "0"
        }
      end.to change{ Rank.count }.from(0).to(1)
    end
  end

    describe "adding overlapping ranks" do
    it "should not work" do
      get new_rank_path
      expect do
        post ranks_path, rank: {
          name:            "aaa",
          score_to:        "0",
          score_from:      "-10",
        }
        post ranks_path, rank: {
          name:            "bbb",
          score_to:        "10",
          score_from:      "-1",
        }
      end.to change{ Rank.count }.from(0).to(1)
    end
  end

  describe "adding not overlapping ranks" do
    it "should work" do
      get new_rank_path
      expect do
        post_via_redirect ranks_path, rank: {
          name:            "aaa",
          score_to:             "10",
          score_from:                 "0"
        }
        post_via_redirect ranks_path, rank: {
          name:            "bbb",
          score_to:             "20",
          score_from:                 "11"
        }
      end.to change{ Rank.count }.from(0).to(2)
    end
  end
end
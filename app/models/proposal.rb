class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :worker
end

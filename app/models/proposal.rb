class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :worker
  enum status: { pending: 0, accepted: 10, rejected: 20 }
end

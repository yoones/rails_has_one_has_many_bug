class User < ApplicationRecord
  has_many :documents
  has_one :proof_of_id, class_name: 'Document::ProofOfId'
  has_one :proof_of_residence, class_name: 'Document::ProofOfResidence'

  accepts_nested_attributes_for :proof_of_id, reject_if: :all_blank
  accepts_nested_attributes_for :proof_of_residence, reject_if: :all_blank
  accepts_nested_attributes_for :documents, reject_if: :all_blank

  def proof_of_id(*args)
    super(*args) || build_proof_of_id
  end

  def proof_of_residence(*args)
    super(*args) || build_proof_of_residence
  end
end

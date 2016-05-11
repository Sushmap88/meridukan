class SellerDocument < ActiveRecord::Base
	
  belongs_to :user

  accepts_nested_attributes_for :user

  # PanCard uploader
  has_attached_file :pan_card, :styles => { :small => "150x150>" }
  validates_attachment_size :pan_card, :less_than => 5.megabytes
  validates_attachment_content_type :pan_card, :content_type => ['image/jpeg', 'image/png']

  # VATCard uploader
  has_attached_file :vat_card, :styles => { :small => "150x150>" }
  validates_attachment_size :vat_card, :less_than => 5.megabytes
  validates_attachment_content_type :vat_card, :content_type => ['image/jpeg', 'image/png']

  # TANCard uploader
  has_attached_file :tan_card, :styles => { :small => "150x150>" }
  validates_attachment_size :tan_card, :less_than => 5.megabytes
  validates_attachment_content_type :tan_card, :content_type => ['image/jpeg', 'image/png']

  # TANCard uploader
  has_attached_file :upload_address_proof, :styles => { :small => "150x150>" }
  validates_attachment_size :upload_address_proof, :less_than => 5.megabytes
  validates_attachment_content_type :upload_address_proof, :content_type => ['image/jpeg', 'image/png']

  # Cancelled Cheque uploader
  has_attached_file :cancelled_cheque, :styles => { :small => "150x150>" }
  validates_attachment_size :cancelled_cheque, :less_than => 5.megabytes
  validates_attachment_content_type :cancelled_cheque, :content_type => ['image/jpeg', 'image/png']

  BUSINESS_TYPES = "Proprietor","Company"
  ADDRESS_PROOFS = "Passport","Credit card statement","Electricity bill","Aadhar card","Telephone/mobile bill","Ration card","Bank account/credit card statement","Voter's identity card"
end

# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#

class User < ActiveRecord::Base
	has_and_belongs_to_many :firms
	
	belongs_to :primary_firm, :class_name => "Firm", :foreign_key => "primary_firm_id"
	
	attr_accessible :name, :email, :password, :password_confirmation, :primary_firm, :primary_firm_id, :admin #viimonen lisätty jotta voi seedata POISTA!!
	has_secure_password
	
	validates :name, :presence => { :message => "Nimi on pakollinen" }, :length => { :minimum => 2, :maximum => 50, :message => "Nimen täytyy olla 2-50 merkkiä pitkä" }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, :presence => { :message => "Sähköpostiosoite on pakollinen" }, :format => { :with => VALID_EMAIL_REGEX, :message => "Sähköpostiosoitteen muoto on virheellinen" }, :uniqueness => { :case_sensitive => false, :message => "Sähköpostiosoite on jo käytössä" }
    validates :password, presence: { :message => "Salasana on pakollinen" }, length: { minimum: 6, :message => "Salasanan täytyy olla vähintään 6 merkkiä pitkä" }
    validates :password_confirmation, presence: { :message => "Salasanan vahvistus on pakollinen" }
    
    before_save { |user| user.email = email.downcase }
    before_save :create_remember_token
    
    
    def self.get_admins
      self.where(admin: true)
    end
    
    private

      def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
      end
end

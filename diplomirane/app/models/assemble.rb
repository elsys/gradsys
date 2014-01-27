class Assembling < ActiveRecord::Base

has_and_belongs_to_many :students, foreign_key: "students", "grades", "first", "second", "third"

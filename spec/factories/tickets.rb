FactoryBot.define do
  factory :ticket do
    association :project, factory: :project
    name 'ticket name'
    description 'ticket description'
  end
end
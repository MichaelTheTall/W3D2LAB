require('pry-byebug')
require_relative('models/bebop.rb')

Bounty.delete_all()

bounty1 = Bounty.new({
  'name' => "Angry Bob",
  'bounty' => "500",
  'danger' => "medium",
  'fav_weapon' => "A big stick"
  })

bounty2 = Bounty.new({
  'name' => "Evil Steve",
  'bounty' => "65000",
  'danger' => "high",
  'fav_weapon' => "Trombone"
  })

bounty3 = Bounty.new({
  'name' => "Minging Kevin",
  'bounty' => "10",
  'danger' => "low",
  'fav_weapon' => "Body odour"
  })

bounty1.save()
bounty2.save()
bounty3.save()

Bounty.all()

binding.pry
nil

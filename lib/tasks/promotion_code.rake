# frozen_string_literal: true

namespace :promotion_code do
  desc "プロモコード生成 'rake promotion_code:generate'"
  task generate: :environment do
    10.times do |_n|
      random_string = Array.new(7) { [*'a'..'z', *'0'..'9'].sample }.join
      discount_amount = 100.step(by: 100, to: 1000).to_a.sample
      PromotionCode.create(promotion_code: random_string, discount_amount:, available: true)
    end
  end
end

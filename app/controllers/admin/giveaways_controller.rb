class Admin::GiveawaysController < ApplicationController
  layout 'admin'

  admin_assistant_for Giveaway do |aa|
    aa.index do |index|
      index.columns :prize_category, :giveaway_round, :count, :active
      index.sort_by 'giveaway_round_id, position'
      index.search :giveaway_round
    end
    
    aa.form do |form|
      form.columns :prize_category, :giveaway_round, :count, :active
      form[:count].description = "How many of this kind of prize are you giving away during this giveaway round?"
      form[:active].description = "Whether or not this giveaway should still be visible in the front-end interface. Usually you won't edit this through the admin."
    end
  end
  
  def order
    params['giveaways_index_tbody'].each_with_index do |id, i|
      Giveaway.update id, :position => i
    end
    render :text => 'Giveaways reordered.'
  end
end

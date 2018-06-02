class EnergyProductionsController < ApplicationController
  
  # def make_list(model, column)
  #   columns = model.select(:column).distinct
  #   column_list = []
  #   columns.each do |c|
  #     column_list << c.send(column)
  #   end
    
  #   return column_list
  # end
  
  def index
    # @energy_production = EnergyProduction.all.includes(:house)
    @energy_production = EnergyProduction.includes(:house)
    @house = House.all
    @e_p = EnergyProduction.all
    
    # label(グラフの横軸)の配列を用意
    labels = @e_p.select(:label).distinct
    
    label_list = []
    labels.each do |l|
      label_list << l.label
    end
    # label_list_t = ['7', '8', '9', '10', '11', '12', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '1', '2', '3', '4', '5', '6']
    label_list_t = ["7", "8", "9", "10", "11", "12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "1", "2", "3", "4", "5", "6"]
    
    @energy_production_hash = {}
    @energy_production_hash['label'] = label_list_t
    @energy_production_hash['data'] = {}
    
    # グルーピング用にcityの配列を用意
    cities = @house.select(:city).distinct
    city_list = []
    cities.each do |c|
      city_list << c.city
    end
    
    city_list.each do |city|
      
      epl2 = @energy_production.where(houses: { city: city })
      
      production = []
      label_list.each do |label|
        
        epl = epl2.where(label: label)
        
        ep_list = []
        epl.each do |e|
          ep_list << e.energy_production
        end
        #  epの平均値を得る
        ep_ave =  ep_list.inject(0.0){|r,i| r+=i }/ep_list.size
        production << ep_ave
      end
      
      @energy_production_hash['data'][city] = production
      
    end
    # debugger
  end
end

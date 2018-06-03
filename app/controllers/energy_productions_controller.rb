class EnergyProductionsController < ApplicationController
  include CommonCalc
  
  # def make_list(model, column)
  #   columns = model.select(:column).distinct
  #   column_list = []
  #   columns.each do |c|
  #     column_list << c.send(column)
  #   end
    
  #   return column_list
  # end
  
  def self.label_month_converter(model, labels)
    year = nil
    label_map = []
    
    labels.each do |label|
      r = model.find_by(label: label)
      
      if year == nil || r.year > year
        year = r.year
        label_map << "#{r.year}/#{r.month}"
        next
      end
      
      label_map << "#{r.month}"
    end
    
    return label_map
  end
  
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
    label_list = label_list.sort
    gon.label_list_t = self.class.label_month_converter(@e_p, label_list)
    @label_list_check = label_list
    
    @energy_production_hash = {}
    # @energy_production_hash['label'] = gon.label_list_t
    @energy_production_hash['data'] = {}
    
    # グルーピング用にcityの配列を用意
    cities = @house.select(:city).distinct
    city_list = []
    cities.each do |c|
      city_list << c.city
    end
    
    count_result = @house.group(:city).count.sort.to_h
    
    # 棒グラフ用の(x, y)データ
    gon.city_list_t = count_result.keys # 横軸: city
    gon.house_count_t = count_result.values # 横軸: city
    
    city_list.each do |city|
      
      epl2 = @energy_production.where(houses: { city: city })
      
      production = []
      label_list.each do |label|
        
        epl = epl2.where(label: label)
        
        ep_list = []
        epl.each do |e|
          ep_list << e.energy_production
        end
        # epの平均値を得る
        ep_ave = ave_calc(ep_list) 
        production << ep_ave
      end
      
      @energy_production_hash['data'][city] = production
      
    end
    gon.energy_production_list_t = @energy_production_hash['data']
    
  end
end

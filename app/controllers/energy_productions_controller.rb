class EnergyProductionsController < ApplicationController
  include CommonCalc
  
  def index
    
    energy_production_house = EnergyProduction.includes(:house)
    energy_production = EnergyProduction.all
    
    
    # prepare labels/data for bar chart
    count_result = House.group(:city).count.sort.to_h
    
    # pass labels/data
    gon.labels_bar = count_result.keys
    gon.data_bar = count_result.values
    
    
    # prepare labels for line chart
    label_list = energy_production.distinct.pluck(:label).sort
    
    # pass labels
    gon.labels_line = self.class.label_month_converter(energy_production, label_list)
    
    
    # prepare city list for grouping
    city_list = House.distinct.pluck(:city)
    # @check = energy_production.group("label").average("energy_production")
    # debugger
    
    # prepare data for line chart
    @data_line = {}
    city_list.each do |city|
      
      eph_h = energy_production_house.where(houses: { city: city })
      
      @check = eph_h.group("label").average("energy_production")
      # production = []
      # label_list.each do |label|
        
      #   eph_h_l = eph_h.where(label: label)
      #   ep_list = []
      #   eph_h_l.each{ |e| ep_list << e.energy_production }
        
      #   # calculate average of energy production
      #   ep_ave = ave_calc(ep_list) 
      #   production << ep_ave
      # end
      # pass data
      # @data_line[city] = production
      # @data_line[city] = @check.values.map(&:round(1))
      @data_line[city] = @check.values.map{ |v| v.round(1)}
    end
    # debugger
    
  end
  
  
  def self.label_month_converter(model, labels)
    year = nil
    months = []
    
    labels.each do |label|
      r = model.find_by(label: label)
      
      if year == nil || r.year > year
        year = r.year
        months << "#{r.year}/#{r.month}"
        next
      end
      
      months << "#{r.month}"
    end
    
    return months
  end
  
end

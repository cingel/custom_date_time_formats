module CustomDateTimeFormats
  FORMATS = {
    :time => {
      :hr => "%d.%m.%Y. %H:%M:%S",
      :human => "%m/%d/%Y %H:%M:%S"
    },
    :date => {
      :hr => "%d.%m.%Y.",
      :human => "%m/%d/%Y"
    }
  }
  
  class << self
    
    def add_time_formats(formats = {})
      add_formats(:time, formats)
    end
    
    def add_date_formats(formats = {})
      add_formats(:date, formats)
    end
    
    def add_predefined_formats
      add_formats(:time, FORMATS[:time])
      add_formats(:date, FORMATS[:date])
    end
    
    
    private
    
      def add_formats(scope, formats) 
        formats.each do |key,value|
          if scope.to_s.downcase == "time"
            ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS[key.to_sym] = value
          elsif scope.to_s.downcase == "date"
            ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS[key.to_sym] = value
            ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS[key.to_sym] = value unless ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.has_key?(key.to_sym) 
          else
            raise ArgumentError.new('You must set scope to :time or :date')
          end
        end
      end
    
  end
  
end
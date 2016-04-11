BOY  = 0
GIRL = 1
GIRL_PROBABILITY = 510
# srand 289389429838      # fix random seed

def boy_or_girl?
    return GIRL if rand(1_000) <= GIRL_PROBABILITY
    return BOY
end

class Hospitals
    attr_reader :total_over_60, :births_per_day

    def initialize(number_of_days, births_per_day)
        @number_of_days = number_of_days
        @births_per_day = births_per_day

        @days = []
        @total_over_60 = 0
        @number_of_days.times { @days << simulate_a_day }
    end

    def simulate_a_day
        @day = [0, 0]
        @births_per_day.times { @day[boy_or_girl?] += 1 }
        @total_over_60 += 1 if over_60?(@day)
        @day
    end

    # a day with 60%+ boys or 60%+ girls
    def over_60? day
        day_percentage = day[BOY].to_f / day.inject(:+)
        return day_percentage >= 0.60
    end

    def print_yearly_summary
        total_boys = @days.inject(0) { |total, day| total += day[BOY] }
        total_girls = @days.inject(0) { |total, day| total += day[GIRL] }
        percentage = 1.0 * total_girls / (total_boys + total_girls)

        summary =  "365 days, #{@births_per_day} births per day"
        summary << " | #{total_boys} boys and #{total_girls} girls "
        summary << " with #{@total_over_60} days over 60% diff"
        summary << " \t-- Hospital #{@name}"
        summary << sprintf(" %.4f%", percentage)
        puts summary
    end
end


number = 36
10.times {
    pequeno = Hospitals.new(number, 15)
    grande = Hospitals.new(number, 45)
    vencedor = pequeno.total_over_60 > grande.total_over_60 ? pequeno : grande
    puts sprintf("Vencedor: #{vencedor.births_per_day} (%d x %d)",
        pequeno.total_over_60, grande.total_over_60)
}
# Hospitals.new(number, 15).print_yearly_summary
# Hospitals.new(number, 45).print_yearly_summary
# Hospitals.new(number, 6).print_yearly_summary
# Hospitals.new(number, 100).print_yearly_summary



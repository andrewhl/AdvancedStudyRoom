module Utilities

  def self.format_rank(rank)
    return "?" unless rank
    r = rank.to_i
    if r > 0
      suffix = 'd'
    else
      suffix = 'k'
      r = r * -1 + 1
    end
    "#{r}#{suffix}"
  end

  # TODO: rename either this method or the one above
  #       to differentiate between a numerical rank and a 1k rank.
  def self.rank_convert(rank)
    return -31 if not rank

    if rank[-1,1] == "d"
      rank.scan(/[1-9]/)[0].to_i
    elsif rank[-1,1] == "k"
      newrank = rank.scan(/[1-9]/)[0]
      newrank.to_i * -1 + 1
    elsif rank == "?" || rank == "-"
      -31
    else
      puts "I DID NOT KNOW WHAT TO DO."
      -31
    end
  end

end
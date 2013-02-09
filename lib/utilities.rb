module Utilities

  def rank_convert(rank)
    if not rank
      return -31
    end
    if rank[-1,1] == "d"
      newrank = rank.scan(/[1-9]/)[0]
      newrank = Integer(newrank)
      rank_boolean = true
      return newrank
    elsif rank[-1,1] == "k"
      newrank = rank.scan(/[1-9]/)[0]
      newrank = Integer(newrank) * -1 + 1
      rank_boolean = true
      return newrank
    elsif (rank == "?") or (rank == "-")
      newrank = -31
      rank_boolean = false
      return newrank
    else
      puts "I DID NOT KNOW WHAT TO DO."
      return -31
    end
  end

end
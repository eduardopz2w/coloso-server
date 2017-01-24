module URID
  def URID.Generate(id, region)
    return "#{region.upcase}_#{id}"
  end

  def URID.GetRegion(urid)
    return urid[/[A-Z]+/]
  end

  def URID.GetId(urid)
    return urid.sub(/[A-Z]+_/, '').to_i
  end
end

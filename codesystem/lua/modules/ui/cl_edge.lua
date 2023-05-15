function WSG.DrawEdges( x, y, width, height, edgeSize, edgeWidth )


	--Draw the upper left corner.
  	surface.SetDrawColor(217, 217, 217)  
	surface.DrawRect(x,y,edgeSize,edgeWidth)
	surface.DrawRect(x,y + edgeWidth,edgeWidth,edgeSize - edgeWidth)

	local XRight = x + width

	--Draw the upper right corner.
  	surface.SetDrawColor(217, 217, 217)  
	surface.DrawRect(XRight - edgeSize,y,edgeSize,edgeWidth)
	surface.DrawRect(XRight - edgeWidth,y + edgeWidth,edgeWidth,edgeSize - edgeWidth)

	local YBottom = y + height

	--Draw the lower right corner.
  	surface.SetDrawColor(217, 217, 217)  
	surface.DrawRect(XRight - edgeSize,YBottom - edgeWidth,edgeSize,edgeWidth)
	surface.DrawRect(XRight - edgeWidth,YBottom - edgeSize,edgeWidth,edgeSize - edgeWidth)

	--Draw the lower left corner.
  	surface.SetDrawColor(217, 217, 217)  
	surface.DrawRect(x,YBottom - edgeWidth,edgeSize,edgeWidth)
	surface.DrawRect(x,YBottom - edgeSize,edgeWidth,edgeSize - edgeWidth)

end
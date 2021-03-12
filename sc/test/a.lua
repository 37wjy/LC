for i = 0, 7 do
	s=''
	for j = 1, 6 do
		s=s..(j+i*6)..', '
	end
	print('{'..s..'},')
end
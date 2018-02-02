#!/bin/bash

search_dir="$HOME/.xplanet"
img_dir="$search_dir/images"

# Xplanet
config="xplanet.cfg"
geometry="2048x1024"
latitude=20
longitude=0
output="/tmp/world.jpg"
projection="rectangular"
radius=50

# nitrogen (wallpaper setter)
bgcolor="#000000"

# Update map according to the current season
month=$(date +%m)
ln -sf "./earth_monthly/earth_${month}.jpg" "$img_dir/earth_monthly.jpg"

# Update clouds (free daily map)
curl -o $img_dir/clouds.jpg http://xplanetclouds.com/free/local/clouds_2048.jpg &>/dev/null

# Render the wallpaper w/ Xplanet (infinite loop)
xplanet -searchdir $search_dir -projection $projection -geometry $geometry \
	-output "$output" -radius $radius -longitude $longitude -latitude $latitude \
	-config $config -post_command="nitrogen --set-scaled --set-color=$bgcolor \
	--head=0 $output"

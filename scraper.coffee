get_flag = (thumb_url) ->
  t = thumb_url.split('/thumb/').join('/')
  t.substring 0, t.indexOf('.svg/') + 4

process_row = (tr) ->
  row = {}
  tds = $(tr).find 'td'
  nametd = $ tds[1]
  is_country = is_bold = nametd.find('b').length > 0
  span = if is_bold then nametd.find('b') else nametd.find('i')
  thumb = span.find('img').attr 'src'
  flag = get_flag thumb
  a = span.find('a')
  wikipage_url = a.attr('href')
  wikipedia_id = wikipage_url.split('/')[2]
  label = a.text()
  population = Number $(tds[2]).text().split(',').join('')
  [wikipedia_id, label, is_country, population, thumb, flag]

trs = $ '#sortable_table_id_0 tr'
countries = []
for i in [2 ... trs.length]
  countries.push process_row trs[i]

## we now have a nice 2d array with all countries
## we print it out as JSON
console.log JSON.stringify(countries).replace(/\]/g,"]\n")

# now we compose the TTL output
ttl = '@prefix v: <http://github.com/aldonline/dbpedia-countries-extra-data/raw/master/vocab.ttl#> . \n'
for c in countries
  ttl += " <http://dbpedia.org/resource/#{c[0]}> "
  ttl += " v:id \"#{c[0]}\" ; "
  ttl += " v:label \"#{c[1]}\" ; "
  ttl += " v:is_country " + (if c[2] then 1 else 0) + ' ; '
  ttl += " v:population #{c[3]} ; "
  ttl += " v:thumb <#{c[4]}> ; "
  ttl += " v:flag <#{c[5]}> . "
  ttl += '\n'

# and print it out
console.log ttl

###

http://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/22px-Flag_of_the_United_States.svg.png
http://upload.wikimedia.org/wikipedia/commons/a/a4/Flag_of_the_United_States.svg

http://upload.wikimedia.org/wikipedia/commons/d/dc/Flag_of_Saudi_Arabia.svg




<!-- bold with supertext -->

<tr>
<td>1</td>
<td align="left"><b><span class="flagicon"><img alt="" src="http://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/22px-Flag_of_the_People%27s_Republic_of_China.svg.png" width="22" height="15" class="thumbborder">&nbsp;</span><a href="/wiki/People%27s_Republic_of_China" title="People's Republic of China">China</a></b><sup class="reference plainlinks nourlexpansion" id="ref_n2"><a href="#endnote_n2">n2</a></sup></td>
<td>1,341,000,000</td>
<td>December 31, 2010</td>
<td>19.41%</td>
<td style="font-size: 75%"><a href="http://www.stats.gov.cn/was40/gjtjj_en_detail.jsp?searchword=population&amp;channelid=9528&amp;record=1" class="external text" rel="nofollow">Official Chinese Population Estimate</a></td>
</tr>

<!-- bold -->

<tr>
<td>3</td>
<td align="left"><b><span class="flagicon"><img alt="" src="http://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/22px-Flag_of_the_United_States.svg.png" width="22" height="12" class="thumbborder">&nbsp;</span><a href="/wiki/United_States">United States</a></b></td>
<td>311,030,000</td>
<td>March 23, 2011</td>
<td>4.5%</td>
<td style="font-size: 75%"><a href="http://www.census.gov/population/www/popclockus.html" class="external text" rel="nofollow">Official United States Population Clock</a></td>
</tr>

<!-- not bold ( not a sovereign country ) -->

<tr>
<td>129</td>
<td align="left"><i><span class="flagicon"><img alt="" src="http://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Flag_of_Puerto_Rico.svg/22px-Flag_of_Puerto_Rico.svg.png" width="22" height="15" class="thumbborder">&nbsp;</span><a href="/wiki/Puerto_Rico">Puerto Rico</a></i></td>
<td>3,725,789</td>
<td>April 1, 2010</td>
<td>0.054%</td>
<td style="font-size: 75%"><a href="http://2010.census.gov/news/pdf/apport2010_table2.pdf" class="external text" rel="nofollow">2010 census</a></td>
</tr>


###
if [ -z "$1" ]; then
  echo "You need at least one argument"
else

  for name in "$@"; do

    datafile='data-hold/namesample.txt'

    name_matches=$(cat $datafile | grep "$name,")

    m_count=0
    f_count=0

  if [ -z "$name_matches" ]; then
    echo "$name,NA,0,0"

    else
      for row in $name_matches; do
        babies=$(echo $row | cut -d ',' -f '3')
      if [[ $row =~ ',M,' ]]; then
        m_count=$((m_count + babies))
      else
        f_count=$((f_count + babies))
      fi
    done
  fi

  total_babies=$((m_count + f_count))

  pct_female=$((100 * f_count / total_babies))
  pct_male=$((100 - pct_female))

  if [[ $pct_female -gt 50 ]]; then
    g_and_pct="F,$pct_female"
  else
    g_and_pct="M,$pct_male"
  fi

  echo "$name,$g_and_pct,$total_babies"

  done
fi

# coding: utf-8
# hh:mm での開始時刻と終了時刻を与えて経過時間を得る

def hhmm_to_min(hhmm)
  min = hhmm.split(":")[0].to_i * 60 + hhmm.split(":")[1].to_i
  return min
end
def min_to_hhmm(min)
##  hhmm =  min.divmod(60)[0].to_s + ":" + min.divmod(60)[1].to_s
  hhmm =  sprintf("%02d",min.divmod(60)[0]) + ":" + sprintf("%02d",min.divmod(60)[1])
  return hhmm 
end

start_time = ARGV[0]
end_time = ARGV[1]

duration = hhmm_to_min(end_time) - hhmm_to_min(start_time) 
puts min_to_hhmm(duration)



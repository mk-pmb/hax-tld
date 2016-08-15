#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function zfupd_to_stdout () {
  local ZF_TMPL="$1"; shift
  [ -f "$ZF_TMPL" ] || return 2$(echo 'E: no zonefile template given' >&2)
  local MAXLN=9053
  local ZF_STATIC="$(head -n "$MAXLN" -- "$ZF_TMPL" \
    | grep -Pe '^;== BEGIN dynhosts ==' -m 1 -B "$MAXLN")"
  [ -n "$ZF_STATIC" ] || return 4$(echo "E: cannot find dynhosts marker" \
    "within the first $MAXLN lines of zone file $ZF_LIVE" >&2)

  local ZF_DATA="$(<<<"$ZF_STATIC" zfupd_extract_zone_data_words)"
  echo "<$ZF_DATA>"

  echo "E: $FUNCNAME: stub!" >&2; return 8
}


function zfupd_extract_zone_data_words () {
  local ZF_DATA="$(cut -d ';' -f 1 | grep -oPe '\S+')"
  ZF_DATA=" ${ZF_DATA//$'\n'/ } "
  ZF_DATA="${ZF_DATA// \( / }"
  ZF_DATA="${ZF_DATA// \) / }"
  ZF_DATA="${ZF_DATA% }"
  ZF_DATA="${ZF_DATA# }"
  echo "$ZF_DATA"
}


function zfupd_replace_and_reload () {
  echo "E: $FUNCNAME: stub, not implemented." >&2
  return 2
}


function zfupd_decode_serial_minute () {
  local TS_SER=  # CyyyDDDhhmm
  let TS_SER="$1 + 20000000000"
  [ "${#TS_SER}" == 11 ] || return 1
  local TS_DDD="${TS_SER:4:3}"
  local TS_MONTH=
  let TS_MONTH="$TS_DDD / 50"
  [ "${TS_MONTH:-0}" -ge 1 ] || return 1
  local TS_DAY=
  let TS_DAY="$TS_DDD % 50"
  [ "${TS_DAY:-0}" -ge 1 ] || return 1
  printf '%s-%02d-%02d-%s\n' "${TS_SER:0:4}" $TS_MONTH $TS_DAY "${TS_SER:7}"
}


function zfupd_time_to_serial_minute () {
  local TS_YEAR="${1:-0}"; shift
  [ "$TS_YEAR" -ge 2001 ] || return 7$(logerr "$FUNCNAME:" \
    "You can't use this zonefile generator before it was invented." \
    "Fix your clock or use your time machine to make that" \
    "feature request _before_ I write this error message.")   # 🙌
  [ "$TS_YEAR" -le 2214 ] || return 7$(logerr "$FUNCNAME: Please update" \
    "this zonefile generator; this version only works until 2214-12-31.")
  local TS_MONTH="$1"; shift
  local TS_DAY="$1"; shift
  local TS_HOURMIN="$1"; shift
  local YEAR_IN_CENTURY=
  let YEAR_IN_CENTURY="$TS_YEAR % 1000"
  [ "${YEAR_IN_CENTURY:-0}" -ge 1 ] || return 3
  local TS_DDD=
  let TS_DDD="(${TS_MONTH#0} * 50) + $TS_DAY"
  # ^-- strip that leading 0 from month or "let" it will think it's octal.
  # ("let: TS_DDD=(08: value too great for base")
  [ "${TS_DDD:-0}" -ge 1 ] || return 3

  # Don't worry about leading zeroes in the combined timestamp: We should
  # have verified YEAR_IN_CENTURY >= 1 above and calculated it by modulo.
  echo "$YEAR_IN_CENTURY$TS_DDD$TS_HOURMIN"
}












[ "$1" == --lib ] && return 0; zfupd_"$1" "${@:2}"; exit $?

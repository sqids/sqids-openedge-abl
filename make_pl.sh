#!/bin/sh
DLC=${DLC-/usr/dlc11715}; export DLC
LIB_NAME="Sqids.pl"

case "x$display_banner" in
  x | xyes)
    cat "$DLC/version"
    echo
  ;;
esac

if [ -f "$LIB_NAME" ]; then
    rm -rf "$LIB_NAME"
fi

$DLC/bin/prolib "$LIB_NAME" -create

find . -type f -name "*.r" | sed 's|^\./||' | while read -r file; do
    $DLC/bin/prolib "$LIB_NAME" -add "$file"
done

$DLC/bin/prolib "$LIB_NAME" -compress

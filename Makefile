build:
	rm -rf build && meson build && ninja -C build

clean:
	rm -rf build subprojects/systemd*/

distclean: clean
	rm -rf subprojects/packagecache/

.PHONY: build clean distclean

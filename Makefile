serve:
	HOST=127.0.0.1 PORT="8996" TARGET_HOST="example.org"	go run .

nix_shell:
	nix-shell default.nix --command $${SHELL}

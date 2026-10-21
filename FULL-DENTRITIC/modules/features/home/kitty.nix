{
	inputs,
	...
}: {
	flake.homeModules.kitty = {pkgs, ... }: {
    programs.kitty = {
			enable = true;
			shellIntegration = {
				enableBashIntegration = true;
				enableZshIntegration = true;
				enableFishIntegration = true;
				mode = "no-cursor";
			};

			settings = {
				# disable_ligatures = "always";
				# scrollback_lines = 1000;
				# enable_audio_bell = "no";
				# cursor_shape = "block";
				confirm_os_window_close = 1;
				sync_to_monitor = "yes";
				
				# Tab bar
				tab_bar_edge = "top";
				tab_bar_style = "slant";
				tab_bar_min_tabs = 1;
				tab_title_template = "{tab.progress_percent}{title}";

				#background_opacity = 0.5;
				#dynamic_background_opacity = "yes";
			};

      themeFile = "Neutron";
      #themeFile = "Darkside";
			#themeFile = "Spacedust";
			#themeFile = "Treehouse";
			#themeFile = "Wombat";
    };

		# set kitty as default terminal
		# TODO: Check if this is working!
		xdg.terminal-exec = {
			enable = true;
			settings = {
				default = [
					"kitty.desktop"
				];
			};
		};
	};
}


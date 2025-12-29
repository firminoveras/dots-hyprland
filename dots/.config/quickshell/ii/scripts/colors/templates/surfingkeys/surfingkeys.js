settings.smoothScroll = true;
settings.verticalTabs = false;
settings.scrollStepSize = 120;
settings.hintAlign = "left";
settings.language = "pt-BR";
settings.modeAfterYank = "Normal";
api.Hints.setCharacters('asdghlqweyuipzxcvbnm');

api.map('V', 'L');
api.map('P', 'cc');
api.map('gi', 'i');
api.map('F', 'gf');
api.map('gf', 'w');
api.map('`', '\'');
api.map('>_t', 't');
api.map('t', 'T');
api.map('T', 'on');
api.map('o', 'go');
api.map('O', '>_t');
api.map('H', 'S');
api.map('L', 'D');
api.map('K', 'R');
api.map('J', 'E');
api.map('w', 'cs');
api.map('q', 'x');

api.iunmap('<Ctrl-a>');

api.Hints.style(`
	background: initial;
	color:#$primary #;
	background-color: #$surfaceContainerLowest #;
	border: none;
	padding: 2px 6px;
	font-family: MonoLisa Nerd Font;
	text-transform: lowercase;
	font-size: 12px;
	font-weight: 800;
	border-radius: 32px;
	box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.8);
`);

api.Hints.style(`
	background: initial !important;
	color: #$tertiary # !important;
	background-color: #$onTertiary # !important;
	border: none !important;
	padding: 2px 6px !important;
	font-family: MonoLisa Nerd Font;
	text-transform: lowercase;
	font-size 12px !important;
	font-weight: 800 !important;
	border-radius: 32px !important;
	box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.8) !important;
`, "text");

api.Visual.style('marks', 'background-color: #$onPrimary #99;');
api.Visual.style('cursor', 'background-color: #$primary #;');

/* set theme */
settings.theme = `
.sk_theme {
  font-family: Rubrik,Input Sans Condensed, Charcoal, sans-serif;
  font-size: 12px;
	font-weight: 600;
  background: #$background #;
  color: #$onBackground #;
}
.sk_theme tbody {
  color: #b8bb26;
}
.sk_theme input {
  color: #$primary #;
}
.sk_theme .url {
  color: #38971a;
}
.sk_theme .annotation {
  color: #b16286;
}


/* Omnibar */

#sk_omnibar {
	left: 15%;
  width: 70%;
  box-shadow: 0px 30px 50px rgba(0, 0, 0, 0.8);
}

.sk_omnibar_middle {
	top: 15%;
	border-radius: 20px;
}

.sk_theme .omnibar_highlight {
  color: #ebdbb2;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
  background: #$background #;
}

.sk_theme #sk_omnibarSearchResult {
  max-height: 60vh;
  overflow: hidden;
  margin: 0;
}

#sk_omnibarSearchResult > ul {
	padding: 0 8px;
}

.sk_theme #sk_omnibarSearchResult ul li {
  margin-block: 0.5rem;
  padding-left: 0.4rem;
	font-weight: 500;
}

.sk_theme #sk_omnibarSearchResult ul li.focused {
	background: #$primary #;
	border-color: #$primary #;
	position: relative;
	color: #$on_primary #;
	border-radius: 999px;
}

#sk_omnibarSearchArea > input {
	display: inline-block;
	width: 100%;
	flex: 1;
	font-size: 14px;
	font-weight: 800;
	color: #$onBackground #;
	margin-bottom: 0;
	padding: 0;
	background: transparent;
	border-style: none;
	outline: none;
	padding-left: 8px;
}

#sk_omnibarSearchArea {
	margin: 8px !important;
	border: none;
}

#sk_omnibarSearchArea .resultPage {
	display: inline-block;
  font-size: 12px;
  font-style: italic;
	width: auto;
	padding-right: 8px;
}

#sk_omnibarSearchResult li div.url {
	font-weight: normal;
	white-space: nowrap;
	color: #$outline #;
}

#sk_omnibarSearchResult li.focused div.url {
	color: #$onPrimary #;
}

.sk_theme .omnibar_highlight {
	background: #$surfaceContainerHigh #;
	color: #$onBackground #;
	border-radius: 4px;
}

.sk_theme .omnibar_visitcount {
	color: #$primary #;
}

.sk_theme li.focused .omnibar_visitcount {
	color: #$onPrimary #;
}

.sk_theme li.focused .omnibar_highlight {
	background: #$primary #;
	color: #$onPrimary #;
}

.sk_theme .omnibar_folder {
	border: 1px solid #188888;
	border-radius: 5px;
	background: #188888;
	color: #aaa;
	box-shadow: 1px 1px 5px rgba(0, 8, 8, 1);
}

.sk_theme .omnibar_timestamp {
	background: #$inverseOnSurface #;
	border: 1px solid #$inverseOnSurface #;
	border-radius: 5px;
	color: #$onSurface #;
	box-shadow: 1px 1px 5px rgb(0, 8, 8);
}

#sk_omnibarSearchResult li div.title {
	text-align: left;
	max-width: 100%;
	white-space: nowrap;
	overflow: hidden;
}

.sk_theme .separator {
	color: #$onPrimary #;
}


/* Tabs */

#sk_tabs {
  background: #$background #;
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;
	top: auto !important;
	z-index: 2147483000;
	margin: 0;
  border: none;
  border-radius: 0;
	width: 100% !important;
  display: flex !important;
  flex-direction: row !important;
  justify-content: flex-start !important;
  align-items: center !important;
	flex-wrap: wrap !important;
  gap: 0 4% !important;
  scrollbar-width: none !important;
}

div.sk_tab_wrap {
  display: flex !important;
  align-items: center !important;
  flex-direction: row !important;
  flex-wrap: nowrap !important;
	width: 100% !important;
}

#sk_tabs div.sk_tab {
  display: flex !important;
  align-items: center !important;
  background: #$background #;
	border-radius: 999px;
	width: auto !important;
	max-width: 12% !important;
	vertical-align: bottom;
	justify-items: center;
	border-radius: 0px;
	margin: 0px; 
	border-top: solid 0px black; 
	margin-block: 0rem;
	box-shadow: none;
	text-overflow: hidden;
}

#sk_tabs div.sk_tab.active{
	opacity: 30%;
}

#sk_tabs div.sk_tab_hint{
	border: none !important;
	background: #$background # !important;
	color: #$primary #;
}

#sk_tabs div.sk_tab_title {
	display: inline-block;
	vertical-align: middle;
	font-size: 10pt;
	white-space: nowrap;
	text-overflow: hidden;
	overflow: hidden;
	padding-left: 5px;
	color: #$onBackground #;
}


/* Status */

#sk_status {
	position: fixed;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 2147483000;
	padding: 4px 8px;
	border: none;
	border-radius 0;
	box-shadow: 0px 20px 40px 2px rgba(0, 0, 0, 1);
	margin-bottom: 0px;
	width: 100%;
}

#sk_status, #sk_find {
	font-size: 12px;
	font-weight: 600;
  text-align: start;
}

#sk_status span[style*="border-right: 1px solid rgb(153, 153, 153);"] {
    display: none;
}


/* Others */

#sk_usage, #sk_popup, #sk_editor {
	overflow: auto;
	position: fixed;
	width: 80%;
	max-height: 80%;
	top: 10%;
	left: 10%;
	text-align: left;
	box-shadow: 0px 30px 50px rgba(0, 0, 0, 0.8);
	z-index: 2147483298;
	padding: 1rem;
	border: 1px solid #282828;
	border-radius: 10px;
}

#sk_keystroke {
	padding: 6px;
	position: fixed;
	float: right;
	bottom: 0px;
	z-index: 2147483000;
	right: 0px;
	background: #282828;
	color: #fff;
	border: 1px solid #181818;
	border-radius: 10px;
	margin-bottom: 1rem;
	margin-right: 1rem;
	box-shadow: 0px 30px 50px rgba(0, 0, 0, 0.8);
}

.sk_theme .prompt{
	color: #$onPrimary #;
	background-color: #$primary #;
	border-radius: 100px;
	padding-left: 18px;
	padding-right: 18px;
	font-weight: bold;
	box-shadow: 1px 3px 5px rgba(0, 0, 0, 0.8);
}
`;

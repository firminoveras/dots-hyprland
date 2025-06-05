const { GLib } = imports.gi;
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
const { Box, Button, EventBox, Label, Overlay, Revealer } = Widget;
const { execAsync, exec } = Utils;
import { AnimatedCircProg } from "../../.commonwidgets/cairo_circularprogress.js";
import { MaterialIcon } from '../../.commonwidgets/materialicon.js';
import { showMusicControls } from '../../../variables.js';

const CUSTOM_MODULE_CONTENT_INTERVAL_FILE = `${GLib.get_user_cache_dir()}/ags/user/scripts/custom-module-interval.txt`;
const CUSTOM_MODULE_CONTENT_SCRIPT = `${GLib.get_user_cache_dir()}/ags/user/scripts/custom-module-poll.sh`;
const CUSTOM_MODULE_LEFTCLICK_SCRIPT = `${GLib.get_user_cache_dir()}/ags/user/scripts/custom-module-leftclick.sh`;
const CUSTOM_MODULE_RIGHTCLICK_SCRIPT = `${GLib.get_user_cache_dir()}/ags/user/scripts/custom-module-rightclick.sh`;
const CUSTOM_MODULE_MIDDLECLICK_SCRIPT = `${GLib.get_user_cache_dir()}/ags/user/scripts/custom-module-middleclick.sh`;
const CUSTOM_MODULE_SCROLLUP_SCRIPT = `${GLib.get_user_cache_dir()}/ags/user/scripts/custom-module-scrollup.sh`;
const CUSTOM_MODULE_SCROLLDOWN_SCRIPT = `${GLib.get_user_cache_dir()}/ags/user/scripts/custom-module-scrolldown.sh`;

function trimTrackTitle(title) {
    if (!title) return '';
    const cleanPatterns = [
        /【[^】]*】/,        // Touhou n weeb stuff
        " [FREE DOWNLOAD]", // F-777
    ];
    cleanPatterns.forEach((expr) => title = title.replace(expr, ''));
    return title;
}

function adjustVolume(direction) {
    const step = 0.1; // We use a larger step because this is player instance volume, not global
    const mpris = Mpris.getPlayer('');
    mpris.volume += (direction === 'up') ? step : -step
}


const BarGroup = ({ child }) => Box({
    className: 'bar-group-margin bar-sides',
    children: [
        Box({
            className: `bar-group${userOptions.appearance.borderless ? '-borderless' : ''} bar-group-standalone bar-group-pad-system`,
            children: [child],
        }),
    ]
});

const BarResource = (name, icon, command, circprogClassName = `bar-batt-circprog ${userOptions.appearance.borderless ? 'bar-batt-circprog-borderless' : ''}`, textClassName = 'txt-onSurfaceVariant', iconClassName = 'bar-batt') => {
    const resourceCircProg = AnimatedCircProg({
        className: `${circprogClassName}`,
        vpack: 'center',
        hpack: 'center',
    });
    const resourceProgress = Box({
        homogeneous: true,
        children: [Overlay({
            child: Box({
                vpack: 'center',
                className: `${iconClassName}`,
                homogeneous: true,
                children: [
                    Label({label : icon, className : 'bar-resource-txt'}),
                ],
            }),
            overlays: [resourceCircProg]
        })]
    });
    const resourceLabel = Label({
        className: `bar-resource-label ${textClassName}`,
    });
    const widget = Button({
        onClicked: () => Utils.execAsync(['bash', '-c', `${userOptions.apps.taskManager}`]).catch(print),
        child: Box({
            className: `spacing-h-4 ${textClassName}`,
            children: [
                resourceProgress,
                resourceLabel,
            ],
            setup: (self) => self.poll(5000, () => execAsync(['bash', '-c', command])
                .then((output) => {
                    resourceCircProg.css = `font-size: ${Number(output)}px;`;
                    resourceLabel.label = `${(output)}%`;
                    widget.tooltipText = `${name}: ${Math.round(Number(output))}%`;
                }).catch(print))
            ,
        })
    });
    return widget;
}

const TrackProgress = () => {
    const _updateProgress = (circprog) => {
        const mpris = Mpris.getPlayer('');
        if (!mpris)
            circprog.css = `font-size: ${userOptions.appearance.borderless ? 100 : 0}px;`
        else // Set circular progress value
            circprog.css = `font-size: ${Math.max(mpris.position / mpris.length * 100, 0)}px;`
    }
    return AnimatedCircProg({
        className: `bar-music-circprog ${userOptions.appearance.borderless ? 'bar-music-circprog-borderless' : ''}`,
        vpack: 'center', hpack: 'center',
        extraSetup: (self) => self
            .hook(Mpris, _updateProgress)
            .poll(3000, _updateProgress)
        ,
    })
}

const switchToRelativeWorkspace = async (self, num) => {
    try {
        const Hyprland = (await import('resource:///com/github/Aylur/ags/service/hyprland.js')).default;
        Hyprland.messageAsync(`dispatch workspace ${num > 0 ? '+' : ''}${num}`).catch(print);
    } catch {
        execAsync([`${App.configDir}/scripts/sway/swayToRelativeWs.sh`, `${num}`]).catch(print);
    }
}



export default () => {
    // TODO: use cairo to make button bounce smaller on click, if that's possible
    const playingState = Box({ // Wrap a box cuz overlay can't have margins itself
        homogeneous: true,
        children: [Overlay({
            child: Box({
                vpack: 'center',
                className: 'bar-music-playstate',
                homogeneous: true,
                children: [Label({
                    vpack: 'center',
                    className: 'bar-music-playstate-txt',
                    justification: 'center',
                    setup: (self) => self.hook(Mpris, label => {
                        const mpris = Mpris.getPlayer('');
                        label.label = `${mpris !== null && mpris.playBackStatus == 'Playing' ? 'pause' : 'play_arrow'}`;
                    }),
                })],
                setup: (self) => self.hook(Mpris, label => {
                    const mpris = Mpris.getPlayer('');
                    if (!mpris) return;
                    label.toggleClassName('bar-music-playstate-playing', mpris.playBackStatus == 'Playing');
                    label.toggleClassName('bar-music-playstate', mpris.playBackStatus == 'Paused');
                }),
            }),
            overlays: [
                TrackProgress(),
            ]
        })]
    });
    const trackTitle = Label({
        hexpand: true,
        className: 'txt-smallie bar-music-txt',
        truncate: 'end',
        maxWidthChars: 1, // Doesn't matter, just needs to be non negative
        setup: (self) => self.hook(Mpris, label => {
            const mpris = Mpris.getPlayer('');
            if (mpris)
                label.label = `${trimTrackTitle(mpris.trackTitle)} • ${mpris.trackArtists.join(', ')}`;
            else
                label.label = getString('No media');
        }),
    })
    const musicStuff = Box({
        className: 'spacing-h-10',
        hexpand: true,
        children: [
            playingState,
            trackTitle,
        ]
    })


    const cpuTempLabel = Label({ className : 'bar-resource-label' })
    const pchTempLabel = Label({ className : 'bar-resource-label' })
    const ramTotalLabel = Label({ className : 'bar-resource-label' })

    const SystemResourcesOrCustomModule = () => {
        // Check if $XDG_CACHE_HOME/ags/user/scripts/custom-module-poll.sh exists
        if (GLib.file_test(CUSTOM_MODULE_CONTENT_SCRIPT, GLib.FileTest.EXISTS)) {
            const interval = Number(Utils.readFile(CUSTOM_MODULE_CONTENT_INTERVAL_FILE)) || 5000;
            return BarGroup({
                child: Button({
                    child: Label({
                        className: 'txt-smallie txt-onSurfaceVariant',
                        useMarkup: true,
                        setup: (self) => Utils.timeout(1, () => {
                            self.label = exec(CUSTOM_MODULE_CONTENT_SCRIPT);
                            self.poll(interval, (self) => {
                                const content = exec(CUSTOM_MODULE_CONTENT_SCRIPT);
                                self.label = content;
                            })
                        })
                    }),
                    onPrimaryClickRelease: () => execAsync(CUSTOM_MODULE_LEFTCLICK_SCRIPT).catch(print),
                    onSecondaryClickRelease: () => execAsync(CUSTOM_MODULE_RIGHTCLICK_SCRIPT).catch(print),
                    onMiddleClickRelease: () => execAsync(CUSTOM_MODULE_MIDDLECLICK_SCRIPT).catch(print),
                    onScrollUp: () => execAsync(CUSTOM_MODULE_SCROLLUP_SCRIPT).catch(print),
                    onScrollDown: () => execAsync(CUSTOM_MODULE_SCROLLDOWN_SCRIPT).catch(print),
                })
            });
        } else return BarGroup({
            child: Box({
                className: 'spacing-h-10',
                children: [
                    EventBox({
                        onPrimaryClick: (self) => { self.child.children[1].revealChild = !self.child.children[1].revealChild; },
                        child: 
                            Box({
                                className : 'bar-resourse-box',
                                children: [
                                    BarResource(getString('CPU Usage'), 'CPU', `LANG=C top -bn1 | grep Cpu | sed 's/\\,/\\./g' | awk '{printf("%02d\\n", $2)}'`,
                                        'bar-cpu-circprog', 'bar-cpu-txt', 'bar-cpu-icon'),

                                    Revealer({
                                        revealChild: false,
                                        transition: 'slide_left',
                                        transitionDuration: userOptions.animations.durationLarge,
                                        child: Box({
                                            children: [
                                                Label({label : '', className : 'bar-resource-sep' }),
                                                cpuTempLabel,
                                            ]
                                        }),
                                    }),
                                ]
                            })
                    }),

                    EventBox({
                        onPrimaryClick: (self) => { self.child.children[1].revealChild = !self.child.children[1].revealChild; },
                        child: 
                            Box({
                                className : 'bar-resourse-box',
                                children: [
                                    BarResource(getString('RAM Usage'), 'RAM', `LANG=C free | awk '/^Mem/ {printf("%02d\\n", ($3/$2) * 100)}'`,
                                        'bar-ram-circprog', 'bar-ram-txt', 'bar-ram-icon'),

                                    Revealer({
                                        revealChild: false,
                                        transition: 'slide_left',
                                        transitionDuration: userOptions.animations.durationLarge,
                                        child: Box({
                                            children: [
                                                Label({label : '', className : 'bar-resource-sep' }),
                                                ramTotalLabel
                                            ]
                                        }),
                                    }),
                                ],
                                setup: (self) => self.poll(5000, () => execAsync(['bash', '-c', `LANG=C free | awk '/^Mem/ {printf("%.1f", ($3/1024)/1024)}'`])
                                    .then((output) => {
                                        ramTotalLabel.label = `${(output)}GB`
                                    }).catch(print))
                            })
                    }),

                    EventBox({
                        onPrimaryClick: (self) => { self.child.children[1].revealChild = !self.child.children[1].revealChild; },
                        child: 
                            Box({
                                className : 'bar-resourse-box',
                                children: [
                                    BarResource(getString('PCH Temp'), 'PCH', `LANG=C df -H | grep -m 1 'nvme' | awk '/nvme/ {printf("%d", $5)}'`, 'bar-ram-circprog', 'bar-ram-txt', 'bar-ram-icon'),

                                    Revealer({
                                        revealChild: false,
                                        transition: 'slide_left',
                                        transitionDuration: userOptions.animations.durationLarge,
                                        child: Box({
                                            children: [
                                                Label({label : '', className : 'bar-resource-sep' }),
                                                pchTempLabel
                                            ]
                                        }),
                                    }),
                                ]
                            }),
                    }),
                ],
                setup: (self) => self.poll(5000, () => execAsync('sensors -j').then(output => {
                    const temp = JSON.parse(output);
                    cpuTempLabel.label = `${temp["coretemp-isa-0000"]["Package id 0"].temp1_input.toString()}ºC`;
                    pchTempLabel.label = `${temp["pch_cannonlake-virtual-0"].temp1.temp1_input.toString()}ºC`;
                }).catch(print))
            })
        });
    }
    return EventBox({
        onScrollUp: () => adjustVolume('up'),
        onScrollDown: () => adjustVolume('down'),
        child: Box({
            className: 'spacing-h-4 bar-music-main',
            children: [
                SystemResourcesOrCustomModule(),
                EventBox({
                    child: BarGroup({ child: musicStuff }),
                    onPrimaryClick: () => showMusicControls.setValue(!showMusicControls.value),
                    onSecondaryClick: () => execAsync(['bash', '-c', 'playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"` &']).catch(print),
                    onMiddleClick: () => execAsync('playerctl play-pause').catch(print),
                    setup: (self) => self.on('button-press-event', (self, event) => {
                        if (event.get_button()[1] === 8) // Side button
                            execAsync('playerctl previous').catch(print)
                    }),
                })
            ]
        })
    });
}


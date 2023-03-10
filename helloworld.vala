/*
 * This file is part of budgie-desktop
 *
 * Copyright Budgie Desktop Developers
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

public class HelloWorldRavenPlugin : Budgie.RavenPlugin, Peas.ExtensionBase {
	public Budgie.RavenWidget new_widget_instance(string uuid, GLib.Settings? settings) {
		return new HelloWorldRavenWidget(uuid, settings);
	}

	public bool supports_settings() {
		return true;
	}
}

public class HelloWorldRavenWidget : Budgie.RavenWidget {
	private Gtk.Revealer? content_revealer = null;

	public HelloWorldRavenWidget(string uuid, GLib.Settings? settings) {
		initialize(uuid, settings);

		var main_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		add(main_box);

		var header = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
		header.get_style_context().add_class("raven-header");
		main_box.add(header);

		var icon = new Gtk.Image.from_icon_name("ubuntu-budgie-symbolic", Gtk.IconSize.MENU);
		icon.margin = 4;
		icon.margin_start = 12;
		icon.margin_end = 10;
		header.add(icon);

		var header_label = new Gtk.Label("Hello World");
		header.add(header_label);

		var content = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
		content.get_style_context().add_class("raven-background");

		content_revealer = new Gtk.Revealer();
		content_revealer.add(content);
		content_revealer.reveal_child = true;
		main_box.add(content_revealer);

		var header_reveal_button = new Gtk.Button.from_icon_name("pan-down-symbolic", Gtk.IconSize.MENU);
		header_reveal_button.get_style_context().add_class("flat");
		header_reveal_button.get_style_context().add_class("expander-button");
		header_reveal_button.margin = 4;
		header_reveal_button.valign = Gtk.Align.CENTER;
		header_reveal_button.clicked.connect(() => {
			content_revealer.reveal_child = !content_revealer.child_revealed;
			var image = (Gtk.Image?) header_reveal_button.get_image();
			if (content_revealer.reveal_child) {
				image.set_from_icon_name("pan-down-symbolic", Gtk.IconSize.MENU);
			} else {
				image.set_from_icon_name("pan-end-symbolic", Gtk.IconSize.MENU);
			}
		});
		header.pack_end(header_reveal_button, false, false, 0);

		var rows = new Gtk.Grid();
		rows.hexpand = true;
		rows.margin_start = 12;
		rows.margin_end = 12;
		rows.margin_top = 8;
		rows.margin_bottom = 8;
		rows.set_column_spacing(8);
		content.add(rows);

		Gtk.Label hellolabel = new Gtk.Label("Hello World");
		Gtk.Button hellobutton = new Gtk.Button();
		hellobutton.set_label("This does nothing");
		rows.attach(hellolabel, 0, 0, 1, 1);
		rows.attach(hellobutton, 0, 1, 1, 1);
		show_all();
	}

	public override Gtk.Widget build_settings_ui() {
		return new HelloWorldRavenWidgetSettings(get_instance_settings());
	}
}

public class HelloWorldRavenWidgetSettings : Gtk.Grid {
	Gtk.Label hello;
	Gtk.Button button;

	public HelloWorldRavenWidgetSettings (Settings? settings) {
		button = new Gtk.Button();
		button.set_label("this does nothing");
		hello = new Gtk.Label("Hello World");
		attach(hello, 0, 0, 1, 1);
		attach(button, 0, 1, 1, 1);
		show_all();
	}
}

[ModuleInit]
public void peas_register_types(TypeModule module) {
	// boilerplate - all modules need this
	var objmodule = module as Peas.ObjectModule;
	objmodule.register_extension_type(typeof(Budgie.RavenPlugin), typeof(HelloWorldRavenPlugin));
}

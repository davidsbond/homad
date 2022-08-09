// Package assets provides functions for accessing embedded assets used by the web application.
package assets

import (
	"embed"
	"html/template"
	"io/fs"
)

//go:embed templates/*.gohtml
var templateFS embed.FS

// Templates parses and returns all templates contained within the templates directory. Templates are embedded into
// the application on build.
func Templates() (*template.Template, error) {
	dir, err := fs.Sub(templateFS, "templates")
	if err != nil {
		return nil, err
	}

	tpl := template.New("speed-dial")
	tpl.Funcs(map[string]any{
		"add": func(x, y int) int {
			return x + y
		},
	})

	return tpl.ParseFS(dir, "index.gohtml")
}

//go:embed images/*
var imagesFS embed.FS

// Images returns an fs.FS implementation containing all images. Images are embedded into the application
// on build.
func Images() (fs.FS, error) {
	dir, err := fs.Sub(imagesFS, "images")
	if err != nil {
		return nil, err
	}

	return dir, nil
}

//go:embed styles/*.css
var stylesFS embed.FS

// StyleSheets returns and fs.FS implementation containing all stylesheets. Stylesheets are embedded into the application/
// on build.
func StyleSheets() (fs.FS, error) {
	dir, err := fs.Sub(stylesFS, "styles")
	if err != nil {
		return nil, err
	}

	return dir, nil
}

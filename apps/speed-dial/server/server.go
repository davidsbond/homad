package server

import (
	"context"
	"errors"
	"fmt"
	"html/template"
	"io"
	"io/fs"
	"mime"
	"net/http"
	"os"
	"path/filepath"

	"github.com/davidsbond/homad/apps/speed-dial/config"
	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	"golang.org/x/sync/errgroup"
)

func Run(ctx context.Context, config config.Config, templates *template.Template, images, styles fs.FS) error {
	router := mux.NewRouter()
	server := &http.Server{
		Addr:    fmt.Sprint(":", config.Port),
		Handler: router,
	}

	router.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		if err := templates.ExecuteTemplate(w, "index.gohtml", config); err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
		}
	})

	router.HandleFunc("/image/{image}", func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		image := vars["image"]

		file, err := images.Open(image)
		switch {
		case errors.Is(err, fs.ErrNotExist):
			http.Error(w, http.StatusText(http.StatusNotFound), http.StatusNotFound)
			return
		case err != nil:
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content-Type", mime.TypeByExtension(filepath.Ext(image)))
		if _, err = io.Copy(w, file); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	})

	router.HandleFunc("/styles/{stylesheet}", func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		stylesheet := vars["stylesheet"]

		file, err := styles.Open(stylesheet)
		switch {
		case errors.Is(err, fs.ErrNotExist):
			http.Error(w, http.StatusText(http.StatusNotFound), http.StatusNotFound)
			return
		case err != nil:
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content-Type", mime.TypeByExtension(filepath.Ext(stylesheet)))
		if _, err = io.Copy(w, file); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
	})

	router.Use(handlers.CompressHandler)
	router.Use(handlers.RecoveryHandler())
	router.Use(func(h http.Handler) http.Handler {
		return handlers.LoggingHandler(os.Stdout, h)
	})

	grp, ctx := errgroup.WithContext(ctx)
	grp.Go(func() error {
		return server.ListenAndServe()
	})
	grp.Go(func() error {
		<-ctx.Done()
		return server.Close()
	})

	return grp.Wait()
}

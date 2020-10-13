package core

import "time"

type Vehicle struct {
	ID        string    `json:"id,omitempty"`
	Name      string    `json:"name,omitempty"`
	Model     string    `json:"model,omitempty"`
	Color     string    `json:"color,omitempty"`
	Sign      string    `json:"sign,omitempty"`
	Status    string    `json:"status,omitempty"`
	UserId    string    `json:"user_id,omitempty"`
	CreatedAt time.Time `json:"created_at,omitempty"`
	Fav       bool      `json:"fav,omitempty"`
	Type      string    `json:"type,omitempty"`
}

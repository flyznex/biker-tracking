package core

import "time"

type Bike struct {
	ID        string `json:"id"`
	Name      string `json:"name,omitempty"`
	Model     string `json:"model,omitempty"`
	Color     string `json:"color,omitempty"`
	Sign      string `json:"sign,omitempty"`
	Status    string `json:"status,omitempty"`
	UserId    string
	CreatedAt time.Time
}

from datetime import date

from pydantic import BaseModel


class Artist(BaseModel):
    id: int
    name: str

    class Config:
        orm_mode = True


class Album(BaseModel):
    id: int
    name: str
    year: int
    price: float
    cover: str
    stock: int

    artists_id: int

    class Config:
        orm_mode = True


class Song(BaseModel):
    id: int
    name: str
    genre: str
    duration: int

    albums_id: int

    class Config:
        orm_mode = True


class User(BaseModel):
    id: int
    fname: str
    lname: str
    email: str
    pwd: str
    address: str
    zipcode: str
    city: str
    country: str

    class Config:
        orm_mode = True


class LoginCredential(BaseModel):
    email: str
    pwd: str

    class Config:
        orm_mode = True


class Orders_items(BaseModel):
    id: int
    quantity: int

    albums_id: int
    orders_id: int

    class Config:
        orm_mode = True

from pydantic.utils import GetterDict

from mealie.db.models.group.shopping_list import ShoppingList
from mealie.schema._mealie import MealieModel


class ListItem(MealieModel):
    title: str | None
    text: str = ""
    quantity: int = 1
    checked: bool = False

    class Config:
        orm_mode = True


class ShoppingListIn(MealieModel):
    name: str
    group: str | None
    items: list[ListItem]


class ShoppingListOut(ShoppingListIn):
    id: int

    class Config:
        orm_mode = True

        @classmethod
        def getter_dict(cls, ormModel: ShoppingList):
            return {
                **GetterDict(ormModel),
                "group": ormModel.group.name,
            }

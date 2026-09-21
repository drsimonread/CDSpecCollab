from django.contrib import admin
from django.contrib.auth import admin as auth_admin
from django.contrib.auth import get_user_model
from django.utils.translation import gettext as _

from users.forms import UserChangeForm, UserCreationForm


User = get_user_model()


@admin.register(User)
class UserAdmin(auth_admin.UserAdmin):

    form = UserChangeForm
    add_form = UserCreationForm
    fieldsets = tuple(
        auth_admin.UserAdmin.fieldsets
    )

    staff_fieldsets = (
        (None, {'fields': ("username",)}),
        (_('Personal info'), {'fields': ('first_name', 'last_name', 'email')}),
        (_('Groups'), {'fields': ('groups',)}),
        (_('Important dates'), {'fields': ('last_login', 'date_joined')}),
    )

    staff_readonly_fields = ('name', 'first_name', 'last_name', 'email', 'last_login', 'date_joined')

    list_display = ["username", "name", "is_superuser"]
    search_fields = ["name"]

    def get_fieldsets(self, request, obj=None):
        if not request.user.is_superuser:
            return self.staff_fieldsets
        else:
            return super(UserAdmin, self).get_fieldsets(request, obj)

    def get_readonly_fields(self, request, obj=None):
        if not request.user.is_superuser:
            return self.staff_readonly_fields
        else:
            return super(UserAdmin, self).get_readonly_fields(request, obj)
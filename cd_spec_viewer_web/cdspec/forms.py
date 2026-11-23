from django.forms import FileInput, ModelForm
from cdspec.models import SpecRun



#Upload form, model specifies which database table to use and fields specify the fields included in the form.
class CreateForm(ModelForm):
    class Meta:
        model = SpecRun
        fields = ('run_title', 'run_description', 'run_user', 'visible_student', 'visible_public',
         'source_file', 'protein_concentration', 'pathlength', 'number_of_amino_acids')
        widgets = {
            'source_file': FileInput(attrs={'accept': '.csv'}),
        }

#Edit form, model specifies which database table to use and fields specify the fields included in the form.
class EditForm(ModelForm):
    class Meta:
        model = SpecRun
        fields = ('run_title', 'run_description', 'visible_student', 'visible_public')
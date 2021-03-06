import abc

from .templator import render


class AbstractTemplate(metaclass=abc.ABCMeta):

    @abc.abstractmethod
    def __call__(self, *args, **kwargs):
        pass


class Template(AbstractTemplate):
    template = ''
    context = {}
    request = {}

    def __init__(self):
        self.json_file = None

    def post(self, request):
        if request.request.get('POST'):
            self.context.update(request.request.get('POST'))
            return self.context

    def get(self, request):
        if request.request.get('GET'):
            self.context.update(request.request.get('GET'))
            return self.context

    def get_context(self, request):
        return self.context

    def get_json_file(self, request):
        pass

    def __call__(self, request, **kwargs):
        if request.method == 'POST':
            self.post(request)
        elif request.method == 'GET':
            self.get(request)
        self.get_context(request)
        self.get_json_file(request)

        if self.json_file:
            return '200 OK', self.json_file
        else:
            return '200 OK', bytes(
                render(self.template, request=request.request, context=self.context),
                encoding='utf-8'
            )


class NotFoundPage:
    def __call__(self, request):
        return '404 Not Found', b'404 page not found'

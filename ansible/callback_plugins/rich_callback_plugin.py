from ansible.plugins.callback import CallbackBase


class CallbackModule(CallbackBase):
    CALLBACK_VERSION = 2.0
    CALLBACK_TYPE = "stdout"
    CALLBACK_NAME = "rich_callback_plugin"

    def __init__(self, display=None):
        super(CallbackModule, self).__init__(display)

    def v2_runner_on_ok(self, result, **kwargs):
        self._display.display(
            "Task completed successfully: %s" % result._task.get_name()
        )

    def v2_runner_on_failed(self, result, **kwargs):
        self._display.display("Task failed: %s" % result._task.get_name())

    # You can add more methods to handle other events like
    # v2_runner_on_unreachable, v2_playbook_on_start, etc.

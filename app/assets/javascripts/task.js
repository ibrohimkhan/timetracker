/**
 * Created by ibrohim on 8/13/14.
 */
function Label(options) {
    var elem = options.elem;
    var listContainer = this._labelContainer = options.list;
    var tag = this._tag = options.tag;
    this.mode = options.mode;
    this.labelList = [];

    if (!listContainer && !elem && !tag) return false;
    if (listContainer.children) {
        var labels = listContainer.children;

        for (var i = 0; i < labels.length; i++) {
            var name = labels[i].textContent;
            if (name === undefined && name == null) continue;
            this.labelList.push(name);
        }
    }

    elem.addEventListener('click', this._addLabelEvent.bind(this), false);

    listContainer.addEventListener('click', this._removeNewLabelEvent.bind(this), false);
    listContainer.addEventListener('click', this._removeEditLabelEvent.bind(this), false);
}

Label.prototype._addLabelEvent = function(event) {
    if (this.isNotEmptyBox(this._tag)) {
        this._createLabel(this._tag);
    }
};

Label.prototype.isNotEmptyBox = function(tag) {
    var tag_name = tag.value;
    if (!tag_name) return false;

    return true;
};

Label.prototype._createLabel = function(label) {
    var self = this;
    $.ajax({
        type: 'POST',
        url: '/labels/',
        data: $.param({label: {name: label.value}}),
        success: function(data) {
            var obj = null;
            if (data instanceof Array) {
                obj = data[0];
            } else {
                obj = data;
            }

            if (self.mode == 'new') self.addLabelToNewList(obj.name);
            if (self.mode == 'edit') self.addLabelToEditList(obj.name);
            label.value = "";
        }
    });
};

//================= Add Items to List ================\\

Label.prototype.addLabelToNewList = function(label) {
    if (!this._isLabelExist(label)) return false;

    var tr = document.createElement("tr");
    var btn = document.createElement("input");

    btn.type = 'button';
    btn.className = 'btn btn-danger btn-xs';
    btn.value = 'Remove it';

    var labelName = document.createElement("td");
    labelName.appendChild(document.createTextNode(label));

    var labelControl = document.createElement("td");
    labelControl.appendChild(btn);

    tr.appendChild(labelName);
    tr.appendChild(labelControl);
    this._labelContainer.appendChild(tr);
};

Label.prototype.addLabelToEditList = function(label) {
    if (!this._isLabelExist(label)) return false;

    var tr = document.createElement("tr");
    tr.setAttribute("id", "#{@task.id}");
    tr.setAttribute("data-label", "new");

    var btn = document.createElement("input");
    btn.type = 'button';
    btn.className = 'btn btn-danger btn-xs';
    btn.value = 'Remove it';

    var labelName = document.createElement("td");
    labelName.appendChild(document.createTextNode(label));

    var labelControl = document.createElement("td");
    labelControl.appendChild(btn);

    tr.appendChild(labelName);
    tr.appendChild(labelControl);

    this._labelContainer.appendChild(tr);
};

Label.prototype._isLabelExist = function(label) {
    var size = this.labelList.indexOf(label);
    if (size != -1) return false;

    this.labelList.push(label);
    return true;
};

//============== Delete Items From List==============\\

Label.prototype._removeNewLabelEvent = function(event) {
    if (this.mode == 'edit') return false;

    var target = event.target;
    if (target.tagName != 'INPUT') return false;

    var tr = target.parentElement.parentElement;
    var item = tr.children[0].innerHTML;

    var index = this.labelList.indexOf(item);
    this.labelList.splice(index, 1);

    this._labelContainer.removeChild(tr);
};

Label.prototype._removeEditLabelEvent = function(event) {
    if (this.mode == 'new') return false;

    var target = event.target;
    if (target.tagName != 'INPUT') return false;

    var tr = target.parentElement.parentElement;
    var item = tr.children[0].innerHTML;
    var item_state = tr.dataset.label;
    var index = this.labelList.indexOf(item);

    this.labelList.splice(index, 1);
    this._labelContainer.removeChild(tr);

    if (item_state == "new") return false;

    $.ajax({
        type: 'POST',
        url: '/tasks/delete_label',
        data: $.param( {label: {name: item, id: tr.id}} )
    });
};

//========== Create & Edit Actions =========\\

Label.prototype.createLabelAction = function() {
    var labels = this.labelList.join('/*/');

    $.ajax({
        type: 'POST',
        url: '/tasks/save_labels',
        data: $.param({label: {name: labels}})
    });
};

Label.prototype.editLabelAction = function() {
    var rows = this._labelContainer.childNodes;
    if (rows === undefined || rows == null) return false;

    var id = rows[0].getAttribute('id');
    var items = [];

    for (var i = 0; i < rows.length; i++) {
        var row_attr = rows[i].dataset.label;

        if (row_attr == "new") {
            var item = rows[i].textContent;
            if (item !== undefined) items.push(item);
        }
    }

    var labels = items.join('/*/');

    $.ajax({
        type: 'POST',
        url: '/tasks/save_by_task_id',
        data: $.param({label: {name: labels, id: id}})
    });
};

function Task(options) {
    var parentList = options.parentList;
    this.selectedItem = null;

    if (parentList != null) parentList.addEventListener('click', this._changeParentId.bind(this), false);
}

Task.prototype._changeParentId = function(event) {
    var target = event.target;
    if (target.tagName != 'LI') return false;
    if (this.selectedItem != null) this.selectedItem.style.border = "";

    target.style.border = "1px solid green";
    this.selectedItem = target;
    var taskId = target.getAttribute("id");

    var parentTaskId = document.getElementById('parentid');
    parentTaskId.value = taskId;
};

function TaskUI(options) {
    var container        = this._container = options.container;
    var createTask       = this._createTask = options.createTask;
    var subtaskTable     = this._subtaskTable = options.subtaskTable;
    var createSubTask    = this._createSubTask = options.createSubTask;
    var goToParentTask   = this._goToParentTask = options.goToParentTask;
    var addLabel         = this._addLabel = options.addLabel;
    var labels           = this._labels = options.labels;
    var tag              = this._tag = options.tag;
    this._id             = options.id;
    this._newLabel       = null;

    $(container).hide();

    $(createTask).on('click', this._createTaskBtn.bind(this));
    $(createSubTask).on('click', this._createSubTaskBtn.bind(this));
    $(subtaskTable).on('click', this._subtaskTableBtn.bind(this));
    $(goToParentTask).on('click', this._goToParentTaskBtn.bind(this));
}

TaskUI.prototype._createSubTaskBtn = function(event) {
    $(this._container).toggle();
    $(this._subtaskTable).toggle();

    var isContainerVisible = $(this._container).is(':visible');
    if (isContainerVisible) {
        event.target.value = "Go to list subtasks";
        this._newLabel = new Label({
            elem: this._addLabel,
            list: this._labels,
            tag: this._tag,
            mode: 'new'
        });
    } else {
        event.target.value = "Create subtask";
    }
};

TaskUI.prototype._subtaskTableBtn = function(event) {
    var target = event.target;
    if (target.tagName != 'TD' && target.tagName != 'A') return false;

    if (target.tagName == 'A') {
        var id = target.parentElement.parentElement.getAttribute('id');
        window.location.href = window.location.origin + '/tasks/' + id + '/edit';
    } else {
        var id = target.parentElement.getAttribute('id');
        window.location.href = window.location.origin + '/tasks/' + id;
    }
};

TaskUI.prototype._goToParentTaskBtn = function(event) {
    window.location.href = window.location.origin + "/tasks/" + this._id;
};

TaskUI.prototype._createTaskBtn = function(event) {
    this._newLabel.createLabelAction.bind(this._newLabel);
};
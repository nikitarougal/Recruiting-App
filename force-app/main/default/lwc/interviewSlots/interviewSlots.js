import { LightningElement, wire, track } from "lwc";
import findFreeTimeSlots from "@salesforce/apex/EventScheduler.findFreeTimeSlots";

const COLUMNS = [
  {
    label: "Start Time",
    fieldName: "startTime",
    type: "date",
    typeAttributes: {
      year: "numeric",
      month: "long",
      day: "2-digit",
      hour: "2-digit",
      minute: "2-digit"
    }
  },
  {
    label: "End Time",
    fieldName: "endTime",
    type: "date",
    typeAttributes: {
      year: "numeric",
      month: "long",
      day: "2-digit",
      hour: "2-digit",
      minute: "2-digit"
    }
  }
];

export default class InterviewSlots extends LightningElement {
  slots = [];
  columns = COLUMNS;

  @wire(findFreeTimeSlots)
  wiredSlots({ data, error }) {
    if (data) {
      this.slots = data;
      console.log("data: " + data);
    } else if (error) {
      // Handle error
      console.log(error);
    }
  }

  handleRowAction(event) {
    const action = event.detail.action;
    const row = event.detail.row;

    // Implement logic to handle the action
    if (action.name === "schedule_interview") {
      // Do something when the 'Schedule Interview' action is clicked
      // For example, redirect to the interview scheduling page
    }
  }

  getRowActions(row, doneCallback) {
    const actions = [
      { label: "Schedule Interview", name: "schedule_interview" }
    ];
    // Perform some logic if needed
    doneCallback(actions);
  }

  refreshData() {
    // Refresh or recall the Apex method to fetch updated slots
  }
}

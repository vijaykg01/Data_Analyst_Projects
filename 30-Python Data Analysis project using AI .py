import os
import tkinter as tk
from tkinter import ttk, filedialog, messagebox

import pandas as pd

from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from matplotlib.figure import Figure


class DataAnalysisApp:

    def __init__(self, root):

        self.root = root
        self.root.title("AI Data Analysis Software")
        self.root.geometry("1400x850")

        self.df = None
        self.report_df = None
        self.file_path = None
        self.chart_figure = None
        self.canvas = None

        self.text_columns = []
        self.numeric_columns = []

        self.create_widgets()

    # =====================================================
    # GUI
    # =====================================================

    def create_widgets(self):

        top_frame = ttk.LabelFrame(self.root, text="File Selection")
        top_frame.pack(fill="x", padx=10, pady=5)

        self.file_var = tk.StringVar()

        ttk.Entry(
            top_frame,
            textvariable=self.file_var,
            width=100
        ).grid(row=0, column=0, padx=5, pady=5)

        ttk.Button(
            top_frame,
            text="Browse",
            command=self.browse_file
        ).grid(row=0, column=1, padx=5)

        ttk.Button(
            top_frame,
            text="Read",
            command=self.read_file
        ).grid(row=0, column=2, padx=5)

        # ----------------------------------------------

        info_frame = ttk.LabelFrame(self.root, text="Dataset Information")
        info_frame.pack(fill="x", padx=10, pady=5)

        self.info_text = tk.Text(info_frame, height=6)
        self.info_text.pack(fill="x", padx=5, pady=5)

        # ----------------------------------------------

        report_frame = ttk.LabelFrame(self.root, text="Report Builder")
        report_frame.pack(fill="x", padx=10, pady=5)

        ttk.Label(report_frame, text="Group By").grid(
            row=0, column=0, padx=5, pady=5
        )

        self.group_var = tk.StringVar()
        self.group_combo = ttk.Combobox(
            report_frame,
            textvariable=self.group_var,
            state="readonly",
            width=25
        )
        self.group_combo.grid(row=0, column=1)

        ttk.Label(report_frame, text="Aggregation").grid(
            row=0, column=2, padx=5
        )

        self.agg_var = tk.StringVar()
        self.agg_combo = ttk.Combobox(
            report_frame,
            textvariable=self.agg_var,
            state="readonly",
            width=20
        )

        self.agg_combo["values"] = (
            "sum",
            "mean",
            "max",
            "min",
            "count",
            "median"
        )

        self.agg_combo.grid(row=0, column=3)

        ttk.Label(report_frame, text="Value Column").grid(
            row=0, column=4,
            padx=5
        )

        self.value_var = tk.StringVar()

        self.value_combo = ttk.Combobox(
            report_frame,
            textvariable=self.value_var,
            state="readonly",
            width=25
        )

        self.value_combo.grid(row=0, column=5)

        ttk.Button(
            report_frame,
            text="Preview Report",
            command=self.preview_report
        ).grid(row=0, column=6, padx=10)

        ttk.Button(
            report_frame,
            text="Export Report",
            command=self.export_report
        ).grid(row=0, column=7, padx=5)

        # ----------------------------------------------

        chart_frame = ttk.LabelFrame(self.root, text="Chart Builder")
        chart_frame.pack(fill="x", padx=10, pady=5)

        ttk.Label(chart_frame, text="Chart Type").grid(
            row=0, column=0, padx=5
        )

        self.chart_var = tk.StringVar()

        self.chart_combo = ttk.Combobox(
            chart_frame,
            textvariable=self.chart_var,
            state="readonly",
            width=20
        )

        self.chart_combo["values"] = (
            "Bar Chart",
            "Column Chart",
            "Line Chart",
            "Pie Chart"
        )

        self.chart_combo.grid(row=0, column=1)

        ttk.Button(
            chart_frame,
            text="Preview Chart",
            command=self.preview_chart
        ).grid(row=0, column=2, padx=10)

        ttk.Button(
            chart_frame,
            text="Export Chart",
            command=self.export_chart
        ).grid(row=0, column=3, padx=5)

        # ----------------------------------------------

        output_frame = ttk.Frame(self.root)
        output_frame.pack(fill="both", expand=True, padx=10, pady=5)

        # Report Area

        report_area = ttk.LabelFrame(
            output_frame,
            text="Report Preview"
        )

        report_area.pack(
            side="left",
            fill="both",
            expand=True,
            padx=5
        )

        self.tree = ttk.Treeview(report_area)

        self.tree.pack(
            fill="both",
            expand=True,
            padx=5,
            pady=5
        )

        # Chart Area

        self.chart_area = ttk.LabelFrame(
            output_frame,
            text="Chart Preview"
        )

        self.chart_area.pack(
            side="right",
            fill="both",
            expand=True,
            padx=5
        )

    # =====================================================
    # FILE FUNCTIONS
    # =====================================================

    def browse_file(self):

        filetypes = [
            ("Excel Files", "*.xlsx *.xls"),
            ("CSV Files", "*.csv")
        ]

        file_path = filedialog.askopenfilename(
            title="Select File",
            filetypes=filetypes
        )

        if file_path:
            self.file_path = file_path
            self.file_var.set(file_path)

    def read_file(self):

        if not self.file_path:
            messagebox.showerror(
                "Error",
                "Please select a file."
            )
            return

        try:

            ext = os.path.splitext(
                self.file_path
            )[1].lower()

            if ext == ".csv":
                self.df = pd.read_csv(self.file_path)
            else:
                self.df = pd.read_excel(self.file_path)

            self.detect_columns()
            self.display_dataset_info()

        except Exception as e:
            messagebox.showerror(
                "Read Error",
                str(e)
            )

    # =====================================================
    # COLUMN DETECTION
    # =====================================================

    def detect_columns(self):

        self.text_columns = []

        self.numeric_columns = []

        for col in self.df.columns:

            if pd.api.types.is_numeric_dtype(
                    self.df[col]):
                self.numeric_columns.append(col)

            else:

                converted = pd.to_numeric(
                    self.df[col],
                    errors="coerce"
                )

                if converted.notna().sum() > 0:
                    self.numeric_columns.append(col)
                else:
                    self.text_columns.append(col)

        self.group_combo["values"] = self.text_columns
        self.value_combo["values"] = self.numeric_columns

    # =====================================================
    # DATASET INFO
    # =====================================================

    def display_dataset_info(self):

        self.info_text.delete("1.0", tk.END)

        info = f"""
Total Rows : {self.df.shape[0]}
Total Columns : {self.df.shape[1]}

Column Names:
{', '.join(self.df.columns)}
"""

        self.info_text.insert(
            tk.END,
            info
        )

    # =====================================================
    # REPORT GENERATION
    # =====================================================

    def preview_report(self):

        if self.df is None:
            messagebox.showerror(
                "Error",
                "Please read a file first."
            )
            return

        group_col = self.group_var.get()
        agg_method = self.agg_var.get()
        value_col = self.value_var.get()

        if not group_col or not agg_method or not value_col:
            messagebox.showerror(
                "Error",
                "Please select all report options."
            )
            return

        try:

            self.report_df = (
                self.df
                .groupby(group_col)[value_col]
                .agg(agg_method)
                .reset_index()
                .sort_values(
                    value_col,
                    ascending=False
                )
            )

            self.display_report()

        except Exception as e:
            messagebox.showerror(
                "Report Error",
                str(e)
            )

    def display_report(self):

        self.tree.delete(
            *self.tree.get_children()
        )

        self.tree["columns"] = list(
            self.report_df.columns
        )

        self.tree["show"] = "headings"

        for col in self.report_df.columns:

            self.tree.heading(
                col,
                text=col
            )

            self.tree.column(
                col,
                width=180
            )

        for row in self.report_df.values.tolist():

            self.tree.insert(
                "",
                tk.END,
                values=row
            )

    # =====================================================
    # EXPORT REPORT
    # =====================================================

    def export_report(self):

        if self.report_df is None:

            messagebox.showerror(
                "Error",
                "Generate report first."
            )
            return

        export_window = tk.Toplevel(
            self.root
        )

        export_window.title(
            "Select Export Format"
        )

        format_var = tk.StringVar(
            value="xlsx"
        )

        ttk.Radiobutton(
            export_window,
            text="Excel",
            variable=format_var,
            value="xlsx"
        ).pack(anchor="w")

        ttk.Radiobutton(
            export_window,
            text="CSV",
            variable=format_var,
            value="csv"
        ).pack(anchor="w")

        def save():

            folder = os.path.dirname(
                self.file_path
            )

            if format_var.get() == "xlsx":

                output = os.path.join(
                    folder,
                    "Report_Output.xlsx"
                )

                self.report_df.to_excel(
                    output,
                    index=False
                )

            else:

                output = os.path.join(
                    folder,
                    "Report_Output.csv"
                )

                self.report_df.to_csv(
                    output,
                    index=False
                )

            messagebox.showinfo(
                "Success",
                f"Saved:\n{output}"
            )

            export_window.destroy()

        ttk.Button(
            export_window,
            text="Export",
            command=save
        ).pack(pady=10)

    # =====================================================
    # CHARTS
    # =====================================================

    def preview_chart(self):

        if self.report_df is None:

            messagebox.showerror(
                "Error",
                "Generate report first."
            )

            return

        chart_type = self.chart_var.get()

        if not chart_type:

            messagebox.showerror(
                "Error",
                "Select chart type."
            )

            return

        for widget in self.chart_area.winfo_children():
            widget.destroy()

        self.chart_figure = Figure(
            figsize=(6, 5),
            dpi=100
        )

        ax = self.chart_figure.add_subplot(111)

        x = self.report_df.iloc[:, 0]
        y = self.report_df.iloc[:, 1]

        if chart_type == "Bar Chart":
            ax.barh(x, y)

        elif chart_type == "Column Chart":
            ax.bar(x, y)

        elif chart_type == "Line Chart":
            ax.plot(x, y)

        elif chart_type == "Pie Chart":
            ax.pie(
                y,
                labels=x,
                autopct="%1.1f%%"
            )

        ax.set_title(chart_type)

        self.canvas = FigureCanvasTkAgg(
            self.chart_figure,
            master=self.chart_area
        )

        self.canvas.draw()

        self.canvas.get_tk_widget().pack(
            fill="both",
            expand=True
        )

    # =====================================================
    # EXPORT CHART
    # =====================================================

    def export_chart(self):

        if self.chart_figure is None:

            messagebox.showerror(
                "Error",
                "Generate chart first."
            )

            return

        folder = os.path.dirname(
            self.file_path
        )

        output = os.path.join(
            folder,
            "Report_Chart.png"
        )

        self.chart_figure.savefig(
            output,
            bbox_inches="tight"
        )

        messagebox.showinfo(
            "Success",
            f"Chart saved:\n{output}"
        )


# =========================================================
# MAIN
# =========================================================

if __name__ == "__main__":

    root = tk.Tk()

    app = DataAnalysisApp(root)

    root.mainloop()
    
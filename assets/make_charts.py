"""Make the two README charts for the churn repo, from verified numbers only."""
import os
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "assets")
os.makedirs(OUT, exist_ok=True)

TEAL = "#0f766e"
GREY = "#64748b"
LIGHT = "#ccfbf1"

plt.rcParams.update({
    "font.family": "DejaVu Sans",
    "font.size": 11,
    "axes.edgecolor": "#cbd5e1",
    "axes.labelcolor": "#1e293b",
    "xtick.color": "#334155",
    "ytick.color": "#334155",
})

# Chart 1: churn rate by contract type
labels = ["Month-to-month", "One year", "Two year"]
rates = [42.7, 11.3, 2.8]
fig, ax = plt.subplots(figsize=(7, 4))
bars = ax.bar(labels, rates, color=[TEAL, "#2dd4bf", "#99f6e4"], width=0.55)
ax.set_ylabel("Customers who churned (%)")
ax.set_title("Churn rate by contract type", fontsize=13, color="#1e293b", pad=12)
ax.set_ylim(0, 50)
ax.spines[["top", "right"]].set_visible(False)
ax.yaxis.grid(True, color="#e2e8f0", linewidth=0.8)
ax.set_axisbelow(True)
for b, r in zip(bars, rates):
    ax.text(b.get_x() + b.get_width() / 2, r + 1.2, f"{r}%", ha="center", fontsize=12, color="#1e293b")
fig.tight_layout()
fig.savefig(os.path.join(OUT, "churn-by-contract.png"), dpi=150)
plt.close(fig)

# Chart 2: churn by internet service and payment method
fig, axes = plt.subplots(1, 2, figsize=(8, 4))
ax = axes[0]
bars = ax.bar(["Fiber optic", "DSL"], [41.9, 19.0], color=[TEAL, "#2dd4bf"], width=0.55)
ax.set_title("By internet service", fontsize=12, color="#1e293b")
ax.set_ylabel("Customers who churned (%)")
ax.set_ylim(0, 55)
ax.spines[["top", "right"]].set_visible(False)
ax.yaxis.grid(True, color="#e2e8f0", linewidth=0.8)
ax.set_axisbelow(True)
for b, r in zip(bars, [41.9, 19.0]):
    ax.text(b.get_x() + b.get_width() / 2, r + 1.5, f"{r}%", ha="center", fontsize=12, color="#1e293b")

ax = axes[1]
bars = ax.bar(["Electronic check", "Automatic payments"], [45.3, 16.0], color=[TEAL, "#2dd4bf"], width=0.55)
ax.set_title("By payment method", fontsize=12, color="#1e293b")
ax.set_ylim(0, 55)
ax.spines[["top", "right"]].set_visible(False)
ax.yaxis.grid(True, color="#e2e8f0", linewidth=0.8)
ax.set_axisbelow(True)
for b, r, lab in zip(bars, [45.3, 16.0], ["45.3%", "~16%"]):
    ax.text(b.get_x() + b.get_width() / 2, r + 1.5, lab, ha="center", fontsize=12, color="#1e293b")

fig.tight_layout()
fig.savefig(os.path.join(OUT, "churn-by-service-and-payment.png"), dpi=150)
plt.close(fig)
print("done:", sorted(os.listdir(OUT)))

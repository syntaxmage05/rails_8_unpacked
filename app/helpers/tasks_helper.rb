module TasksHelper
  def task_status_badge_classes(status)
    case status.to_s
    when "completed"
      "bg-emerald-500/15 text-emerald-300 ring-emerald-400/30"
    when "archived"
      "bg-slate-500/15 text-slate-300 ring-slate-400/30"
    else
      "bg-amber-500/15 text-amber-300 ring-amber-400/30"
    end
  end
end

Return-Path: <linux-tip-commits+bounces-7715-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6CBCBFF5B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3083330421BF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E7338927;
	Mon, 15 Dec 2025 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JU1CNwcP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+hi5KkER"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4F2336ED1;
	Mon, 15 Dec 2025 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834492; cv=none; b=Wf4lMaDnn5DotVUNG9DZ7cNhbZqO2rqdTC7Ht2sOGTvTtIbd5kfdQKKMssfEquLPsmwb2B4xUlErsvxd5gDc/0un0jBepUEuPTHMyZoFlyhgt3NCL06Q6WPZr7jpsCSPoni6/7GesDynUZegkXZduppMCHyoDCcU9CFtvQtDRak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834492; c=relaxed/simple;
	bh=qepz+YzIQuhzSBeQ2m8akbQBZVRY4Bn+3pk7HHOBI/w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uzKyw8M/OFPs+BOn7RWDQM9/ovY7lZrOUf8aJWktowdWFFZSEad2PdfzZ48ZwmPnjwvZGBhNOZfCSPvgL3rJmKM0jPHniTxgyX4blmwZfKrT33oWsPocf6+crR4T3npXETVrD8ZkpYvksqIjcBrkgNps1hpFoWjlqCDrmfBUy/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JU1CNwcP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+hi5KkER; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:34:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765834487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJb76cNvU0eyb8/0QKzIA0K5JSGm5w3Wk4Qkx4Jsj0=;
	b=JU1CNwcPcuWKGd7vZs6pkU+UWuv7/ERFX3ybdAd+mlkK/XfWrptkrVAYA5S6atQ1Vu6LMj
	gyd3NSR8ILfsJrVnstAb9a0SFHYqg1gqoMcfV9QQrQavX0T4zhQAHM1e87DH8wK0Xrvfqn
	uCsw17D9Ph0RK5of+Glm9n+EEHyCkdTg6rO6zRjE6bYsHvPHRwwsOSgkGW+pnXZIu+fNDG
	FDm0oMzMPQdn3MjAmRDSedU/aRCmmFXmHLXLnXYnIPJntLZR1AHdR8cF11rspTLI++F/nV
	YN//4/SCS41eFfIP0/Rv7OVRnoC5ae/1/C4hROX5cn41NNvMaXK22DuTieIlFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765834487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCJb76cNvU0eyb8/0QKzIA0K5JSGm5w3Wk4Qkx4Jsj0=;
	b=+hi5KkERJnELUI+IZ91zdIVe+VysfF6tu/Sj3IjEq5+MMtrr6vmCsIEV3WbdbfpgokKh/r
	i0F5hzGl4fjUljDA==
From: "tip-bot2 for Radu Rendec" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq: Add interrupt redirection infrastructure
Cc: Thomas Gleixner <tglx@linutronix.de>, Radu Rendec <rrendec@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251128212055.1409093-2-rrendec@redhat.com>
References: <20251128212055.1409093-2-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583448622.510.8501133506462144391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     fcc1d0dabdb65ca069f77e5b76d3b20277be4a15
Gitweb:        https://git.kernel.org/tip/fcc1d0dabdb65ca069f77e5b76d3b20277b=
e4a15
Author:        Radu Rendec <rrendec@redhat.com>
AuthorDate:    Fri, 28 Nov 2025 16:20:53 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:30:48 +01:00

genirq: Add interrupt redirection infrastructure

Add infrastructure to redirect interrupt handler execution to a
different CPU when the current CPU is not part of the interrupt's CPU
affinity mask.

This is primarily aimed at (de)multiplexed interrupts, where the child
interrupt handler runs in the context of the parent interrupt handler,
and therefore CPU affinity control for the child interrupt is typically
not available.

With the new infrastructure, the child interrupt is allowed to freely
change its affinity setting, independently of the parent. If the
interrupt handler happens to be triggered on an "incompatible" CPU (a
CPU that's not part of the child interrupt's affinity mask), the handler
is redirected and runs in IRQ work context on a "compatible" CPU.

No functional change is being made to any existing irqchip driver, and
irqchip drivers must be explicitly modified to use the newly added
infrastructure to support interrupt redirection.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Radu Rendec <rrendec@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
Link: https://patch.msgid.link/20251128212055.1409093-2-rrendec@redhat.com
---
 include/linux/irq.h     | 10 +++++-
 include/linux/irqdesc.h | 17 +++++++-
 kernel/irq/chip.c       | 22 +++++++++-
 kernel/irq/irqdesc.c    | 86 +++++++++++++++++++++++++++++++++++++++-
 kernel/irq/manage.c     | 15 ++++++-
 5 files changed, 144 insertions(+), 6 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 4a9f1d7..41d5bc5 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -459,6 +459,8 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_da=
ta *d)
  *			checks against the supplied affinity mask are not
  *			required. This is used for CPU hotplug where the
  *			target CPU is not yet set in the cpu_online_mask.
+ * @irq_pre_redirect:	Optional function to be invoked before redirecting
+ *			an interrupt via irq_work. Called only on CONFIG_SMP.
  * @irq_retrigger:	resend an IRQ to the CPU
  * @irq_set_type:	set the flow type (IRQ_TYPE_LEVEL/etc.) of an IRQ
  * @irq_set_wake:	enable/disable power-management wake-on of an IRQ
@@ -503,6 +505,7 @@ struct irq_chip {
 	void		(*irq_eoi)(struct irq_data *data);
=20
 	int		(*irq_set_affinity)(struct irq_data *data, const struct cpumask *dest,=
 bool force);
+	void		(*irq_pre_redirect)(struct irq_data *data);
 	int		(*irq_retrigger)(struct irq_data *data);
 	int		(*irq_set_type)(struct irq_data *data, unsigned int flow_type);
 	int		(*irq_set_wake)(struct irq_data *data, unsigned int on);
@@ -687,6 +690,13 @@ extern int irq_chip_set_vcpu_affinity_parent(struct irq_=
data *data,
 extern int irq_chip_set_type_parent(struct irq_data *data, unsigned int type=
);
 extern int irq_chip_request_resources_parent(struct irq_data *data);
 extern void irq_chip_release_resources_parent(struct irq_data *data);
+#ifdef CONFIG_SMP
+void irq_chip_pre_redirect_parent(struct irq_data *data);
+#endif
+#endif
+
+#ifdef CONFIG_SMP
+int irq_chip_redirect_set_affinity(struct irq_data *data, const struct cpuma=
sk *dest, bool force);
 #endif
=20
 /* Disable or mask interrupts during a kernel kexec */
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 1790286..dae9a9b 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -2,9 +2,10 @@
 #ifndef _LINUX_IRQDESC_H
 #define _LINUX_IRQDESC_H
=20
-#include <linux/rcupdate.h>
+#include <linux/irq_work.h>
 #include <linux/kobject.h>
 #include <linux/mutex.h>
+#include <linux/rcupdate.h>
=20
 /*
  * Core internal functions to deal with irq descriptors
@@ -30,6 +31,17 @@ struct irqstat {
 };
=20
 /**
+ * struct irq_redirect - interrupt redirection metadata
+ * @work:	Harg irq_work item for handler execution on a different CPU
+ * @target_cpu:	CPU to run irq handler on in case the current CPU is not part
+ *		of the irq affinity mask
+ */
+struct irq_redirect {
+	struct irq_work	work;
+	unsigned int	target_cpu;
+};
+
+/**
  * struct irq_desc - interrupt descriptor
  * @irq_common_data:	per irq and chip data passed down to chip functions
  * @kstat_irqs:		irq stats per cpu
@@ -46,6 +58,7 @@ struct irqstat {
  * @threads_handled:	stats field for deferred spurious detection of threaded=
 handlers
  * @threads_handled_last: comparator field for deferred spurious detection o=
f threaded handlers
  * @lock:		locking for SMP
+ * @redirect:		Facility for redirecting interrupts via irq_work
  * @affinity_hint:	hint to user space for preferred irq affinity
  * @affinity_notify:	context for notification of affinity changes
  * @pending_mask:	pending rebalanced interrupts
@@ -83,6 +96,7 @@ struct irq_desc {
 	raw_spinlock_t		lock;
 	struct cpumask		*percpu_enabled;
 #ifdef CONFIG_SMP
+	struct irq_redirect	redirect;
 	const struct cpumask	*affinity_hint;
 	struct irq_affinity_notify *affinity_notify;
 #ifdef CONFIG_GENERIC_PENDING_IRQ
@@ -185,6 +199,7 @@ int generic_handle_irq_safe(unsigned int irq);
 int generic_handle_domain_irq(struct irq_domain *domain, irq_hw_number_t hwi=
rq);
 int generic_handle_domain_irq_safe(struct irq_domain *domain, irq_hw_number_=
t hwirq);
 int generic_handle_domain_nmi(struct irq_domain *domain, irq_hw_number_t hwi=
rq);
+bool generic_handle_demux_domain_irq(struct irq_domain *domain, irq_hw_numbe=
r_t hwirq);
 #endif
=20
 /* Test to see if a driver has successfully requested an irq */
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 678f094..433f1dd 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1122,7 +1122,7 @@ void irq_cpu_offline(void)
 }
 #endif
=20
-#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
=20
 #ifdef CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS
 /**
@@ -1194,6 +1194,15 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_mask_irq);
=20
 #endif /* CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS */
=20
+#ifdef CONFIG_SMP
+void irq_chip_pre_redirect_parent(struct irq_data *data)
+{
+	data =3D data->parent_data;
+	data->chip->irq_pre_redirect(data);
+}
+EXPORT_SYMBOL_GPL(irq_chip_pre_redirect_parent);
+#endif
+
 /**
  * irq_chip_set_parent_state - set the state of a parent interrupt.
  *
@@ -1476,6 +1485,17 @@ void irq_chip_release_resources_parent(struct irq_data=
 *data)
 		data->chip->irq_release_resources(data);
 }
 EXPORT_SYMBOL_GPL(irq_chip_release_resources_parent);
+#endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
+
+#ifdef CONFIG_SMP
+int irq_chip_redirect_set_affinity(struct irq_data *data, const struct cpuma=
sk *dest, bool force)
+{
+	struct irq_redirect *redir =3D &irq_data_to_desc(data)->redirect;
+
+	WRITE_ONCE(redir->target_cpu, cpumask_first(dest));
+	return IRQ_SET_MASK_OK;
+}
+EXPORT_SYMBOL_GPL(irq_chip_redirect_set_affinity);
 #endif
=20
 /**
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f8e4e13..501a653 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -78,8 +78,12 @@ static int alloc_masks(struct irq_desc *desc, int node)
 	return 0;
 }
=20
-static void desc_smp_init(struct irq_desc *desc, int node,
-			  const struct cpumask *affinity)
+static void irq_redirect_work(struct irq_work *work)
+{
+	handle_irq_desc(container_of(work, struct irq_desc, redirect.work));
+}
+
+static void desc_smp_init(struct irq_desc *desc, int node, const struct cpum=
ask *affinity)
 {
 	if (!affinity)
 		affinity =3D irq_default_affinity;
@@ -91,6 +95,7 @@ static void desc_smp_init(struct irq_desc *desc, int node,
 #ifdef CONFIG_NUMA
 	desc->irq_common_data.node =3D node;
 #endif
+	desc->redirect.work =3D IRQ_WORK_INIT_HARD(irq_redirect_work);
 }
=20
 static void free_masks(struct irq_desc *desc)
@@ -766,6 +771,83 @@ int generic_handle_domain_nmi(struct irq_domain *domain,=
 irq_hw_number_t hwirq)
 	WARN_ON_ONCE(!in_nmi());
 	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
 }
+
+#ifdef CONFIG_SMP
+static bool demux_redirect_remote(struct irq_desc *desc)
+{
+	guard(raw_spinlock)(&desc->lock);
+	const struct cpumask *m =3D irq_data_get_effective_affinity_mask(&desc->irq=
_data);
+	unsigned int target_cpu =3D READ_ONCE(desc->redirect.target_cpu);
+
+	if (desc->irq_data.chip->irq_pre_redirect)
+		desc->irq_data.chip->irq_pre_redirect(&desc->irq_data);
+
+	/*
+	 * If the interrupt handler is already running on a CPU that's included
+	 * in the interrupt's affinity mask, redirection is not necessary.
+	 */
+	if (cpumask_test_cpu(smp_processor_id(), m))
+		return false;
+
+	/*
+	 * The desc->action check protects against IRQ shutdown: __free_irq() sets
+	 * desc->action to NULL while holding desc->lock, which we also hold.
+	 *
+	 * Calling irq_work_queue_on() here is safe w.r.t. CPU unplugging:
+	 *   - takedown_cpu() schedules multi_cpu_stop() on all active CPUs,
+	 *     including the one that's taken down.
+	 *   - multi_cpu_stop() acts like a barrier, which means all active
+	 *     CPUs go through MULTI_STOP_DISABLE_IRQ and disable hard IRQs
+	 *     *before* the dying CPU runs take_cpu_down() in MULTI_STOP_RUN.
+	 *   - Hard IRQs are re-enabled at the end of multi_cpu_stop(), *after*
+	 *     the dying CPU has run take_cpu_down() in MULTI_STOP_RUN.
+	 *   - Since we run in hard IRQ context, we run either before or after
+	 *     take_cpu_down() but never concurrently.
+	 *   - If we run before take_cpu_down(), the dying CPU hasn't been marked
+	 *     offline yet (it's marked via take_cpu_down() -> __cpu_disable()),
+	 *     so the WARN in irq_work_queue_on() can't occur.
+	 *   - Furthermore, the work item we queue will be flushed later via
+	 *     take_cpu_down() -> cpuhp_invoke_callback_range_nofail() ->
+	 *     smpcfd_dying_cpu() -> irq_work_run().
+	 *   - If we run after take_cpu_down(), target_cpu has been already
+	 *     updated via take_cpu_down() -> __cpu_disable(), which eventually
+	 *     calls irq_do_set_affinity() during IRQ migration. So, target_cpu
+	 *     no longer points to the dying CPU in this case.
+	 */
+	if (desc->action)
+		irq_work_queue_on(&desc->redirect.work, target_cpu);
+
+	return true;
+}
+#else /* CONFIG_SMP */
+static bool demux_redirect_remote(struct irq_desc *desc)
+{
+	return false;
+}
+#endif
+
+/**
+ * generic_handle_demux_domain_irq - Invoke the handler for a hardware inter=
rupt
+ *				     of a demultiplexing domain.
+ * @domain:	The domain where to perform the lookup
+ * @hwirq:	The hardware interrupt number to convert to a logical one
+ *
+ * Returns:	True on success, or false if lookup has failed
+ */
+bool generic_handle_demux_domain_irq(struct irq_domain *domain, irq_hw_numbe=
r_t hwirq)
+{
+	struct irq_desc *desc =3D irq_resolve_mapping(domain, hwirq);
+
+	if (unlikely(!desc))
+		return false;
+
+	if (demux_redirect_remote(desc))
+		return true;
+
+	return !handle_irq_desc(desc);
+}
+EXPORT_SYMBOL_GPL(generic_handle_demux_domain_irq);
+
 #endif
=20
 /* Dynamic interrupt handling */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8b1b4c8..acb4c3d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -35,6 +35,16 @@ static int __init setup_forced_irqthreads(char *arg)
 early_param("threadirqs", setup_forced_irqthreads);
 #endif
=20
+#ifdef CONFIG_SMP
+static inline void synchronize_irqwork(struct irq_desc *desc)
+{
+	/* Synchronize pending or on the fly redirect work */
+	irq_work_sync(&desc->redirect.work);
+}
+#else
+static inline void synchronize_irqwork(struct irq_desc *desc) { }
+#endif
+
 static int __irq_get_irqchip_state(struct irq_data *d, enum irqchip_irq_stat=
e which, bool *state);
=20
 static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
@@ -107,7 +117,9 @@ EXPORT_SYMBOL(synchronize_hardirq);
=20
 static void __synchronize_irq(struct irq_desc *desc)
 {
+	synchronize_irqwork(desc);
 	__synchronize_hardirq(desc, true);
+
 	/*
 	 * We made sure that no hardirq handler is running. Now verify that no
 	 * threaded handlers are active.
@@ -217,8 +229,7 @@ static inline void irq_validate_effective_affinity(struct=
 irq_data *data) { }
=20
 static DEFINE_PER_CPU(struct cpumask, __tmp_mask);
=20
-int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
-			bool force)
+int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask, b=
ool force)
 {
 	struct cpumask *tmp_mask =3D this_cpu_ptr(&__tmp_mask);
 	struct irq_desc *desc =3D irq_data_to_desc(data);


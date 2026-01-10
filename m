Return-Path: <linux-tip-commits+bounces-7857-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE16D0DC5B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07E073027268
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB52D8771;
	Sat, 10 Jan 2026 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zi7IIIcK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Po9WlgcS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0129A322;
	Sat, 10 Jan 2026 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074382; cv=none; b=rinoWCg+adfI2GhjLt+6OYKVWNTKmWMDd3IBo002HrP6Rob7JvzGGCValN8iI2YgglWitCXEDJtAJ9ikZdg2HezZHL86x46N3bdCAlm/Oj7q4q81LXngR+WZwKyFNamlbDmH3tGnMylByqWvyR9dLG3mvD81S/rtULao4tuDhpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074382; c=relaxed/simple;
	bh=8h0n1j8eYAS/1kyaOmhDMXGhnqA8bA24sgtf3QLbwMA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=iKTbb4jQynK+FVuO3hLYzc9A/dUduLImprfWqwQYKsrKACp7eScm7AuW/iyCXMuBfw5EMNC8A3BTf8MTAhDIQmqL+vFhOKY0VsPZ4DfgUmNrI0nCWDg13difXRrA4P+jAup2s1lD/OQFCRZfFNYCMvQAQZhx/GfEatNXKSrZucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zi7IIIcK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Po9WlgcS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074370;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0fHU1C+Q6fr0Oby0kwmEoIOsnE2x5Cx4KnY9axF2BUI=;
	b=zi7IIIcKnAOCF6QMghfsQvGYcd2afM6cLsL0ZBIV5IL7Ydx0Cobu7zw7bcilQCKhVsCg5U
	RA5X8Q5GKBCtvg9GvQyxNMVzbuG5kciZ/ATlNOOE3Ml4WdfZNofjt3CkSsm6RNzehzO+mo
	sI1YfpYn33c69CISxhiIRRm+YV30qWlXxaqMksSzJTfXnG9LoQwgx4u1Cts3s7Jb9ZXr/E
	etIZ7srIq2hpNYAfZ3NmplQ7+SGwkRsjEhwiO/sKvviTDNmS3jvVQU5XvHyYdvcGkqH2Di
	oXzfcbuYs98Lco+2HvvOrY+qhnt8ayYP6558DVFqR54tUp1r9hWslDRYDA4cIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074370;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0fHU1C+Q6fr0Oby0kwmEoIOsnE2x5Cx4KnY9axF2BUI=;
	b=Po9WlgcS1ddklocBSXIj0JNja/tCi8NeS9jOnAuLFRuTtgkU/hYC4zfEK6EtAG21X6mqNw
	qyBsi0aBcnuWsLAQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86,fs/resctrl: Support binary fixed point event counters
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807436938.510.9957444787817190746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e37c9a3dc9f9645532780d5ef34ea3b8fcf9ddef
Gitweb:        https://git.kernel.org/tip/e37c9a3dc9f9645532780d5ef34ea3b8fcf=
9ddef
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:59 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jan 2026 16:10:41 +01:00

x86,fs/resctrl: Support binary fixed point event counters

resctrl assumes that all monitor events can be displayed as unsigned decimal
integers.

Hardware architecture counters may provide some telemetry events with greater
precision where the event is not a simple count, but is a measurement of some
sort (e.g. Joules for energy consumed).

Add a new argument to resctrl_enable_mon_event() for architecture code to
inform the file system that the value for a counter is a fixed-point value
with a specific number of binary places.

Only allow architecture to use floating point format on events that the file
system has marked with mon_evt::is_floating_point which reflects the contract
with user space on how the event values are displayed.

Display fixed point values with values rounded to ceil(binary_bits * log10(2))
decimal places. Special case for zero binary bits to print "{value}.0".

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c |  6 +-
 fs/resctrl/ctrlmondata.c           | 74 +++++++++++++++++++++++++++++-
 fs/resctrl/internal.h              |  8 +++-
 fs/resctrl/monitor.c               | 10 +++-
 include/linux/resctrl.h            |  3 +-
 5 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index bd4a981..9222eee 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -902,15 +902,15 @@ static __init bool get_rdt_mon_resources(void)
 	bool ret =3D false;
=20
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
-		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID, false);
+		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID, false, 0);
 		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
-		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID, false);
+		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID, false, 0);
 		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
-		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID, false);
+		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID, false, 0);
 		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_ABMC))
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 2c69fcd..f319fd1 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -17,6 +17,7 @@
=20
 #include <linux/cpu.h>
 #include <linux/kernfs.h>
+#include <linux/math.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/tick.h>
@@ -601,6 +602,77 @@ out_ctx_free:
 		resctrl_arch_mon_ctx_free(r, evt->evtid, rr->arch_mon_ctx);
 }
=20
+/*
+ * Decimal place precision to use for each number of fixed-point
+ * binary bits computed from ceil(binary_bits * log10(2)) except
+ * binary_bits =3D=3D 0 which will print "value.0"
+ */
+static const unsigned int decplaces[MAX_BINARY_BITS + 1] =3D {
+	[0]  =3D  1,
+	[1]  =3D  1,
+	[2]  =3D  1,
+	[3]  =3D  1,
+	[4]  =3D  2,
+	[5]  =3D  2,
+	[6]  =3D  2,
+	[7]  =3D  3,
+	[8]  =3D  3,
+	[9]  =3D  3,
+	[10] =3D  4,
+	[11] =3D  4,
+	[12] =3D  4,
+	[13] =3D  4,
+	[14] =3D  5,
+	[15] =3D  5,
+	[16] =3D  5,
+	[17] =3D  6,
+	[18] =3D  6,
+	[19] =3D  6,
+	[20] =3D  7,
+	[21] =3D  7,
+	[22] =3D  7,
+	[23] =3D  7,
+	[24] =3D  8,
+	[25] =3D  8,
+	[26] =3D  8,
+	[27] =3D  9
+};
+
+static void print_event_value(struct seq_file *m, unsigned int binary_bits, =
u64 val)
+{
+	unsigned long long frac =3D 0;
+
+	if (binary_bits) {
+		/* Mask off the integer part of the fixed-point value. */
+		frac =3D val & GENMASK_ULL(binary_bits - 1, 0);
+
+		/*
+		 * Multiply by 10^{desired decimal places}. The integer part of
+		 * the fixed point value is now almost what is needed.
+		 */
+		frac *=3D int_pow(10ull, decplaces[binary_bits]);
+
+		/*
+		 * Round to nearest by adding a value that would be a "1" in the
+		 * binary_bits + 1 place.  Integer part of fixed point value is
+		 * now the needed value.
+		 */
+		frac +=3D 1ull << (binary_bits - 1);
+
+		/*
+		 * Extract the integer part of the value. This is the decimal
+		 * representation of the original fixed-point fractional value.
+		 */
+		frac >>=3D binary_bits;
+	}
+
+	/*
+	 * "frac" is now in the range [0 .. 10^decplaces).  I.e. string
+	 * representation will fit into chosen number of decimal places.
+	 */
+	seq_printf(m, "%llu.%0*llu\n", val >> binary_bits, decplaces[binary_bits], =
frac);
+}
+
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of =3D m->private;
@@ -678,6 +750,8 @@ checkresult:
 		seq_puts(m, "Unavailable\n");
 	else if (rr.err =3D=3D -ENOENT)
 		seq_puts(m, "Unassigned\n");
+	else if (evt->is_floating_point)
+		print_event_value(m, evt->binary_bits, rr.val);
 	else
 		seq_printf(m, "%llu\n", rr.val);
=20
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index fb0b6e4..14e5a9e 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -62,6 +62,9 @@ static inline struct rdt_fs_context *rdt_fc2context(struct =
fs_context *fc)
  *			Only valid if @evtid is an MBM event.
  * @configurable:	true if the event is configurable
  * @any_cpu:		true if the event can be read from any CPU
+ * @is_floating_point:	event values are displayed in floating point format
+ * @binary_bits:	number of fixed-point binary bits from architecture,
+ *			only valid if @is_floating_point is true
  * @enabled:		true if the event is enabled
  */
 struct mon_evt {
@@ -71,6 +74,8 @@ struct mon_evt {
 	u32			evt_cfg;
 	bool			configurable;
 	bool			any_cpu;
+	bool			is_floating_point;
+	unsigned int		binary_bits;
 	bool			enabled;
 };
=20
@@ -79,6 +84,9 @@ extern struct mon_evt mon_event_all[QOS_NUM_EVENTS];
 #define for_each_mon_event(mevt) for (mevt =3D &mon_event_all[QOS_FIRST_EVEN=
T];	\
 				      mevt < &mon_event_all[QOS_NUM_EVENTS]; mevt++)
=20
+/* Limit for mon_evt::binary_bits */
+#define MAX_BINARY_BITS	27
+
 /**
  * struct mon_data - Monitoring details for each event file.
  * @list:            Member of the global @mon_data_kn_priv_list list.
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 8c76ac1..844cf68 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -988,16 +988,22 @@ struct mon_evt mon_event_all[QOS_NUM_EVENTS] =3D {
 	},
 };
=20
-void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu)
+void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu, u=
nsigned int binary_bits)
 {
-	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >=3D QOS_NUM_EVENTS))
+	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >=3D QOS_NUM_EVENTS ||
+			 binary_bits > MAX_BINARY_BITS))
 		return;
 	if (mon_event_all[eventid].enabled) {
 		pr_warn("Duplicate enable for event %d\n", eventid);
 		return;
 	}
+	if (binary_bits && !mon_event_all[eventid].is_floating_point) {
+		pr_warn("Event %d may not be floating point\n", eventid);
+		return;
+	}
=20
 	mon_event_all[eventid].any_cpu =3D any_cpu;
+	mon_event_all[eventid].binary_bits =3D binary_bits;
 	mon_event_all[eventid].enabled =3D true;
 }
=20
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 22c5d07..c43526c 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -412,7 +412,8 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
=20
-void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu);
+void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu,
+			      unsigned int binary_bits);
=20
 bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid);
=20


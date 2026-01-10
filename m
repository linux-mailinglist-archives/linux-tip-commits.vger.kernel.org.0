Return-Path: <linux-tip-commits+bounces-7858-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF278D0DC7C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6309A302695A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6793228489B;
	Sat, 10 Jan 2026 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nXHbT7MV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Zc4hyz4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CEB2ED84C;
	Sat, 10 Jan 2026 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074386; cv=none; b=dcBtAhEKosrbBd2Ct7rdI7m/fgwdo+ikBNfjgW371jZRDnpobfRRyONSws3ru0iAjBRo2HZeOfoRsGqmNHC1d7OBGfNQ0OhdYEwoVY2RiA64qaBAn/rvA7Y2u492f8m76UxE/qpPTp54XFcNQRn7q6PdpU0smC2EYFJpsE3LEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074386; c=relaxed/simple;
	bh=PiWljwT/jblubZYQyngSSiTPLDk5KG2a11Fbwex+pFQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QLP1aiHr7/a0nyg82mL/Ap95ui+3BTT6vvWy8jb/v2mx3VZsrILkcjBO3PRHS5M1dPjXllQ7+daC5nkHYFJKEx/wG9y8KcXM48f1PxVDHu+jWFOyMwU7uReD7qcjAPsEExlSdKFL8ksg3HirvFpkSJrptzMNculT0Z+9ZQtNZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nXHbT7MV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Zc4hyz4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xyQWJpZHL3pp2vtQ5JijAGCYgdYQk90Qjp5MoN7jqp4=;
	b=nXHbT7MVWnDTwUVtvecMaxfnV6Sw1p7I5qlW34zGSUGVR1DtAZ2ex9XbbwxJyA3ezptFFM
	9MytQb1YamM0pkXN1639ek2ACachKiNi+4KnE/LNdZryly9y0friQez77JdjAEVWI2SBSL
	ekCas/VA/vdSKnzvd6DTV01X89gowtKZQHfJ766kIsKN6PGVCtt5ImbMK/DWrcmJajGF7y
	8Rrru1o/XvAavjULSwZrNvDmcIF8juFpmmN456dUmKMoJjPjWFCv2Ixp1xezTUAXm8c1y7
	RAmJVx2mEQHSCtHTw0YQd7ogDamWBHqa65gpKTzI8m/vdR/uKf+mNwxi2EPwYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xyQWJpZHL3pp2vtQ5JijAGCYgdYQk90Qjp5MoN7jqp4=;
	b=+Zc4hyz4YvDHfYKxEsGtacuZgKj63RguaQrLmauCDeD90gNLpXJTFzde/g8rCvprobFXZ7
	v8WA6DPKpscXagAQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Rename struct rdt_mon_domain and
 rdt_hw_mon_domain
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807437378.510.6928673368878723055.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     4bc3ef46ff41d5e7ba557e56e9cd2031527cd7f8
Gitweb:        https://git.kernel.org/tip/4bc3ef46ff41d5e7ba557e56e9cd2031527=
cd7f8
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:55 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jan 2026 11:17:25 +01:00

x86,fs/resctrl: Rename struct rdt_mon_domain and rdt_hw_mon_domain

The upcoming telemetry event monitoring is not tied to the L3 resource and
will have a new domain structure.

Rename the L3 resource specific domain data structures to include "l3_"
in their names to avoid confusion between the different resource specific
domain structures:
rdt_mon_domain		-> rdt_l3_mon_domain
rdt_hw_mon_domain	-> rdt_hw_l3_mon_domain

No functional change.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 14 ++---
 arch/x86/kernel/cpu/resctrl/internal.h | 16 +++---
 arch/x86/kernel/cpu/resctrl/monitor.c  | 36 ++++++-------
 fs/resctrl/ctrlmondata.c               |  2 +-
 fs/resctrl/internal.h                  |  8 +--
 fs/resctrl/monitor.c                   | 70 ++++++++++++-------------
 fs/resctrl/rdtgroup.c                  | 40 +++++++-------
 include/linux/resctrl.h                | 22 ++++----
 8 files changed, 104 insertions(+), 104 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 1fab4c6..cc1b846 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -368,7 +368,7 @@ static void ctrl_domain_free(struct rdt_hw_ctrl_domain *h=
w_dom)
 	kfree(hw_dom);
 }
=20
-static void mon_domain_free(struct rdt_hw_mon_domain *hw_dom)
+static void mon_domain_free(struct rdt_hw_l3_mon_domain *hw_dom)
 {
 	int idx;
=20
@@ -405,7 +405,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, s=
truct rdt_ctrl_domain *
  * @num_rmid:	The size of the MBM counter array
  * @hw_dom:	The domain that owns the allocated arrays
  */
-static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_mon_domain *hw_=
dom)
+static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_l3_mon_domain *=
hw_dom)
 {
 	size_t tsize =3D sizeof(*hw_dom->arch_mbm_states[0]);
 	enum resctrl_event_id eventid;
@@ -503,8 +503,8 @@ static void domain_add_cpu_ctrl(int cpu, struct rdt_resou=
rce *r)
=20
 static void l3_mon_domain_setup(int cpu, int id, struct rdt_resource *r, str=
uct list_head *add_pos)
 {
-	struct rdt_hw_mon_domain *hw_dom;
-	struct rdt_mon_domain *d;
+	struct rdt_hw_l3_mon_domain *hw_dom;
+	struct rdt_l3_mon_domain *d;
 	struct cacheinfo *ci;
 	int err;
=20
@@ -653,13 +653,13 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_r=
esource *r)
=20
 	switch (r->rid) {
 	case RDT_RESOURCE_L3: {
-		struct rdt_hw_mon_domain *hw_dom;
-		struct rdt_mon_domain *d;
+		struct rdt_hw_l3_mon_domain *hw_dom;
+		struct rdt_l3_mon_domain *d;
=20
 		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 			return;
=20
-		d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+		d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
 		hw_dom =3D resctrl_to_arch_mon_dom(d);
 		resctrl_offline_mon_domain(r, hdr);
 		list_del_rcu(&hdr->list);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index 4a916c8..d73c0ad 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -63,17 +63,17 @@ struct rdt_hw_ctrl_domain {
 };
=20
 /**
- * struct rdt_hw_mon_domain - Arch private attributes of a set of CPUs that =
share
- *			      a resource for a monitor function
- * @d_resctrl:	Properties exposed to the resctrl file system
+ * struct rdt_hw_l3_mon_domain - Arch private attributes of a set of CPUs sh=
aring
+ *				 RDT_RESOURCE_L3 monitoring
+ * @d_resctrl:		Properties exposed to the resctrl file system
  * @arch_mbm_states:	Per-event pointer to the MBM event's saved state.
  *			An MBM event's state is an array of struct arch_mbm_state
  *			indexed by RMID on x86.
  *
  * Members of this structure are accessed via helpers that provide abstracti=
on.
  */
-struct rdt_hw_mon_domain {
-	struct rdt_mon_domain		d_resctrl;
+struct rdt_hw_l3_mon_domain {
+	struct rdt_l3_mon_domain	d_resctrl;
 	struct arch_mbm_state		*arch_mbm_states[QOS_NUM_L3_MBM_EVENTS];
 };
=20
@@ -82,9 +82,9 @@ static inline struct rdt_hw_ctrl_domain *resctrl_to_arch_ct=
rl_dom(struct rdt_ctr
 	return container_of(r, struct rdt_hw_ctrl_domain, d_resctrl);
 }
=20
-static inline struct rdt_hw_mon_domain *resctrl_to_arch_mon_dom(struct rdt_m=
on_domain *r)
+static inline struct rdt_hw_l3_mon_domain *resctrl_to_arch_mon_dom(struct rd=
t_l3_mon_domain *r)
 {
-	return container_of(r, struct rdt_hw_mon_domain, d_resctrl);
+	return container_of(r, struct rdt_hw_l3_mon_domain, d_resctrl);
 }
=20
 /**
@@ -140,7 +140,7 @@ static inline struct rdt_hw_resource *resctrl_to_arch_res=
(struct rdt_resource *r
=20
 extern struct rdt_hw_resource rdt_resources_all[];
=20
-void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d=
);
+void arch_mon_domain_online(struct rdt_resource *r, struct rdt_l3_mon_domain=
 *d);
=20
 /* CPUID.(EAX=3D10H, ECX=3DResID=3D1).EAX */
 union cpuid_0x10_1_eax {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 3da970e..04b8f1e 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -109,7 +109,7 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsig=
ned long val)
  *
  * In RMID sharing mode there are fewer "logical RMID" values available
  * to accumulate data ("physical RMIDs" are divided evenly between SNC
- * nodes that share an L3 cache). Linux creates an rdt_mon_domain for
+ * nodes that share an L3 cache). Linux creates an rdt_l3_mon_domain for
  * each SNC node.
  *
  * The value loaded into IA32_PQR_ASSOC is the "logical RMID".
@@ -157,7 +157,7 @@ static int __rmid_read_phys(u32 prmid, enum resctrl_event=
_id eventid, u64 *val)
 	return 0;
 }
=20
-static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_mon_domain *h=
w_dom,
+static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_l3_mon_domain=
 *hw_dom,
 						 u32 rmid,
 						 enum resctrl_event_id eventid)
 {
@@ -171,11 +171,11 @@ static struct arch_mbm_state *get_arch_mbm_state(struct=
 rdt_hw_mon_domain *hw_do
 	return state ? &state[rmid] : NULL;
 }
=20
-void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *=
d,
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_domai=
n *d,
 			     u32 unused, u32 rmid,
 			     enum resctrl_event_id eventid)
 {
-	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
+	struct rdt_hw_l3_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
 	int cpu =3D cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
 	u32 prmid;
@@ -194,9 +194,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, stru=
ct rdt_mon_domain *d,
  * Assumes that hardware counters are also reset and thus that there is
  * no need to record initial non-zero counts.
  */
-void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_doma=
in *d)
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_d=
omain *d)
 {
-	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
+	struct rdt_hw_l3_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
 	enum resctrl_event_id eventid;
 	int idx;
=20
@@ -217,10 +217,10 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr=
, unsigned int width)
 	return chunks >> shift;
 }
=20
-static u64 get_corrected_val(struct rdt_resource *r, struct rdt_mon_domain *=
d,
+static u64 get_corrected_val(struct rdt_resource *r, struct rdt_l3_mon_domai=
n *d,
 			     u32 rmid, enum resctrl_event_id eventid, u64 msr_val)
 {
-	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
+	struct rdt_hw_l3_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
 	struct arch_mbm_state *am;
 	u64 chunks;
@@ -242,9 +242,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct=
 rdt_domain_hdr *hdr,
 			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *ignored)
 {
-	struct rdt_hw_mon_domain *hw_dom;
+	struct rdt_hw_l3_mon_domain *hw_dom;
+	struct rdt_l3_mon_domain *d;
 	struct arch_mbm_state *am;
-	struct rdt_mon_domain *d;
 	u64 msr_val;
 	u32 prmid;
 	int cpu;
@@ -254,7 +254,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct=
 rdt_domain_hdr *hdr,
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return -EINVAL;
=20
-	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	hw_dom =3D resctrl_to_arch_mon_dom(d);
 	cpu =3D cpumask_any(&hdr->cpu_mask);
 	prmid =3D logical_rmid_to_physical_rmid(cpu, rmid);
@@ -308,11 +308,11 @@ static int __cntr_id_read(u32 cntr_id, u64 *val)
 	return 0;
 }
=20
-void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *=
d,
+void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_l3_mon_domai=
n *d,
 			     u32 unused, u32 rmid, int cntr_id,
 			     enum resctrl_event_id eventid)
 {
-	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
+	struct rdt_hw_l3_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
 	struct arch_mbm_state *am;
=20
 	am =3D get_arch_mbm_state(hw_dom, rmid, eventid);
@@ -324,7 +324,7 @@ void resctrl_arch_reset_cntr(struct rdt_resource *r, stru=
ct rdt_mon_domain *d,
 	}
 }
=20
-int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_l3_mon_domain =
*d,
 			   u32 unused, u32 rmid, int cntr_id,
 			   enum resctrl_event_id eventid, u64 *val)
 {
@@ -354,7 +354,7 @@ int resctrl_arch_cntr_read(struct rdt_resource *r, struct=
 rdt_mon_domain *d,
  * must adjust RMID counter numbers based on SNC node. See
  * logical_rmid_to_physical_rmid() for code that does this.
  */
-void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d)
+void arch_mon_domain_online(struct rdt_resource *r, struct rdt_l3_mon_domain=
 *d)
 {
 	if (snc_nodes_per_l3_cache > 1)
 		msr_clear_bit(MSR_RMID_SNC_CONFIG, 0);
@@ -516,7 +516,7 @@ static void resctrl_abmc_set_one_amd(void *arg)
  */
 static void _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
 {
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
=20
 	lockdep_assert_cpus_held();
=20
@@ -555,11 +555,11 @@ static void resctrl_abmc_config_one_amd(void *info)
 /*
  * Send an IPI to the domain to assign the counter to RMID, event pair.
  */
-void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain =
*d,
+void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_l3_mon_doma=
in *d,
 			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
 			      u32 cntr_id, bool assign)
 {
-	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
+	struct rdt_hw_l3_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
 	union l3_qos_abmc_cfg abmc_cfg =3D { 0 };
 	struct arch_mbm_state *am;
=20
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 9242a29..a3c734f 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -600,9 +600,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	struct kernfs_open_file *of =3D m->private;
 	enum resctrl_res_level resid;
 	enum resctrl_event_id evtid;
+	struct rdt_l3_mon_domain *d;
 	struct rdt_domain_hdr *hdr;
 	struct rmid_read rr =3D {0};
-	struct rdt_mon_domain *d;
 	struct rdtgroup *rdtgrp;
 	int domid, cpu, ret =3D 0;
 	struct rdt_resource *r;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 9912b77..af47b6d 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -369,7 +369,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_reso=
urce *r,
=20
 int resctrl_mon_resource_init(void);
=20
-void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
+void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
=20
@@ -377,14 +377,14 @@ void mbm_handle_overflow(struct work_struct *work);
=20
 bool is_mba_sc(struct rdt_resource *r);
=20
-void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay=
_ms,
+void cqm_setup_limbo_handler(struct rdt_l3_mon_domain *dom, unsigned long de=
lay_ms,
 			     int exclude_cpu);
=20
 void cqm_handle_limbo(struct work_struct *work);
=20
-bool has_busy_rmid(struct rdt_mon_domain *d);
+bool has_busy_rmid(struct rdt_l3_mon_domain *d);
=20
-void __check_limbo(struct rdt_mon_domain *d, bool force_free);
+void __check_limbo(struct rdt_l3_mon_domain *d, bool force_free);
=20
 void resctrl_file_fflags_init(const char *config, unsigned long fflags);
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index e1c1220..9edbe98 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -130,7 +130,7 @@ static void limbo_release_entry(struct rmid_entry *entry)
  * decrement the count. If the busy count gets to zero on an RMID, we
  * free the RMID
  */
-void __check_limbo(struct rdt_mon_domain *d, bool force_free)
+void __check_limbo(struct rdt_l3_mon_domain *d, bool force_free)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
@@ -188,7 +188,7 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_f=
ree)
 	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
 }
=20
-bool has_busy_rmid(struct rdt_mon_domain *d)
+bool has_busy_rmid(struct rdt_l3_mon_domain *d)
 {
 	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
=20
@@ -289,7 +289,7 @@ int alloc_rmid(u32 closid)
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	u32 idx;
=20
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -342,7 +342,7 @@ void free_rmid(u32 closid, u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
=20
-static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
+static struct mbm_state *get_mbm_state(struct rdt_l3_mon_domain *d, u32 clos=
id,
 				       u32 rmid, enum resctrl_event_id evtid)
 {
 	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
@@ -362,7 +362,7 @@ static struct mbm_state *get_mbm_state(struct rdt_mon_dom=
ain *d, u32 closid,
  * Return:
  * Valid counter ID on success, or -ENOENT on failure.
  */
-static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
+static int mbm_cntr_get(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
 			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
 {
 	int cntr_id;
@@ -389,7 +389,7 @@ static int mbm_cntr_get(struct rdt_resource *r, struct rd=
t_mon_domain *d,
  * Return:
  * Valid counter ID on success, or -ENOSPC on failure.
  */
-static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
+static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_l3_mon_domain *=
d,
 			  struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
 {
 	int cntr_id;
@@ -408,7 +408,7 @@ static int mbm_cntr_alloc(struct rdt_resource *r, struct =
rdt_mon_domain *d,
 /*
  * mbm_cntr_free() - Clear the counter ID configuration details in the domai=
n @d.
  */
-static void mbm_cntr_free(struct rdt_mon_domain *d, int cntr_id)
+static void mbm_cntr_free(struct rdt_l3_mon_domain *d, int cntr_id)
 {
 	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
 }
@@ -418,7 +418,7 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp, =
struct rmid_read *rr)
 	int cpu =3D smp_processor_id();
 	u32 closid =3D rdtgrp->closid;
 	u32 rmid =3D rdtgrp->mon.rmid;
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	int cntr_id =3D -ENOENT;
 	struct mbm_state *m;
 	u64 tval =3D 0;
@@ -427,7 +427,7 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp, =
struct rmid_read *rr)
 		rr->err =3D -EIO;
 		return -EINVAL;
 	}
-	d =3D container_of(rr->hdr, struct rdt_mon_domain, hdr);
+	d =3D container_of(rr->hdr, struct rdt_l3_mon_domain, hdr);
=20
 	if (rr->is_mbm_cntr) {
 		cntr_id =3D mbm_cntr_get(rr->r, d, rdtgrp, rr->evtid);
@@ -470,7 +470,7 @@ static int __l3_mon_event_count_sum(struct rdtgroup *rdtg=
rp, struct rmid_read *r
 	int cpu =3D smp_processor_id();
 	u32 closid =3D rdtgrp->closid;
 	u32 rmid =3D rdtgrp->mon.rmid;
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	u64 tval =3D 0;
 	int err, ret;
=20
@@ -545,12 +545,12 @@ static void mbm_bw_count(struct rdtgroup *rdtgrp, struc=
t rmid_read *rr)
 	u64 cur_bw, bytes, cur_bytes;
 	u32 closid =3D rdtgrp->closid;
 	u32 rmid =3D rdtgrp->mon.rmid;
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	struct mbm_state *m;
=20
 	if (!domain_header_is_valid(rr->hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return;
-	d =3D container_of(rr->hdr, struct rdt_mon_domain, hdr);
+	d =3D container_of(rr->hdr, struct rdt_l3_mon_domain, hdr);
 	m =3D get_mbm_state(d, closid, rmid, rr->evtid);
 	if (WARN_ON_ONCE(!m))
 		return;
@@ -650,7 +650,7 @@ static struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(i=
nt cpu,
  * throttle MSRs already have low percentage values.  To avoid
  * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
  */
-static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_=
mbm)
+static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_l3_mon_domain *d=
om_mbm)
 {
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
@@ -718,7 +718,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct r=
dt_mon_domain *dom_mbm)
 	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
 }
=20
-static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_doma=
in *d,
+static void mbm_update_one_event(struct rdt_resource *r, struct rdt_l3_mon_d=
omain *d,
 				 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
 {
 	struct rmid_read rr =3D {0};
@@ -750,7 +750,7 @@ static void mbm_update_one_event(struct rdt_resource *r, =
struct rdt_mon_domain *
 		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 }
=20
-static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
+static void mbm_update(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
 		       struct rdtgroup *rdtgrp)
 {
 	/*
@@ -771,12 +771,12 @@ static void mbm_update(struct rdt_resource *r, struct r=
dt_mon_domain *d,
 void cqm_handle_limbo(struct work_struct *work)
 {
 	unsigned long delay =3D msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
=20
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
=20
-	d =3D container_of(work, struct rdt_mon_domain, cqm_limbo.work);
+	d =3D container_of(work, struct rdt_l3_mon_domain, cqm_limbo.work);
=20
 	__check_limbo(d, false);
=20
@@ -799,7 +799,7 @@ void cqm_handle_limbo(struct work_struct *work)
  * @exclude_cpu:   Which CPU the handler should not run on,
  *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
  */
-void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay=
_ms,
+void cqm_setup_limbo_handler(struct rdt_l3_mon_domain *dom, unsigned long de=
lay_ms,
 			     int exclude_cpu)
 {
 	unsigned long delay =3D msecs_to_jiffies(delay_ms);
@@ -816,7 +816,7 @@ void mbm_handle_overflow(struct work_struct *work)
 {
 	unsigned long delay =3D msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
 	struct rdtgroup *prgrp, *crgrp;
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	struct list_head *head;
 	struct rdt_resource *r;
=20
@@ -831,7 +831,7 @@ void mbm_handle_overflow(struct work_struct *work)
 		goto out_unlock;
=20
 	r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	d =3D container_of(work, struct rdt_mon_domain, mbm_over.work);
+	d =3D container_of(work, struct rdt_l3_mon_domain, mbm_over.work);
=20
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mbm_update(r, d, prgrp);
@@ -865,7 +865,7 @@ out_unlock:
  * @exclude_cpu:   Which CPU the handler should not run on,
  *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
  */
-void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long de=
lay_ms,
+void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom, unsigned long=
 delay_ms,
 				int exclude_cpu)
 {
 	unsigned long delay =3D msecs_to_jiffies(delay_ms);
@@ -1120,7 +1120,7 @@ out_unlock:
  * mbm_cntr_free_all() - Clear all the counter ID configuration details in t=
he
  *			 domain @d. Called when mbm_assign_mode is changed.
  */
-static void mbm_cntr_free_all(struct rdt_resource *r, struct rdt_mon_domain =
*d)
+static void mbm_cntr_free_all(struct rdt_resource *r, struct rdt_l3_mon_doma=
in *d)
 {
 	memset(d->cntr_cfg, 0, sizeof(*d->cntr_cfg) * r->mon.num_mbm_cntrs);
 }
@@ -1129,7 +1129,7 @@ static void mbm_cntr_free_all(struct rdt_resource *r, s=
truct rdt_mon_domain *d)
  * resctrl_reset_rmid_all() - Reset all non-architecture states for all the
  *			      supported RMIDs.
  */
-static void resctrl_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_do=
main *d)
+static void resctrl_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon=
_domain *d)
 {
 	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
 	enum resctrl_event_id evt;
@@ -1150,7 +1150,7 @@ static void resctrl_reset_rmid_all(struct rdt_resource =
*r, struct rdt_mon_domain
  * Assign the counter if @assign is true else unassign the counter. Reset the
  * associated non-architectural state.
  */
-static void rdtgroup_assign_cntr(struct rdt_resource *r, struct rdt_mon_doma=
in *d,
+static void rdtgroup_assign_cntr(struct rdt_resource *r, struct rdt_l3_mon_d=
omain *d,
 				 enum resctrl_event_id evtid, u32 rmid, u32 closid,
 				 u32 cntr_id, bool assign)
 {
@@ -1170,7 +1170,7 @@ static void rdtgroup_assign_cntr(struct rdt_resource *r=
, struct rdt_mon_domain *
  * Return:
  * 0 on success, < 0 on failure.
  */
-static int rdtgroup_alloc_assign_cntr(struct rdt_resource *r, struct rdt_mon=
_domain *d,
+static int rdtgroup_alloc_assign_cntr(struct rdt_resource *r, struct rdt_l3_=
mon_domain *d,
 				      struct rdtgroup *rdtgrp, struct mon_evt *mevt)
 {
 	int cntr_id;
@@ -1205,7 +1205,7 @@ static int rdtgroup_alloc_assign_cntr(struct rdt_resour=
ce *r, struct rdt_mon_dom
  * Return:
  * 0 on success, < 0 on failure.
  */
-static int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgr=
oup *rdtgrp,
+static int rdtgroup_assign_cntr_event(struct rdt_l3_mon_domain *d, struct rd=
tgroup *rdtgrp,
 				      struct mon_evt *mevt)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(mevt->rid);
@@ -1255,7 +1255,7 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
  * rdtgroup_free_unassign_cntr() - Unassign and reset the counter ID configu=
ration
  * for the event pointed to by @mevt within the domain @d and resctrl group =
@rdtgrp.
  */
-static void rdtgroup_free_unassign_cntr(struct rdt_resource *r, struct rdt_m=
on_domain *d,
+static void rdtgroup_free_unassign_cntr(struct rdt_resource *r, struct rdt_l=
3_mon_domain *d,
 					struct rdtgroup *rdtgrp, struct mon_evt *mevt)
 {
 	int cntr_id;
@@ -1276,7 +1276,7 @@ static void rdtgroup_free_unassign_cntr(struct rdt_reso=
urce *r, struct rdt_mon_d
  * the event structure @mevt from the domain @d and the group @rdtgrp. Unass=
ign
  * the counters from all the domains if @d is NULL else unassign from @d.
  */
-static void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rd=
tgroup *rdtgrp,
+static void rdtgroup_unassign_cntr_event(struct rdt_l3_mon_domain *d, struct=
 rdtgroup *rdtgrp,
 					 struct mon_evt *mevt)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(mevt->rid);
@@ -1351,7 +1351,7 @@ next_config:
 static void rdtgroup_update_cntr_event(struct rdt_resource *r, struct rdtgro=
up *rdtgrp,
 				       enum resctrl_event_id evtid)
 {
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	int cntr_id;
=20
 	list_for_each_entry(d, &r->mon_domains, hdr.list) {
@@ -1457,7 +1457,7 @@ ssize_t resctrl_mbm_assign_mode_write(struct kernfs_ope=
n_file *of, char *buf,
 				      size_t nbytes, loff_t off)
 {
 	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	int ret =3D 0;
 	bool enable;
=20
@@ -1530,7 +1530,7 @@ int resctrl_num_mbm_cntrs_show(struct kernfs_open_file =
*of,
 			       struct seq_file *s, void *v)
 {
 	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
-	struct rdt_mon_domain *dom;
+	struct rdt_l3_mon_domain *dom;
 	bool sep =3D false;
=20
 	cpus_read_lock();
@@ -1554,7 +1554,7 @@ int resctrl_available_mbm_cntrs_show(struct kernfs_open=
_file *of,
 				     struct seq_file *s, void *v)
 {
 	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
-	struct rdt_mon_domain *dom;
+	struct rdt_l3_mon_domain *dom;
 	bool sep =3D false;
 	u32 cntrs, i;
 	int ret =3D 0;
@@ -1595,7 +1595,7 @@ out_unlock:
 int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s,=
 void *v)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	struct rdtgroup *rdtgrp;
 	struct mon_evt *mevt;
 	int ret =3D 0;
@@ -1658,7 +1658,7 @@ static struct mon_evt *mbm_get_mon_event_by_name(struct=
 rdt_resource *r, char *n
 	return NULL;
 }
=20
-static int rdtgroup_modify_assign_state(char *assign, struct rdt_mon_domain =
*d,
+static int rdtgroup_modify_assign_state(char *assign, struct rdt_l3_mon_doma=
in *d,
 					struct rdtgroup *rdtgrp, struct mon_evt *mevt)
 {
 	int ret =3D 0;
@@ -1684,7 +1684,7 @@ static int rdtgroup_modify_assign_state(char *assign, s=
truct rdt_mon_domain *d,
 static int resctrl_parse_mbm_assignment(struct rdt_resource *r, struct rdtgr=
oup *rdtgrp,
 					char *event, char *tok)
 {
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	unsigned long dom_id =3D 0;
 	char *dom_str, *id_str;
 	struct mon_evt *mevt;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 89ffe54..2ed435d 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1640,7 +1640,7 @@ static void mondata_config_read(struct resctrl_mon_conf=
ig_info *mon_info)
 static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 e=
vtid)
 {
 	struct resctrl_mon_config_info mon_info;
-	struct rdt_mon_domain *dom;
+	struct rdt_l3_mon_domain *dom;
 	bool sep =3D false;
=20
 	cpus_read_lock();
@@ -1688,7 +1688,7 @@ static int mbm_local_bytes_config_show(struct kernfs_op=
en_file *of,
 }
=20
 static void mbm_config_write_domain(struct rdt_resource *r,
-				    struct rdt_mon_domain *d, u32 evtid, u32 val)
+				    struct rdt_l3_mon_domain *d, u32 evtid, u32 val)
 {
 	struct resctrl_mon_config_info mon_info =3D {0};
=20
@@ -1729,8 +1729,8 @@ static void mbm_config_write_domain(struct rdt_resource=
 *r,
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 {
 	char *dom_str =3D NULL, *id_str;
+	struct rdt_l3_mon_domain *d;
 	unsigned long dom_id, val;
-	struct rdt_mon_domain *d;
=20
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
@@ -2781,7 +2781,7 @@ static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
 	unsigned long flags =3D RFTYPE_CTRL_BASE;
-	struct rdt_mon_domain *dom;
+	struct rdt_l3_mon_domain *dom;
 	struct rdt_resource *r;
 	int ret;
=20
@@ -3232,7 +3232,7 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_r=
esource *r,
 					   struct rdt_domain_hdr *hdr)
 {
 	struct rdtgroup *prgrp, *crgrp;
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	char subname[32];
 	bool snc_mode;
 	char name[32];
@@ -3240,7 +3240,7 @@ static void rmdir_mondata_subdir_allrdtgrp(struct rdt_r=
esource *r,
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return;
=20
-	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
 	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : hdr->id);
 	if (snc_mode)
@@ -3258,8 +3258,8 @@ static int mon_add_all_files(struct kernfs_node *kn, st=
ruct rdt_domain_hdr *hdr,
 			     struct rdt_resource *r, struct rdtgroup *prgrp,
 			     bool do_sum)
 {
+	struct rdt_l3_mon_domain *d;
 	struct rmid_read rr =3D {0};
-	struct rdt_mon_domain *d;
 	struct mon_data *priv;
 	struct mon_evt *mevt;
 	int ret, domid;
@@ -3267,7 +3267,7 @@ static int mon_add_all_files(struct kernfs_node *kn, st=
ruct rdt_domain_hdr *hdr,
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return -EINVAL;
=20
-	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	for_each_mon_event(mevt) {
 		if (mevt->rid !=3D r->rid || !mevt->enabled)
 			continue;
@@ -3292,7 +3292,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *par=
ent_kn,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
 	struct kernfs_node *kn, *ckn;
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	char name[32];
 	bool snc_mode;
 	int ret =3D 0;
@@ -3302,7 +3302,7 @@ static int mkdir_mondata_subdir(struct kernfs_node *par=
ent_kn,
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return -EINVAL;
=20
-	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
 	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci_id : d->hdr.id);
 	kn =3D kernfs_find_and_get(parent_kn, name);
@@ -4246,7 +4246,7 @@ static void rdtgroup_setup_default(void)
 	mutex_unlock(&rdtgroup_mutex);
 }
=20
-static void domain_destroy_mon_state(struct rdt_mon_domain *d)
+static void domain_destroy_mon_state(struct rdt_l3_mon_domain *d)
 {
 	int idx;
=20
@@ -4270,14 +4270,14 @@ void resctrl_offline_ctrl_domain(struct rdt_resource =
*r, struct rdt_ctrl_domain=20
=20
 void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain_hd=
r *hdr)
 {
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
=20
 	mutex_lock(&rdtgroup_mutex);
=20
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		goto out_unlock;
=20
-	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
=20
 	/*
 	 * If resctrl is mounted, remove all the
@@ -4319,7 +4319,7 @@ out_unlock:
  *
  * Returns 0 for success, or -ENOMEM.
  */
-static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_dom=
ain *d)
+static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_l3_mon_=
domain *d)
 {
 	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
 	size_t tsize =3D sizeof(*d->mbm_states[0]);
@@ -4377,7 +4377,7 @@ int resctrl_online_ctrl_domain(struct rdt_resource *r, =
struct rdt_ctrl_domain *d
=20
 int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain_hdr =
*hdr)
 {
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	int err =3D -EINVAL;
=20
 	mutex_lock(&rdtgroup_mutex);
@@ -4385,7 +4385,7 @@ int resctrl_online_mon_domain(struct rdt_resource *r, s=
truct rdt_domain_hdr *hdr
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		goto out_unlock;
=20
-	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+	d =3D container_of(hdr, struct rdt_l3_mon_domain, hdr);
 	err =3D domain_setup_mon_state(r, d);
 	if (err)
 		goto out_unlock;
@@ -4432,10 +4432,10 @@ static void clear_childcpus(struct rdtgroup *r, unsig=
ned int cpu)
 	}
 }
=20
-static struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu,
-						      struct rdt_resource *r)
+static struct rdt_l3_mon_domain *get_mon_domain_from_cpu(int cpu,
+							 struct rdt_resource *r)
 {
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
=20
 	lockdep_assert_cpus_held();
=20
@@ -4451,7 +4451,7 @@ static struct rdt_mon_domain *get_mon_domain_from_cpu(i=
nt cpu,
 void resctrl_offline_cpu(unsigned int cpu)
 {
 	struct rdt_resource *l3 =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	struct rdt_mon_domain *d;
+	struct rdt_l3_mon_domain *d;
 	struct rdtgroup *rdtgrp;
=20
 	mutex_lock(&rdtgroup_mutex);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 9b9877f..79aaaab 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -178,7 +178,7 @@ struct mbm_cntr_cfg {
 };
=20
 /**
- * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor resource
+ * struct rdt_l3_mon_domain - group of CPUs sharing RDT_RESOURCE_L3 monitori=
ng
  * @hdr:		common header for different domain types
  * @ci_id:		cache info id for this domain
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
@@ -192,7 +192,7 @@ struct mbm_cntr_cfg {
  * @cntr_cfg:		array of assignable counters' configuration (indexed
  *			by counter ID)
  */
-struct rdt_mon_domain {
+struct rdt_l3_mon_domain {
 	struct rdt_domain_hdr		hdr;
 	unsigned int			ci_id;
 	unsigned long			*rmid_busy_llc;
@@ -367,10 +367,10 @@ struct resctrl_cpu_defaults {
 };
=20
 struct resctrl_mon_config_info {
-	struct rdt_resource	*r;
-	struct rdt_mon_domain	*d;
-	u32			evtid;
-	u32			mon_config;
+	struct rdt_resource		*r;
+	struct rdt_l3_mon_domain	*d;
+	u32				evtid;
+	u32				mon_config;
 };
=20
 /**
@@ -585,7 +585,7 @@ struct rdt_domain_hdr *resctrl_find_domain(struct list_he=
ad *h, int id,
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *=
d,
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_domai=
n *d,
 			     u32 closid, u32 rmid,
 			     enum resctrl_event_id eventid);
=20
@@ -598,7 +598,7 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, stru=
ct rdt_mon_domain *d,
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_doma=
in *d);
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_d=
omain *d);
=20
 /**
  * resctrl_arch_reset_all_ctrls() - Reset the control for each CLOSID to its
@@ -624,7 +624,7 @@ void resctrl_arch_reset_all_ctrls(struct rdt_resource *r);
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain =
*d,
+void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_l3_mon_doma=
in *d,
 			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
 			      u32 cntr_id, bool assign);
=20
@@ -647,7 +647,7 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, str=
uct rdt_mon_domain *d,
  * Return:
  * 0 on success, or -EIO, -EINVAL etc on error.
  */
-int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_l3_mon_domain =
*d,
 			   u32 closid, u32 rmid, int cntr_id,
 			   enum resctrl_event_id eventid, u64 *val);
=20
@@ -662,7 +662,7 @@ int resctrl_arch_cntr_read(struct rdt_resource *r, struct=
 rdt_mon_domain *d,
  *
  * This can be called from any CPU.
  */
-void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *=
d,
+void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_l3_mon_domai=
n *d,
 			     u32 closid, u32 rmid, int cntr_id,
 			     enum resctrl_event_id eventid);
=20


Return-Path: <linux-tip-commits+bounces-6631-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CF2B57864
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CB1447D76
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761672FF67E;
	Mon, 15 Sep 2025 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Df+rpEGr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5QcQ1cZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AFE306D5E;
	Mon, 15 Sep 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935678; cv=none; b=q5pLeSd+04mBSo4RJXL86zExadnEqdvZcm8QXrVg5Kg8Y1ydCRCMe3kWSJEfnR8WFzDLmYrUzik3n1oUlEpUb7dkybcgRzzFDsu6rPMrqDRL4NhLtjKjZC22867Vo4qj8tSu4drMt2fT3XT6jOZI7zXHnVIX/vTIDH7Gr3UIHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935678; c=relaxed/simple;
	bh=Tlmx0mnOA1k71ovAYt5EAGieVXsqt6HOi5J7uBt0ibg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F/V0LAtPGb63+i97jSRf0cD2o7/6m7ldYaBFsV+cCjX3Fz8T0PAVb8yP5kV2sQPHlPkU2sZAZ19KLgDmZvO/qRIIQQyXQjYzB0nJTq3+2hBgZk7lW5T/MEGV6+GR2ilaBRXGR7fpk9TObamqStSx5uEKzF6YWqHxch6IeX+oo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Df+rpEGr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5QcQ1cZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VC4KGUzqy2ifvMe5O9O7A33shTbCtRM3RLBkk8LxRD4=;
	b=Df+rpEGrVLvnd9kj4yZsHfaeSy0IaxbOWmvP9AU1olynV48lcR6kEF/vzpNXqvOEaZjhUf
	4DQr05yYt/QI2PzGLpLfCNtxgULVFUnZDIxa0ecdh833tiCro8MSCSaYARQX9hfWzeuPV7
	4vUVqP7w3UknfOXUXGdksG5JehdYnsOf2gZ3gQwe2Q+lRL5X9PA6Aq5n4EAxh5POuYwnLv
	CAZmxuK6yZSLJPKE2+wnjc3hWTU2N2V/erqKenjMW5ryfSCbqvpl6wVnrMh/pVNkBF4W5F
	h8GHDk8EX1ool5iPw7J4oyi1EePzzQurcLxya1Qz9iajo6tas1OkEINhdmhjfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VC4KGUzqy2ifvMe5O9O7A33shTbCtRM3RLBkk8LxRD4=;
	b=I5QcQ1cZsN0IZW3TwZrBifmgdRqgocD66ahCFGRuVkVRVR1+6UET3gG2XKFAGJorI8gBaE
	pGlOplGzNMdaFOBg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Prepare for more monitor events
Cc: Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <8519e33c0fe5395ee616e5d77417bf2beea72ece.1757108044.git.babu.moger@amd.com>
References:
 <8519e33c0fe5395ee616e5d77417bf2beea72ece.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793567266.709179.988493404460093334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     83b039877310ae1eb614eef17b780df1e10d9fb5
Gitweb:        https://git.kernel.org/tip/83b039877310ae1eb614eef17b780df1e10=
d9fb5
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:03 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 11:57:03 +02:00

x86,fs/resctrl: Prepare for more monitor events

There's a rule in computer programming that objects appear zero, once, or many
times. So code accordingly.

There are two MBM events and resctrl is coded with a lot of

  if (local)
          do one thing
  if (total)
          do a different thing

Change the rdt_mon_domain and rdt_hw_mon_domain structures to hold arrays of
pointers to per event data instead of explicit fields for total and local
bandwidth.

Simplify by coding for many events using loops on which are enabled.

Move resctrl_is_mbm_event() to <linux/resctrl.h> so it can be used more
widely. Also provide a for_each_mbm_event_id() helper macro.

Cleanup variable names in functions touched to consistently use "eventid" for
those with type enum resctrl_event_id.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 40 +++++++++++---------
 arch/x86/kernel/cpu/resctrl/internal.h |  8 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 36 ++++++++----------
 fs/resctrl/monitor.c                   | 13 +++----
 fs/resctrl/rdtgroup.c                  | 50 ++++++++++++-------------
 include/linux/resctrl.h                | 23 +++++++++---
 include/linux/resctrl_types.h          |  3 ++-
 7 files changed, 96 insertions(+), 77 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 5d14f9a..fbf019c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -365,8 +365,10 @@ static void ctrl_domain_free(struct rdt_hw_ctrl_domain *=
hw_dom)
=20
 static void mon_domain_free(struct rdt_hw_mon_domain *hw_dom)
 {
-	kfree(hw_dom->arch_mbm_total);
-	kfree(hw_dom->arch_mbm_local);
+	int idx;
+
+	for_each_mbm_idx(idx)
+		kfree(hw_dom->arch_mbm_states[idx]);
 	kfree(hw_dom);
 }
=20
@@ -400,25 +402,27 @@ static int domain_setup_ctrlval(struct rdt_resource *r,=
 struct rdt_ctrl_domain *
  */
 static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_mon_domain *hw_=
dom)
 {
-	size_t tsize;
-
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID)) {
-		tsize =3D sizeof(*hw_dom->arch_mbm_total);
-		hw_dom->arch_mbm_total =3D kcalloc(num_rmid, tsize, GFP_KERNEL);
-		if (!hw_dom->arch_mbm_total)
-			return -ENOMEM;
-	}
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID)) {
-		tsize =3D sizeof(*hw_dom->arch_mbm_local);
-		hw_dom->arch_mbm_local =3D kcalloc(num_rmid, tsize, GFP_KERNEL);
-		if (!hw_dom->arch_mbm_local) {
-			kfree(hw_dom->arch_mbm_total);
-			hw_dom->arch_mbm_total =3D NULL;
-			return -ENOMEM;
-		}
+	size_t tsize =3D sizeof(*hw_dom->arch_mbm_states[0]);
+	enum resctrl_event_id eventid;
+	int idx;
+
+	for_each_mbm_event_id(eventid) {
+		if (!resctrl_is_mon_event_enabled(eventid))
+			continue;
+		idx =3D MBM_STATE_IDX(eventid);
+		hw_dom->arch_mbm_states[idx] =3D kcalloc(num_rmid, tsize, GFP_KERNEL);
+		if (!hw_dom->arch_mbm_states[idx])
+			goto cleanup;
 	}
=20
 	return 0;
+cleanup:
+	for_each_mbm_idx(idx) {
+		kfree(hw_dom->arch_mbm_states[idx]);
+		hw_dom->arch_mbm_states[idx] =3D NULL;
+	}
+
+	return -ENOMEM;
 }
=20
 static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index 5e3c41b..58dca89 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -54,15 +54,15 @@ struct rdt_hw_ctrl_domain {
  * struct rdt_hw_mon_domain - Arch private attributes of a set of CPUs that =
share
  *			      a resource for a monitor function
  * @d_resctrl:	Properties exposed to the resctrl file system
- * @arch_mbm_total:	arch private state for MBM total bandwidth
- * @arch_mbm_local:	arch private state for MBM local bandwidth
+ * @arch_mbm_states:	Per-event pointer to the MBM event's saved state.
+ *			An MBM event's state is an array of struct arch_mbm_state
+ *			indexed by RMID on x86.
  *
  * Members of this structure are accessed via helpers that provide abstracti=
on.
  */
 struct rdt_hw_mon_domain {
 	struct rdt_mon_domain		d_resctrl;
-	struct arch_mbm_state		*arch_mbm_total;
-	struct arch_mbm_state		*arch_mbm_local;
+	struct arch_mbm_state		*arch_mbm_states[QOS_NUM_L3_MBM_EVENTS];
 };
=20
 static inline struct rdt_hw_ctrl_domain *resctrl_to_arch_ctrl_dom(struct rdt=
_ctrl_domain *r)
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 07f8ab0..f01db20 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -161,18 +161,14 @@ static struct arch_mbm_state *get_arch_mbm_state(struct=
 rdt_hw_mon_domain *hw_do
 						 u32 rmid,
 						 enum resctrl_event_id eventid)
 {
-	switch (eventid) {
-	case QOS_L3_OCCUP_EVENT_ID:
-		return NULL;
-	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		return &hw_dom->arch_mbm_total[rmid];
-	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		return &hw_dom->arch_mbm_local[rmid];
-	default:
-		/* Never expect to get here */
-		WARN_ON_ONCE(1);
+	struct arch_mbm_state *state;
+
+	if (!resctrl_is_mbm_event(eventid))
 		return NULL;
-	}
+
+	state =3D hw_dom->arch_mbm_states[MBM_STATE_IDX(eventid)];
+
+	return state ? &state[rmid] : NULL;
 }
=20
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *=
d,
@@ -201,14 +197,16 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, st=
ruct rdt_mon_domain *d,
 void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_doma=
in *d)
 {
 	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
-
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
-		memset(hw_dom->arch_mbm_total, 0,
-		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);
-
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
-		memset(hw_dom->arch_mbm_local, 0,
-		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid);
+	enum resctrl_event_id eventid;
+	int idx;
+
+	for_each_mbm_event_id(eventid) {
+		if (!resctrl_is_mon_event_enabled(eventid))
+			continue;
+		idx =3D MBM_STATE_IDX(eventid);
+		memset(hw_dom->arch_mbm_states[idx], 0,
+		       sizeof(*hw_dom->arch_mbm_states[0]) * r->num_rmid);
+	}
 }
=20
 static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index b0b1dcc..e0dfa5f 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -346,15 +346,14 @@ static struct mbm_state *get_mbm_state(struct rdt_mon_d=
omain *d, u32 closid,
 				       u32 rmid, enum resctrl_event_id evtid)
 {
 	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
+	struct mbm_state *state;
=20
-	switch (evtid) {
-	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		return &d->mbm_total[idx];
-	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		return &d->mbm_local[idx];
-	default:
+	if (!resctrl_is_mbm_event(evtid))
 		return NULL;
-	}
+
+	state =3D d->mbm_states[MBM_STATE_IDX(evtid)];
+
+	return state ? &state[idx] : NULL;
 }
=20
 static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 2ca8e66..a6047e9 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -127,12 +127,6 @@ static bool resctrl_is_mbm_enabled(void)
 		resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID));
 }
=20
-static bool resctrl_is_mbm_event(int e)
-{
-	return (e >=3D QOS_L3_MBM_TOTAL_EVENT_ID &&
-		e <=3D QOS_L3_MBM_LOCAL_EVENT_ID);
-}
-
 /*
  * Trivial allocator for CLOSIDs. Use BITMAP APIs to manipulate a bitmap
  * of free CLOSIDs.
@@ -4020,9 +4014,13 @@ static void rdtgroup_setup_default(void)
=20
 static void domain_destroy_mon_state(struct rdt_mon_domain *d)
 {
+	int idx;
+
 	bitmap_free(d->rmid_busy_llc);
-	kfree(d->mbm_total);
-	kfree(d->mbm_local);
+	for_each_mbm_idx(idx) {
+		kfree(d->mbm_states[idx]);
+		d->mbm_states[idx] =3D NULL;
+	}
 }
=20
 void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_dom=
ain *d)
@@ -4082,32 +4080,34 @@ void resctrl_offline_mon_domain(struct rdt_resource *=
r, struct rdt_mon_domain *d
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_dom=
ain *d)
 {
 	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
-	size_t tsize;
+	size_t tsize =3D sizeof(*d->mbm_states[0]);
+	enum resctrl_event_id eventid;
+	int idx;
=20
 	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID)) {
 		d->rmid_busy_llc =3D bitmap_zalloc(idx_limit, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 	}
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID)) {
-		tsize =3D sizeof(*d->mbm_total);
-		d->mbm_total =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
-		if (!d->mbm_total) {
-			bitmap_free(d->rmid_busy_llc);
-			return -ENOMEM;
-		}
-	}
-	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID)) {
-		tsize =3D sizeof(*d->mbm_local);
-		d->mbm_local =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
-		if (!d->mbm_local) {
-			bitmap_free(d->rmid_busy_llc);
-			kfree(d->mbm_total);
-			return -ENOMEM;
-		}
+
+	for_each_mbm_event_id(eventid) {
+		if (!resctrl_is_mon_event_enabled(eventid))
+			continue;
+		idx =3D MBM_STATE_IDX(eventid);
+		d->mbm_states[idx] =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
+		if (!d->mbm_states[idx])
+			goto cleanup;
 	}
=20
 	return 0;
+cleanup:
+	bitmap_free(d->rmid_busy_llc);
+	for_each_mbm_idx(idx) {
+		kfree(d->mbm_states[idx]);
+		d->mbm_states[idx] =3D NULL;
+	}
+
+	return -ENOMEM;
 }
=20
 int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domai=
n *d)
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 40aba6b..478d7a9 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -161,8 +161,9 @@ struct rdt_ctrl_domain {
  * @hdr:		common header for different domain types
  * @ci_id:		cache info id for this domain
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
- * @mbm_total:		saved state for MBM total bandwidth
- * @mbm_local:		saved state for MBM local bandwidth
+ * @mbm_states:		Per-event pointer to the MBM event's saved state.
+ *			An MBM event's state is an array of struct mbm_state
+ *			indexed by RMID on x86 or combined CLOSID, RMID on Arm.
  * @mbm_over:		worker to periodically read MBM h/w counters
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
@@ -172,8 +173,7 @@ struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
 	unsigned int			ci_id;
 	unsigned long			*rmid_busy_llc;
-	struct mbm_state		*mbm_total;
-	struct mbm_state		*mbm_local;
+	struct mbm_state		*mbm_states[QOS_NUM_L3_MBM_EVENTS];
 	struct delayed_work		mbm_over;
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
@@ -376,6 +376,21 @@ bool resctrl_is_mon_event_enabled(enum resctrl_event_id =
eventid);
=20
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
=20
+static inline bool resctrl_is_mbm_event(enum resctrl_event_id eventid)
+{
+	return (eventid >=3D QOS_L3_MBM_TOTAL_EVENT_ID &&
+		eventid <=3D QOS_L3_MBM_LOCAL_EVENT_ID);
+}
+
+/* Iterate over all memory bandwidth events */
+#define for_each_mbm_event_id(eventid)				\
+	for (eventid =3D QOS_L3_MBM_TOTAL_EVENT_ID;		\
+	     eventid <=3D QOS_L3_MBM_LOCAL_EVENT_ID; eventid++)
+
+/* Iterate over memory bandwidth arrays in domain structures */
+#define for_each_mbm_idx(idx)					\
+	for (idx =3D 0; idx < QOS_NUM_L3_MBM_EVENTS; idx++)
+
 /**
  * resctrl_arch_mon_event_config_write() - Write the config for an event.
  * @config_info: struct resctrl_mon_config_info describing the resource, dom=
ain
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index 2dadbc5..d983516 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -51,4 +51,7 @@ enum resctrl_event_id {
 	QOS_NUM_EVENTS,
 };
=20
+#define QOS_NUM_L3_MBM_EVENTS	(QOS_L3_MBM_LOCAL_EVENT_ID - QOS_L3_MBM_TOTAL_=
EVENT_ID + 1)
+#define MBM_STATE_IDX(evt)	((evt) - QOS_L3_MBM_TOTAL_EVENT_ID)
+
 #endif /* __LINUX_RESCTRL_TYPES_H */


Return-Path: <linux-tip-commits+bounces-6633-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9D9B57862
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B171C1894DF3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB97306B05;
	Mon, 15 Sep 2025 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dLkU4ImU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CIk5I7kw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BCF307AD7;
	Mon, 15 Sep 2025 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935679; cv=none; b=Ctngia7fBGpimhpgoFNYLkHaZb1cMMiESxa9rMKf7iI9k18MnWfRcGa9JLYXgSOk99P1WympzVuzTAE2dKfCKhhQiyOKLexfR0SECVyKVonrMlwx3Hih3Rk5w6W6TGoinPlJfjR1XWqGmxyAwajEt2aekEEZL+uei5cJDBI9Y8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935679; c=relaxed/simple;
	bh=MlnwDZ7mjAvqJU9AkvQWJuzAV8nAVn5oNwkJWrwhdpA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mdF37Ifle75VWPxHTMq7mWoClDlBMVQEK15j/sx//zPQY7v32lu74xY3JPfSGOBSFkQNpG75aKp7qQl4VI9GxBkwy9j5EyV9Z+a5LVsmvRMag2Ly1ABVp/BIIiYBoaV1Qp6fULRGmXoLh9lW5ff4dQhaiv1W1XdP2m/6R1WHVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dLkU4ImU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CIk5I7kw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhcSfgsWgjAuROCXBJOPMLtTLVJhVfStiCVhDGzOj7M=;
	b=dLkU4ImUbKl1Lz6tjDzcgqk8mWWG2fIre+2W0dpt+C5p0bWqe6now2ijv7yMqRg8tvPviH
	mBqVqzhUECx0Kq02kvdDgoXlYcXaCw6cmCC+5A53CIZrvG6lSIVBNiX42BC7tw/qcR/S73
	tqDxbXb0Rv1uK130p/8MJtWsh5jczvFK67dMLQ9qDgpLXjLcwTjInlVP6Sp0+q1ioykyLP
	6/jfQ9cANj1LzElIgYta80Ly2kyLTebEXgvwkCuAFgOxE4qUZGARYaIjuz86ihvCRrwo+k
	SjouKlmbD1F8zLfZXbbLQqZz7sC0Blow7BQOkoPmRRuaIKET4o8X/1SsmYwJgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhcSfgsWgjAuROCXBJOPMLtTLVJhVfStiCVhDGzOj7M=;
	b=CIk5I7kwBxid1LwHgGBo9DfmiVG7CiE8RXQ+YVwiHvjoAIR7twkviz4X/GQJv3z+Hai19f
	rw2iX/ofS5MqYaBA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86,fs/resctrl: Replace architecture event enabled checks
Cc: Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Fenghua Yu <fenghuay@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <e07ac35fcd6ac91c82ac58b2aebc613973f25945.1757108044.git.babu.moger@amd.com>
References:
 <e07ac35fcd6ac91c82ac58b2aebc613973f25945.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793567484.709179.13069498361376249244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     d257cc2e5c8bb8236cb161360d6c0529fd442712
Gitweb:        https://git.kernel.org/tip/d257cc2e5c8bb8236cb161360d6c0529fd4=
42712
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:01 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 11:54:14 +02:00

x86,fs/resctrl: Replace architecture event enabled checks

The resctrl file system now has complete knowledge of the status of every
event. So there is no need for per-event function calls to check.

Replace each of the resctrl_arch_is_{event}enabled() calls with
resctrl_is_mon_event_enabled(QOS_{EVENT}).

No functional change.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 arch/x86/include/asm/resctrl.h        | 15 ---------------
 arch/x86/kernel/cpu/resctrl/core.c    |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c |  4 ++--
 fs/resctrl/ctrlmondata.c              |  4 ++--
 fs/resctrl/monitor.c                  | 16 +++++++++++-----
 fs/resctrl/rdtgroup.c                 | 18 +++++++++---------
 include/linux/resctrl.h               |  2 ++
 7 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index feb93b5..b1dd5d6 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -84,21 +84,6 @@ static inline void resctrl_arch_disable_mon(void)
 	static_branch_dec_cpuslocked(&rdt_enable_key);
 }
=20
-static inline bool resctrl_arch_is_llc_occupancy_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_OCCUP_EVENT_ID));
-}
-
-static inline bool resctrl_arch_is_mbm_total_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_MBM_TOTAL_EVENT_ID));
-}
-
-static inline bool resctrl_arch_is_mbm_local_enabled(void)
-{
-	return (rdt_mon_features & (1 << QOS_L3_MBM_LOCAL_EVENT_ID));
-}
-
 /*
  * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
  *
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 7fcae25..1a319ce 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -402,13 +402,13 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct r=
dt_hw_mon_domain *hw_dom)
 {
 	size_t tsize;
=20
-	if (resctrl_arch_is_mbm_total_enabled()) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		tsize =3D sizeof(*hw_dom->arch_mbm_total);
 		hw_dom->arch_mbm_total =3D kcalloc(num_rmid, tsize, GFP_KERNEL);
 		if (!hw_dom->arch_mbm_total)
 			return -ENOMEM;
 	}
-	if (resctrl_arch_is_mbm_local_enabled()) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID)) {
 		tsize =3D sizeof(*hw_dom->arch_mbm_local);
 		hw_dom->arch_mbm_local =3D kcalloc(num_rmid, tsize, GFP_KERNEL);
 		if (!hw_dom->arch_mbm_local) {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index c261558..61d3851 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -207,11 +207,11 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r=
, struct rdt_mon_domain *
 {
 	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
=20
-	if (resctrl_arch_is_mbm_total_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
 		memset(hw_dom->arch_mbm_total, 0,
 		       sizeof(*hw_dom->arch_mbm_total) * r->num_rmid);
=20
-	if (resctrl_arch_is_mbm_local_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 		memset(hw_dom->arch_mbm_local, 0,
 		       sizeof(*hw_dom->arch_mbm_local) * r->num_rmid);
 }
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 3c39cfa..42b281b 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -473,12 +473,12 @@ ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_ope=
n_file *of,
 	rdt_last_cmd_clear();
=20
 	if (!strcmp(buf, "mbm_local_bytes")) {
-		if (resctrl_arch_is_mbm_local_enabled())
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 			rdtgrp->mba_mbps_event =3D QOS_L3_MBM_LOCAL_EVENT_ID;
 		else
 			ret =3D -EINVAL;
 	} else if (!strcmp(buf, "mbm_total_bytes")) {
-		if (resctrl_arch_is_mbm_total_enabled())
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
 			rdtgrp->mba_mbps_event =3D QOS_L3_MBM_TOTAL_EVENT_ID;
 		else
 			ret =3D -EINVAL;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index d5bf3e0..b0b1dcc 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -336,7 +336,7 @@ void free_rmid(u32 closid, u32 rmid)
=20
 	entry =3D __rmid_entry(idx);
=20
-	if (resctrl_arch_is_llc_occupancy_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID))
 		add_rmid_to_limbo(entry);
 	else
 		list_add_tail(&entry->list, &rmid_free_lru);
@@ -635,10 +635,10 @@ static void mbm_update(struct rdt_resource *r, struct r=
dt_mon_domain *d,
 	 * This is protected from concurrent reads from user as both
 	 * the user and overflow handler hold the global mutex.
 	 */
-	if (resctrl_arch_is_mbm_total_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
 		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_TOTAL_EVENT_ID);
=20
-	if (resctrl_arch_is_mbm_local_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_LOCAL_EVENT_ID);
 }
=20
@@ -877,6 +877,12 @@ void resctrl_enable_mon_event(enum resctrl_event_id even=
tid)
 	mon_event_all[eventid].enabled =3D true;
 }
=20
+bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid)
+{
+	return eventid >=3D QOS_FIRST_EVENT && eventid < QOS_NUM_EVENTS &&
+	       mon_event_all[eventid].enabled;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -912,9 +918,9 @@ int resctrl_mon_resource_init(void)
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
=20
-	if (resctrl_arch_is_mbm_local_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
 		mba_mbps_default_event =3D QOS_L3_MBM_LOCAL_EVENT_ID;
-	else if (resctrl_arch_is_mbm_total_enabled())
+	else if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
 		mba_mbps_default_event =3D QOS_L3_MBM_TOTAL_EVENT_ID;
=20
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index ab943a5..2ca8e66 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -123,8 +123,8 @@ void rdt_staged_configs_clear(void)
=20
 static bool resctrl_is_mbm_enabled(void)
 {
-	return (resctrl_arch_is_mbm_total_enabled() ||
-		resctrl_arch_is_mbm_local_enabled());
+	return (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID) ||
+		resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID));
 }
=20
 static bool resctrl_is_mbm_event(int e)
@@ -196,7 +196,7 @@ static int closid_alloc(void)
 	lockdep_assert_held(&rdtgroup_mutex);
=20
 	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
-	    resctrl_arch_is_llc_occupancy_enabled()) {
+	    resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID)) {
 		cleanest_closid =3D resctrl_find_cleanest_closid();
 		if (cleanest_closid < 0)
 			return cleanest_closid;
@@ -4048,7 +4048,7 @@ void resctrl_offline_mon_domain(struct rdt_resource *r,=
 struct rdt_mon_domain *d
=20
 	if (resctrl_is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-	if (resctrl_arch_is_llc_occupancy_enabled() && has_busy_rmid(d)) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID) && has_busy_rmid(d)=
) {
 		/*
 		 * When a package is going down, forcefully
 		 * decrement rmid->ebusy. There is no way to know
@@ -4084,12 +4084,12 @@ static int domain_setup_mon_state(struct rdt_resource=
 *r, struct rdt_mon_domain=20
 	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
 	size_t tsize;
=20
-	if (resctrl_arch_is_llc_occupancy_enabled()) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID)) {
 		d->rmid_busy_llc =3D bitmap_zalloc(idx_limit, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 	}
-	if (resctrl_arch_is_mbm_total_enabled()) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID)) {
 		tsize =3D sizeof(*d->mbm_total);
 		d->mbm_total =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_total) {
@@ -4097,7 +4097,7 @@ static int domain_setup_mon_state(struct rdt_resource *=
r, struct rdt_mon_domain=20
 			return -ENOMEM;
 		}
 	}
-	if (resctrl_arch_is_mbm_local_enabled()) {
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID)) {
 		tsize =3D sizeof(*d->mbm_local);
 		d->mbm_local =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_local) {
@@ -4142,7 +4142,7 @@ int resctrl_online_mon_domain(struct rdt_resource *r, s=
truct rdt_mon_domain *d)
 					   RESCTRL_PICK_ANY_CPU);
 	}
=20
-	if (resctrl_arch_is_llc_occupancy_enabled())
+	if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID))
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
=20
 	/*
@@ -4217,7 +4217,7 @@ void resctrl_offline_cpu(unsigned int cpu)
 			cancel_delayed_work(&d->mbm_over);
 			mbm_setup_overflow_handler(d, 0, cpu);
 		}
-		if (resctrl_arch_is_llc_occupancy_enabled() &&
+		if (resctrl_is_mon_event_enabled(QOS_L3_OCCUP_EVENT_ID) &&
 		    cpu =3D=3D d->cqm_work_cpu && has_busy_rmid(d)) {
 			cancel_delayed_work(&d->cqm_limbo);
 			cqm_setup_limbo_handler(d, 0, cpu);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 2944042..40aba6b 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -372,6 +372,8 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u=
32 closid);
=20
 void resctrl_enable_mon_event(enum resctrl_event_id eventid);
=20
+bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid);
+
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
=20
 /**


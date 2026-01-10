Return-Path: <linux-tip-commits+bounces-7862-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E8DD0DCC1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BB143061903
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDA62F39A7;
	Sat, 10 Jan 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oc7LmdNQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8Y/HEid"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B62ECE93;
	Sat, 10 Jan 2026 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074391; cv=none; b=fd5K6qDDEaW4tA35JIZQDt+mGr8YJp6Yrl/5YwQRBBm38ExmVusL3Hq95J6l9vqdPQJuUJgNTn2J+grQJBzc9P5wcAnG205JbADYWr4p7mPgylrUN2FK8v9YdETVkV43okg8lYWNOg5B7PTaJ3CiUITzlazoHQ9Y2OoaUTOAyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074391; c=relaxed/simple;
	bh=Z0P2JebpAXxTCPJY/2YZVvoghVusG+MGA4/SS7Q0Um8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=E+Oc103w2sT2fDHLyJehBqStposvnnA/XFMOHSWz0z3oMRs5lFvasZYBwaKtwoP8OlWP5WxZx5eKTtY/2RRE6ZBIL498tCzFsFFXq+9ZFTXHQFp9Ho19lI0Z+C+Zu9/J3oAiSFR+kIcy3vQzGHIM/syUhpyIGYqHV82BYmb8cUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oc7LmdNQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8Y/HEid; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=TFyKy/bt78Ci/vMoknqG0RqtmuJzugUsiIkyT1p006A=;
	b=oc7LmdNQOWduKZkkTNRn/MpZhE7Kyoylhyeq+NDjVPKvpx5dpVAUvRDV3jYhrPH/BP+KS0
	cCl5ASl2+w9OTqWQbDRacPaioAz+FUNkAJ0Mf0Nx/Gt7R+JqZ5Hvi5QeUJqOqVBVzJn3pf
	6BUErFL7J7dhJUM8ON+QbxS52jC7h76JpvU2S/jobP+VqoDk73OBDjW8OAo5aayTxefMvu
	HCOUunysGArQ2vTmQic5bOFVMMbZwOxT5t0mw1UYpoYqrEciEm/1XgK+wmWcZV0cI6v03Z
	0Qw7ms5j65neaF3iHrrK1UnL6Jp5sbzpZWSwzQ7CJSbqjhOzNV7w8fbZMiGg1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=TFyKy/bt78Ci/vMoknqG0RqtmuJzugUsiIkyT1p006A=;
	b=t8Y/HEidy4it0ke+BjhMZq/99Pg6TqqBRVBf6oAWDqxxwW3OvNRYbghDr4FiObd+Hjv1SU
	I4zywsJlUhHkrEAw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Make event details accessible to
 functions when reading events
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807437166.510.14838268424719299796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     dd110880e80d35ad07e460e7a8da007c8058e7bf
Gitweb:        https://git.kernel.org/tip/dd110880e80d35ad07e460e7a8da007c805=
8e7bf
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:57 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jan 2026 15:25:22 +01:00

fs/resctrl: Make event details accessible to functions when reading events

Reading monitoring event data from MMIO requires more context than the event =
id
to be able to read the correct memory location. struct mon_evt is the appropr=
iate
place for this event specific context.

Prepare for addition of extra fields to struct mon_evt by changing the calling
conventions to pass a pointer to the mon_evt structure instead of just the
event id.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 fs/resctrl/ctrlmondata.c | 18 +++++++++---------
 fs/resctrl/internal.h    | 10 +++++-----
 fs/resctrl/monitor.c     | 22 +++++++++++-----------
 fs/resctrl/rdtgroup.c    |  6 +++---
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index a3c734f..7f9b2fe 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -552,7 +552,7 @@ struct rdt_domain_hdr *resctrl_find_domain(struct list_he=
ad *h, int id,
=20
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain_hdr *hdr, struct rdtgroup *rdtgrp,
-		    cpumask_t *cpumask, int evtid, int first)
+		    cpumask_t *cpumask, struct mon_evt *evt, int first)
 {
 	int cpu;
=20
@@ -563,15 +563,15 @@ void mon_event_read(struct rmid_read *rr, struct rdt_re=
source *r,
 	 * Setup the parameters to pass to mon_event_count() to read the data.
 	 */
 	rr->rgrp =3D rdtgrp;
-	rr->evtid =3D evtid;
+	rr->evt =3D evt;
 	rr->r =3D r;
 	rr->hdr =3D hdr;
 	rr->first =3D first;
 	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
-	    resctrl_is_mbm_event(evtid)) {
+	    resctrl_is_mbm_event(evt->evtid)) {
 		rr->is_mbm_cntr =3D true;
 	} else {
-		rr->arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(r, evtid);
+		rr->arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(r, evt->evtid);
 		if (IS_ERR(rr->arch_mon_ctx)) {
 			rr->err =3D -EINVAL;
 			return;
@@ -592,14 +592,13 @@ void mon_event_read(struct rmid_read *rr, struct rdt_re=
source *r,
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
=20
 	if (rr->arch_mon_ctx)
-		resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
+		resctrl_arch_mon_ctx_free(r, evt->evtid, rr->arch_mon_ctx);
 }
=20
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of =3D m->private;
 	enum resctrl_res_level resid;
-	enum resctrl_event_id evtid;
 	struct rdt_l3_mon_domain *d;
 	struct rdt_domain_hdr *hdr;
 	struct rmid_read rr =3D {0};
@@ -607,6 +606,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	int domid, cpu, ret =3D 0;
 	struct rdt_resource *r;
 	struct cacheinfo *ci;
+	struct mon_evt *evt;
 	struct mon_data *md;
=20
 	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
@@ -623,7 +623,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
=20
 	resid =3D md->rid;
 	domid =3D md->domid;
-	evtid =3D md->evtid;
+	evt =3D md->evt;
 	r =3D resctrl_arch_get_resource(resid);
=20
 	if (md->sum) {
@@ -641,7 +641,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 					continue;
 				rr.ci =3D ci;
 				mon_event_read(&rr, r, NULL, rdtgrp,
-					       &ci->shared_cpu_map, evtid, false);
+					       &ci->shared_cpu_map, evt, false);
 				goto checkresult;
 			}
 		}
@@ -657,7 +657,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 			ret =3D -ENOENT;
 			goto out;
 		}
-		mon_event_read(&rr, r, hdr, rdtgrp, &hdr->cpu_mask, evtid, false);
+		mon_event_read(&rr, r, hdr, rdtgrp, &hdr->cpu_mask, evt, false);
 	}
=20
 checkresult:
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 9768341..86cf38a 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -81,7 +81,7 @@ extern struct mon_evt mon_event_all[QOS_NUM_EVENTS];
  * struct mon_data - Monitoring details for each event file.
  * @list:            Member of the global @mon_data_kn_priv_list list.
  * @rid:             Resource id associated with the event file.
- * @evtid:           Event id associated with the event file.
+ * @evt:             Event structure associated with the event file.
  * @sum:             Set when event must be summed across multiple
  *                   domains.
  * @domid:           When @sum is zero this is the domain to which
@@ -95,7 +95,7 @@ extern struct mon_evt mon_event_all[QOS_NUM_EVENTS];
 struct mon_data {
 	struct list_head	list;
 	enum resctrl_res_level	rid;
-	enum resctrl_event_id	evtid;
+	struct mon_evt		*evt;
 	int			domid;
 	bool			sum;
 };
@@ -108,7 +108,7 @@ struct mon_data {
  * @r:	   Resource describing the properties of the event being read.
  * @hdr:   Header of domain that the counter should be read from. If NULL th=
en
  *	   sum all domains in @r sharing L3 @ci.id
- * @evtid: Which monitor event to read.
+ * @evt:   Which monitor event to read.
  * @first: Initialize MBM counter when true.
  * @ci:    Cacheinfo for L3. Only set when @hdr is NULL. Used when summing
  *	   domains.
@@ -126,7 +126,7 @@ struct rmid_read {
 	struct rdtgroup		*rgrp;
 	struct rdt_resource	*r;
 	struct rdt_domain_hdr	*hdr;
-	enum resctrl_event_id	evtid;
+	struct mon_evt		*evt;
 	bool			first;
 	struct cacheinfo	*ci;
 	bool			is_mbm_cntr;
@@ -367,7 +367,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg);
=20
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain_hdr *hdr, struct rdtgroup *rdtgrp,
-		    cpumask_t *cpumask, int evtid, int first);
+		    cpumask_t *cpumask, struct mon_evt *evt, int first);
=20
 void mbm_setup_overflow_handler(struct rdt_l3_mon_domain *dom,
 				unsigned long delay_ms,
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index d5ae0ef..340b847 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -430,7 +430,7 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp, =
struct rmid_read *rr)
 	d =3D container_of(rr->hdr, struct rdt_l3_mon_domain, hdr);
=20
 	if (rr->is_mbm_cntr) {
-		cntr_id =3D mbm_cntr_get(rr->r, d, rdtgrp, rr->evtid);
+		cntr_id =3D mbm_cntr_get(rr->r, d, rdtgrp, rr->evt->evtid);
 		if (cntr_id < 0) {
 			rr->err =3D -ENOENT;
 			return -EINVAL;
@@ -439,10 +439,10 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp=
, struct rmid_read *rr)
=20
 	if (rr->first) {
 		if (rr->is_mbm_cntr)
-			resctrl_arch_reset_cntr(rr->r, d, closid, rmid, cntr_id, rr->evtid);
+			resctrl_arch_reset_cntr(rr->r, d, closid, rmid, cntr_id, rr->evt->evtid);
 		else
-			resctrl_arch_reset_rmid(rr->r, d, closid, rmid, rr->evtid);
-		m =3D get_mbm_state(d, closid, rmid, rr->evtid);
+			resctrl_arch_reset_rmid(rr->r, d, closid, rmid, rr->evt->evtid);
+		m =3D get_mbm_state(d, closid, rmid, rr->evt->evtid);
 		if (m)
 			memset(m, 0, sizeof(struct mbm_state));
 		return 0;
@@ -453,10 +453,10 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp=
, struct rmid_read *rr)
 		return -EINVAL;
 	if (rr->is_mbm_cntr)
 		rr->err =3D resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
-						 rr->evtid, &tval);
+						 rr->evt->evtid, &tval);
 	else
 		rr->err =3D resctrl_arch_rmid_read(rr->r, rr->hdr, closid, rmid,
-						 rr->evtid, &tval, rr->arch_mon_ctx);
+						 rr->evt->evtid, &tval, rr->arch_mon_ctx);
 	if (rr->err)
 		return rr->err;
=20
@@ -501,7 +501,7 @@ static int __l3_mon_event_count_sum(struct rdtgroup *rdtg=
rp, struct rmid_read *r
 		if (d->ci_id !=3D rr->ci->id)
 			continue;
 		err =3D resctrl_arch_rmid_read(rr->r, &d->hdr, closid, rmid,
-					     rr->evtid, &tval, rr->arch_mon_ctx);
+					     rr->evt->evtid, &tval, rr->arch_mon_ctx);
 		if (!err) {
 			rr->val +=3D tval;
 			ret =3D 0;
@@ -551,7 +551,7 @@ static void mbm_bw_count(struct rdtgroup *rdtgrp, struct =
rmid_read *rr)
 	if (!domain_header_is_valid(rr->hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return;
 	d =3D container_of(rr->hdr, struct rdt_l3_mon_domain, hdr);
-	m =3D get_mbm_state(d, closid, rmid, rr->evtid);
+	m =3D get_mbm_state(d, closid, rmid, rr->evt->evtid);
 	if (WARN_ON_ONCE(!m))
 		return;
=20
@@ -725,11 +725,11 @@ static void mbm_update_one_event(struct rdt_resource *r=
, struct rdt_l3_mon_domai
=20
 	rr.r =3D r;
 	rr.hdr =3D &d->hdr;
-	rr.evtid =3D evtid;
+	rr.evt =3D &mon_event_all[evtid];
 	if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
 		rr.is_mbm_cntr =3D true;
 	} else {
-		rr.arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
+		rr.arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(rr.r, evtid);
 		if (IS_ERR(rr.arch_mon_ctx)) {
 			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
 					    PTR_ERR(rr.arch_mon_ctx));
@@ -747,7 +747,7 @@ static void mbm_update_one_event(struct rdt_resource *r, =
struct rdt_l3_mon_domai
 		mbm_bw_count(rdtgrp, &rr);
=20
 	if (rr.arch_mon_ctx)
-		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
+		resctrl_arch_mon_ctx_free(rr.r, evtid, rr.arch_mon_ctx);
 }
=20
 static void mbm_update(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index b57e1e7..771e40f 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -3103,7 +3103,7 @@ static struct mon_data *mon_get_kn_priv(enum resctrl_re=
s_level rid, int domid,
=20
 	list_for_each_entry(priv, &mon_data_kn_priv_list, list) {
 		if (priv->rid =3D=3D rid && priv->domid =3D=3D domid &&
-		    priv->sum =3D=3D do_sum && priv->evtid =3D=3D mevt->evtid)
+		    priv->sum =3D=3D do_sum && priv->evt =3D=3D mevt)
 			return priv;
 	}
=20
@@ -3114,7 +3114,7 @@ static struct mon_data *mon_get_kn_priv(enum resctrl_re=
s_level rid, int domid,
 	priv->rid =3D rid;
 	priv->domid =3D domid;
 	priv->sum =3D do_sum;
-	priv->evtid =3D mevt->evtid;
+	priv->evt =3D mevt;
 	list_add_tail(&priv->list, &mon_data_kn_priv_list);
=20
 	return priv;
@@ -3281,7 +3281,7 @@ static int mon_add_all_files(struct kernfs_node *kn, st=
ruct rdt_domain_hdr *hdr,
 			return ret;
=20
 		if (!do_sum && resctrl_is_mbm_event(mevt->evtid))
-			mon_event_read(&rr, r, hdr, prgrp, &hdr->cpu_mask, mevt->evtid, true);
+			mon_event_read(&rr, r, hdr, prgrp, &hdr->cpu_mask, mevt, true);
 	}
=20
 	return 0;


Return-Path: <linux-tip-commits+bounces-6611-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD63AB57819
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D188844520E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87833009F0;
	Mon, 15 Sep 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="my2lA2lQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8r9Tg32J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B33002BF;
	Mon, 15 Sep 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935655; cv=none; b=k7TXDJ2lmRV2149krH4B1e7lJOnHymsRLzRfg30CRuNK5+rQm3Wlz1JwyJkodr6h2O7Dba820SSMHovqAyPDFDHG3tfPaYU1uus+yxxs+SYPkScLNMRsiFkG1+tlcFRcfGbXcTNmBmdhp2TjfjK9XRoOOyxQ07Cv40DccZeX9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935655; c=relaxed/simple;
	bh=4W0xh5ds5fX/eRNVGS3kym9BvrXOqDqnA2Em9Bqr8VQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ggXquAckhowAUMhphUwGhtJ3Vyqle7WfaStT3wu0t7HUIYPAbyizky8zHUfijNK9Y27sxJ+qxj25HOkMBHupNBCLqU1ZwusR8SzL2mM7RKqwsGqEDPLVSawgPOjIB1IJ9M89FOU+lYWUAaGY4AGoKkkAB1qKf5InRBCylJFkjcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=my2lA2lQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8r9Tg32J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEGn74h8IOu7wlrnwqZKvrbnx4MGHegcZvmjDFuujc8=;
	b=my2lA2lQ4l+K9foGY8rrS01itxjZQJalw0TMCk3XI0zgGZI83rSPORSJ3oyFwV0ti+8sqd
	OvWWBueCP8BiNGgplnw/kOLkNSTCbwCwiG8ZGrbHoAJ+DDLB81nYcpETst9pUck8incMve
	X8GlaqDbrIQj95UgJ06/dRN9rEwEamv7VTDffAira/H9FGQg43k/tawcYYWSDYds8CvFo0
	4TagLRgvEvbfcRYkaUmSIeuPsQKI3shkL7viF96TymXGwsW7WCqnVyEc8lmc87YFPsBM9F
	+p2Vlpi5x/20rH+h173iUvOncCCFkqrErgj9ihbzEtdpS5SMucBGoPeA0irOjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEGn74h8IOu7wlrnwqZKvrbnx4MGHegcZvmjDFuujc8=;
	b=8r9Tg32JlbFcssUxHiPx7uj2wG0737h8LgTAAFtRAUX/lxJ3o2dhvSEwO+eaeVq/eGrvFG
	LnAQZUPVOvhMJlDw==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Support counter read/reset with
 mbm_event assignment mode
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <7dc53c86f6b75c8cc711e97c52c16de2fcd7869b.1757108044.git.babu.moger@amd.com>
References:
 <7dc53c86f6b75c8cc711e97c52c16de2fcd7869b.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793565114.709179.10813660769682769908.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     159f36cd4de7718779fd0b232de5137b4ffd2d1e
Gitweb:        https://git.kernel.org/tip/159f36cd4de7718779fd0b232de5137b4ff=
d2d1e
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:22 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:38:58 +02:00

fs/resctrl: Support counter read/reset with mbm_event assignment mode

When "mbm_event" counter assignment mode is enabled, the architecture requires
a counter ID to read the event data.

Introduce an is_mbm_cntr field in struct rmid_read to indicate whether counter
assignment mode is in use.

Update the logic to call resctrl_arch_cntr_read() and resctrl_arch_reset_cntr=
()
when the assignment mode is active. Report 'Unassigned' in case the user atte=
mpts
to read an event without assigning a hardware counter.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst |  6 +++-
 fs/resctrl/ctrlmondata.c              | 22 +++++++++---
 fs/resctrl/internal.h                 |  3 ++-
 fs/resctrl/monitor.c                  | 47 +++++++++++++++++++-------
 4 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index 446736d..4c24c5f 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -434,6 +434,12 @@ When monitoring is enabled all MON groups will also cont=
ain:
 	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
 	where "YY" is the node number.
=20
+	When the 'mbm_event' counter assignment mode is enabled, reading
+	an MBM event of a MON group returns 'Unassigned' if no hardware
+	counter is assigned to it. For CTRL_MON groups, 'Unassigned' is
+	returned if the MBM event does not have an assigned counter in the
+	CTRL_MON group nor in any of its associated MON groups.
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 42b281b..0d0ef54 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -563,10 +563,15 @@ void mon_event_read(struct rmid_read *rr, struct rdt_re=
source *r,
 	rr->r =3D r;
 	rr->d =3D d;
 	rr->first =3D first;
-	rr->arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(r, evtid);
-	if (IS_ERR(rr->arch_mon_ctx)) {
-		rr->err =3D -EINVAL;
-		return;
+	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
+	    resctrl_is_mbm_event(evtid)) {
+		rr->is_mbm_cntr =3D true;
+	} else {
+		rr->arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(r, evtid);
+		if (IS_ERR(rr->arch_mon_ctx)) {
+			rr->err =3D -EINVAL;
+			return;
+		}
 	}
=20
 	cpu =3D cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
@@ -582,7 +587,8 @@ void mon_event_read(struct rmid_read *rr, struct rdt_reso=
urce *r,
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
=20
-	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
+	if (rr->arch_mon_ctx)
+		resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
 }
=20
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
@@ -653,10 +659,16 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
=20
 checkresult:
=20
+	/*
+	 * -ENOENT is a special case, set only when "mbm_event" counter assignment
+	 * mode is enabled and no counter has been assigned.
+	 */
 	if (rr.err =3D=3D -EIO)
 		seq_puts(m, "Error\n");
 	else if (rr.err =3D=3D -EINVAL)
 		seq_puts(m, "Unavailable\n");
+	else if (rr.err =3D=3D -ENOENT)
+		seq_puts(m, "Unassigned\n");
 	else
 		seq_printf(m, "%llu\n", rr.val);
=20
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index c6b66d4..2f1f2ef 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -111,6 +111,8 @@ struct mon_data {
  * @evtid: Which monitor event to read.
  * @first: Initialize MBM counter when true.
  * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing dom=
ains.
+ * @is_mbm_cntr: true if "mbm_event" counter assignment mode is enabled and =
it
+ *	   is an MBM event.
  * @err:   Error encountered when reading counter.
  * @val:   Returned value of event counter. If @rgrp is a parent resource gr=
oup,
  *	   @val includes the sum of event counts from its child resource groups.
@@ -125,6 +127,7 @@ struct rmid_read {
 	enum resctrl_event_id	evtid;
 	bool			first;
 	struct cacheinfo	*ci;
+	bool			is_mbm_cntr;
 	int			err;
 	u64			val;
 	void			*arch_mon_ctx;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index c815153..5532705 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -419,12 +419,24 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, s=
truct rmid_read *rr)
 	u32 closid =3D rdtgrp->closid;
 	u32 rmid =3D rdtgrp->mon.rmid;
 	struct rdt_mon_domain *d;
+	int cntr_id =3D -ENOENT;
 	struct mbm_state *m;
 	int err, ret;
 	u64 tval =3D 0;
=20
+	if (rr->is_mbm_cntr) {
+		cntr_id =3D mbm_cntr_get(rr->r, rr->d, rdtgrp, rr->evtid);
+		if (cntr_id < 0) {
+			rr->err =3D -ENOENT;
+			return -EINVAL;
+		}
+	}
+
 	if (rr->first) {
-		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
+		if (rr->is_mbm_cntr)
+			resctrl_arch_reset_cntr(rr->r, rr->d, closid, rmid, cntr_id, rr->evtid);
+		else
+			resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
 		m =3D get_mbm_state(rr->d, closid, rmid, rr->evtid);
 		if (m)
 			memset(m, 0, sizeof(struct mbm_state));
@@ -435,8 +447,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, st=
ruct rmid_read *rr)
 		/* Reading a single domain, must be on a CPU in that domain. */
 		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
 			return -EINVAL;
-		rr->err =3D resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
-						 rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->is_mbm_cntr)
+			rr->err =3D resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
+							 rr->evtid, &tval);
+		else
+			rr->err =3D resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
+							 rr->evtid, &tval, rr->arch_mon_ctx);
 		if (rr->err)
 			return rr->err;
=20
@@ -460,8 +476,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, st=
ruct rmid_read *rr)
 	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
 		if (d->ci_id !=3D rr->ci->id)
 			continue;
-		err =3D resctrl_arch_rmid_read(rr->r, d, closid, rmid,
-					     rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->is_mbm_cntr)
+			err =3D resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
+						     rr->evtid, &tval);
+		else
+			err =3D resctrl_arch_rmid_read(rr->r, d, closid, rmid,
+						     rr->evtid, &tval, rr->arch_mon_ctx);
 		if (!err) {
 			rr->val +=3D tval;
 			ret =3D 0;
@@ -668,11 +688,15 @@ static void mbm_update_one_event(struct rdt_resource *r=
, struct rdt_mon_domain *
 	rr.r =3D r;
 	rr.d =3D d;
 	rr.evtid =3D evtid;
-	rr.arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
-	if (IS_ERR(rr.arch_mon_ctx)) {
-		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
-				    PTR_ERR(rr.arch_mon_ctx));
-		return;
+	if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rr.is_mbm_cntr =3D true;
+	} else {
+		rr.arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
+		if (IS_ERR(rr.arch_mon_ctx)) {
+			pr_warn_ratelimited("Failed to allocate monitor context: %ld",
+					    PTR_ERR(rr.arch_mon_ctx));
+			return;
+		}
 	}
=20
 	__mon_event_count(rdtgrp, &rr);
@@ -684,7 +708,8 @@ static void mbm_update_one_event(struct rdt_resource *r, =
struct rdt_mon_domain *
 	if (is_mba_sc(NULL))
 		mbm_bw_count(rdtgrp, &rr);
=20
-	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
+	if (rr.arch_mon_ctx)
+		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 }
=20
 static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,


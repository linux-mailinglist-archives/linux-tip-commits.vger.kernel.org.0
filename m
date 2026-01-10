Return-Path: <linux-tip-commits+bounces-7859-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45927D0DC79
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B691301AB04
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDCE2EFDBA;
	Sat, 10 Jan 2026 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ym+9DQFV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XLrYAQ8J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC92581;
	Sat, 10 Jan 2026 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074386; cv=none; b=CQuT6GRA9CiKCXxcYb7isHQIMDSIhRAToE1tR9/md0DvXEEjXyHI6gYjndpDw02r1aS6rSt7eZyZSjoQ+PRQ0g0sUf/fqMYbA9mrL0kr2pLsvkwZkPJnYEOcTvCHv4HVUWDKpbPJR+kBnU4Olt2MQLdDEwpxdvzq4jFTIdKFt8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074386; c=relaxed/simple;
	bh=T2tzKGDg76GyhKHhNcXlxji3BWNfj7IbafUhJSMKuas=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=idqKO8GftAWFSc583lkgWWtMsvbxz+DoBXZ8EN3Hdqt8VMwRYX24TSPXy0uQrVnSANnUE8E/YgEJGwkVZPvuoo6hCkqDXV1eB58av2ZlAIYXHd5vXxVaK0KikGenPdWZ1YSDNUtHdeOF23HvsRfZ/ekj5sWJjBx3Jf05hOnXWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ym+9DQFV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XLrYAQ8J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PT67mQhikBfnIo1DE4oXbx4VBbMJ2VynMlrjL82TQb0=;
	b=ym+9DQFV9c379jpGDhwCU4YRYrA2IPvO4udxTSi2b0y37vWKnRx/CM4BUT9O0kjiEXMAPi
	65GqMqaXiSN/uuk1nuY9kObdNYijGW/D3Sigbb5Zmaf4gfDtLLu/YKJjUuiJ6kAtARwoOL
	lWFfrtLLHLzySmOCWVyYKrn9euHbzhFtFAK963wNyXDndbEnj1u/023iHjooyWoyQrdzQI
	GpgdIVdPGyNi7fgJNReweOqr89xscXwCv1DWHzAoHHB1aLDNxHlDQ+Lqdit6wW57+E4hdM
	c619VURLyZGn3KI/FczFkBnJmL2UO/Xxm9/eBOlHXuFLdW0M+ua1FeZzSh9A/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PT67mQhikBfnIo1DE4oXbx4VBbMJ2VynMlrjL82TQb0=;
	b=XLrYAQ8J0DZTAisRXRh0GMHHANpugA8J6r8oVCh54G4qBNFL6z1Dnesu9W8Iuy/fm3BRgq
	cQCdFUBBy/9qIFBg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Use struct rdt_domain_hdr when
 reading counters
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807437484.510.16732009814869111711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6b10cf7b6ea857cdf9570e21c077a05803f60575
Gitweb:        https://git.kernel.org/tip/6b10cf7b6ea857cdf9570e21c077a05803f=
60575
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:54 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jan 2026 11:08:58 +01:00

x86,fs/resctrl: Use struct rdt_domain_hdr when reading counters

Convert the whole call sequence from mon_event_read() to resctrl_arch_rmid_re=
ad() to
pass resource independent struct rdt_domain_hdr instead of an L3 specific dom=
ain
structure to prepare for monitoring events in other resources.

This additional layer of indirection obscures which aspects of event counting=
 depend
on a valid domain. Event initialization, support for assignable counters, and=
 normal
event counting implicitly depend on a valid domain while summing of domains d=
oes not.
Split summing domains from the core event counting handling to make their res=
pective
dependencies obvious.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 12 +++-
 fs/resctrl/ctrlmondata.c              |  9 +---
 fs/resctrl/internal.h                 | 18 +++---
 fs/resctrl/monitor.c                  | 85 +++++++++++++++++---------
 include/linux/resctrl.h               |  4 +-
 5 files changed, 78 insertions(+), 50 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index dffcc83..3da970e 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -238,19 +238,25 @@ static u64 get_corrected_val(struct rdt_resource *r, st=
ruct rdt_mon_domain *d,
 	return chunks * hw_res->mon_scale;
 }
=20
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hd=
r,
 			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *ignored)
 {
-	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
-	int cpu =3D cpumask_any(&d->hdr.cpu_mask);
+	struct rdt_hw_mon_domain *hw_dom;
 	struct arch_mbm_state *am;
+	struct rdt_mon_domain *d;
 	u64 msr_val;
 	u32 prmid;
+	int cpu;
 	int ret;
=20
 	resctrl_arch_rmid_read_context_check();
+	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+		return -EINVAL;
=20
+	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+	hw_dom =3D resctrl_to_arch_mon_dom(d);
+	cpu =3D cpumask_any(&hdr->cpu_mask);
 	prmid =3D logical_rmid_to_physical_rmid(cpu, rmid);
 	ret =3D __rmid_read_phys(prmid, eventid, &msr_val);
=20
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 3154cdc..9242a29 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -554,25 +554,18 @@ void mon_event_read(struct rmid_read *rr, struct rdt_re=
source *r,
 		    struct rdt_domain_hdr *hdr, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first)
 {
-	struct rdt_mon_domain *d =3D NULL;
 	int cpu;
=20
 	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
=20
-	if (hdr) {
-		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
-			return;
-		d =3D container_of(hdr, struct rdt_mon_domain, hdr);
-	}
-
 	/*
 	 * Setup the parameters to pass to mon_event_count() to read the data.
 	 */
 	rr->rgrp =3D rdtgrp;
 	rr->evtid =3D evtid;
 	rr->r =3D r;
-	rr->d =3D d;
+	rr->hdr =3D hdr;
 	rr->first =3D first;
 	if (resctrl_arch_mbm_cntr_assign_enabled(r) &&
 	    resctrl_is_mbm_event(evtid)) {
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 5e52269..9912b77 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -106,24 +106,26 @@ struct mon_data {
  *	   resource group then its event count is summed with the count from all
  *	   its child resource groups.
  * @r:	   Resource describing the properties of the event being read.
- * @d:	   Domain that the counter should be read from. If NULL then sum all
- *	   domains in @r sharing L3 @ci.id
+ * @hdr:   Header of domain that the counter should be read from. If NULL th=
en
+ *	   sum all domains in @r sharing L3 @ci.id
  * @evtid: Which monitor event to read.
  * @first: Initialize MBM counter when true.
- * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing dom=
ains.
+ * @ci:    Cacheinfo for L3. Only set when @hdr is NULL. Used when summing
+ *	   domains.
  * @is_mbm_cntr: true if "mbm_event" counter assignment mode is enabled and =
it
  *	   is an MBM event.
  * @err:   Error encountered when reading counter.
- * @val:   Returned value of event counter. If @rgrp is a parent resource gr=
oup,
- *	   @val includes the sum of event counts from its child resource groups.
- *	   If @d is NULL, @val includes the sum of all domains in @r sharing @ci.=
id,
- *	   (summed across child resource groups if @rgrp is a parent resource gro=
up).
+ * @val:   Returned value of event counter. If @rgrp is a parent resource
+ *	   group, @val includes the sum of event counts from its child
+ *	   resource groups.  If @hdr is NULL, @val includes the sum of all
+ *	   domains in @r sharing @ci.id, (summed across child resource groups
+ *	   if @rgrp is a parent resource group).
  * @arch_mon_ctx: Hardware monitor allocated for this read request (MPAM onl=
y).
  */
 struct rmid_read {
 	struct rdtgroup		*rgrp;
 	struct rdt_resource	*r;
-	struct rdt_mon_domain	*d;
+	struct rdt_domain_hdr	*hdr;
 	enum resctrl_event_id	evtid;
 	bool			first;
 	struct cacheinfo	*ci;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index b5e0db3..e1c1220 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -159,7 +159,7 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_f=
ree)
 			break;
=20
 		entry =3D __rmid_entry(idx);
-		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
+		if (resctrl_arch_rmid_read(r, &d->hdr, entry->closid, entry->rmid,
 					   QOS_L3_OCCUP_EVENT_ID, &val,
 					   arch_mon_ctx)) {
 			rmid_dirty =3D true;
@@ -421,11 +421,16 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp=
, struct rmid_read *rr)
 	struct rdt_mon_domain *d;
 	int cntr_id =3D -ENOENT;
 	struct mbm_state *m;
-	int err, ret;
 	u64 tval =3D 0;
=20
+	if (!domain_header_is_valid(rr->hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3)) {
+		rr->err =3D -EIO;
+		return -EINVAL;
+	}
+	d =3D container_of(rr->hdr, struct rdt_mon_domain, hdr);
+
 	if (rr->is_mbm_cntr) {
-		cntr_id =3D mbm_cntr_get(rr->r, rr->d, rdtgrp, rr->evtid);
+		cntr_id =3D mbm_cntr_get(rr->r, d, rdtgrp, rr->evtid);
 		if (cntr_id < 0) {
 			rr->err =3D -ENOENT;
 			return -EINVAL;
@@ -434,31 +439,50 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp=
, struct rmid_read *rr)
=20
 	if (rr->first) {
 		if (rr->is_mbm_cntr)
-			resctrl_arch_reset_cntr(rr->r, rr->d, closid, rmid, cntr_id, rr->evtid);
+			resctrl_arch_reset_cntr(rr->r, d, closid, rmid, cntr_id, rr->evtid);
 		else
-			resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
-		m =3D get_mbm_state(rr->d, closid, rmid, rr->evtid);
+			resctrl_arch_reset_rmid(rr->r, d, closid, rmid, rr->evtid);
+		m =3D get_mbm_state(d, closid, rmid, rr->evtid);
 		if (m)
 			memset(m, 0, sizeof(struct mbm_state));
 		return 0;
 	}
=20
-	if (rr->d) {
-		/* Reading a single domain, must be on a CPU in that domain. */
-		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
-			return -EINVAL;
-		if (rr->is_mbm_cntr)
-			rr->err =3D resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
-							 rr->evtid, &tval);
-		else
-			rr->err =3D resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
-							 rr->evtid, &tval, rr->arch_mon_ctx);
-		if (rr->err)
-			return rr->err;
+	/* Reading a single domain, must be on a CPU in that domain. */
+	if (!cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
+		return -EINVAL;
+	if (rr->is_mbm_cntr)
+		rr->err =3D resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
+						 rr->evtid, &tval);
+	else
+		rr->err =3D resctrl_arch_rmid_read(rr->r, rr->hdr, closid, rmid,
+						 rr->evtid, &tval, rr->arch_mon_ctx);
+	if (rr->err)
+		return rr->err;
=20
-		rr->val +=3D tval;
+	rr->val +=3D tval;
=20
-		return 0;
+	return 0;
+}
+
+static int __l3_mon_event_count_sum(struct rdtgroup *rdtgrp, struct rmid_rea=
d *rr)
+{
+	int cpu =3D smp_processor_id();
+	u32 closid =3D rdtgrp->closid;
+	u32 rmid =3D rdtgrp->mon.rmid;
+	struct rdt_mon_domain *d;
+	u64 tval =3D 0;
+	int err, ret;
+
+	/*
+	 * Summing across domains is only done for systems that implement
+	 * Sub-NUMA Cluster. There is no overlap with systems that support
+	 * assignable counters.
+	 */
+	if (rr->is_mbm_cntr) {
+		pr_warn_once("Summing domains using assignable counters is not supported\n=
");
+		rr->err =3D -EINVAL;
+		return -EINVAL;
 	}
=20
 	/* Summing domains that share a cache, must be on a CPU for that cache. */
@@ -476,12 +500,8 @@ static int __l3_mon_event_count(struct rdtgroup *rdtgrp,=
 struct rmid_read *rr)
 	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
 		if (d->ci_id !=3D rr->ci->id)
 			continue;
-		if (rr->is_mbm_cntr)
-			err =3D resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
-						     rr->evtid, &tval);
-		else
-			err =3D resctrl_arch_rmid_read(rr->r, d, closid, rmid,
-						     rr->evtid, &tval, rr->arch_mon_ctx);
+		err =3D resctrl_arch_rmid_read(rr->r, &d->hdr, closid, rmid,
+					     rr->evtid, &tval, rr->arch_mon_ctx);
 		if (!err) {
 			rr->val +=3D tval;
 			ret =3D 0;
@@ -498,7 +518,10 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, st=
ruct rmid_read *rr)
 {
 	switch (rr->r->rid) {
 	case RDT_RESOURCE_L3:
-		return __l3_mon_event_count(rdtgrp, rr);
+		if (rr->hdr)
+			return __l3_mon_event_count(rdtgrp, rr);
+		else
+			return __l3_mon_event_count_sum(rdtgrp, rr);
 	default:
 		rr->err =3D -EINVAL;
 		return -EINVAL;
@@ -522,9 +545,13 @@ static void mbm_bw_count(struct rdtgroup *rdtgrp, struct=
 rmid_read *rr)
 	u64 cur_bw, bytes, cur_bytes;
 	u32 closid =3D rdtgrp->closid;
 	u32 rmid =3D rdtgrp->mon.rmid;
+	struct rdt_mon_domain *d;
 	struct mbm_state *m;
=20
-	m =3D get_mbm_state(rr->d, closid, rmid, rr->evtid);
+	if (!domain_header_is_valid(rr->hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+		return;
+	d =3D container_of(rr->hdr, struct rdt_mon_domain, hdr);
+	m =3D get_mbm_state(d, closid, rmid, rr->evtid);
 	if (WARN_ON_ONCE(!m))
 		return;
=20
@@ -697,7 +724,7 @@ static void mbm_update_one_event(struct rdt_resource *r, =
struct rdt_mon_domain *
 	struct rmid_read rr =3D {0};
=20
 	rr.r =3D r;
-	rr.d =3D d;
+	rr.hdr =3D &d->hdr;
 	rr.evtid =3D evtid;
 	if (resctrl_arch_mbm_cntr_assign_enabled(r)) {
 		rr.is_mbm_cntr =3D true;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5db37c7..9b9877f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -517,7 +517,7 @@ void resctrl_offline_cpu(unsigned int cpu);
  * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
  *			      for this resource and domain.
  * @r:			resource that the counter should be read from.
- * @d:			domain that the counter should be read from.
+ * @hdr:		Header of domain that the counter should be read from.
  * @closid:		closid that matches the rmid. Depending on the architecture, the
  *			counter may match traffic of both @closid and @rmid, or @rmid
  *			only.
@@ -538,7 +538,7 @@ void resctrl_offline_cpu(unsigned int cpu);
  * Return:
  * 0 on success, or -EIO, -EINVAL etc on error.
  */
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hd=
r,
 			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *arch_mon_ctx);
=20


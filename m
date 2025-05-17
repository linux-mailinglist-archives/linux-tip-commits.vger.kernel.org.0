Return-Path: <linux-tip-commits+bounces-5648-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ADDABA95B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5381B65996
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45055202C44;
	Sat, 17 May 2025 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zac/Cri+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XGDMaVSe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC001FFC48;
	Sat, 17 May 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476183; cv=none; b=kpIrgdHZYeYOlBUkqzgMT82Lqt3v7AFslIYBVJ3i0NX/uURaGTOEpTaTOihWAlyXOGY0bqlmRiwyTqtMAVQYdllsBB4qwnxxnscHJm3O/GzqeHa6h1Jclr72lppeUwQixv9h8aLEpdIlhbaJL6AFBDHjaSQRAyjF4Nman63wbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476183; c=relaxed/simple;
	bh=0SRwfn1qBdMcQ2pl6r6zoRvV1QQZuOTWvxB7T2b6pEU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c+uJbXK7q6ryKYtFKwmKEGoLuBoEnvp0u6rC+ks+enkmQKlQigpv/mI0tJBb77oTVjCw0C8fWSTZVrMjBSUI1hqdRAGlF1KJk4cWhHRuvNl6XAGtSL6XL+tq5Caup6sQxqIRPa3MIoCnlNhx8YzE/jjj9BkTFSxjedEVLUiZ+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zac/Cri+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XGDMaVSe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnxVyQJ96En3jyfL1fx2wIslNi3KpjjPvoXW2Oonsd4=;
	b=zac/Cri+hUbmWdQAarZ2Bzaydv+WtVNC5cukivT32uJnDVfd9Zq9jZLKpzugW9HsPJ/7rY
	Mb7YMsurBTznVzf9j9sbo8x9S6u6+2kMRavbtgOYOXxSZCUnEkSPdgnTFFxRIE/avOIrq4
	2CiDI/J5hyUeOfzRPlbqYcGICQHZ1ovS2Dgpg/7m97BK6Jh0lZnFAewdjpE6p10hM3afyL
	mlvFtIxu1/i1f45EhGTLalDOvq9i1H2j3/RSGW5U6yqp8n25cSfh7olgiJwXgN7g0S4yN/
	vpa7fibLQlGXgwxI/n1fMe/Hx5pa+GX5xmZJLJ0Fdnd8EwDhVI2bt8SsANUtfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnxVyQJ96En3jyfL1fx2wIslNi3KpjjPvoXW2Oonsd4=;
	b=XGDMaVSe9eEGJQZGtKX7cW9rYhRR5uN1MgT1hRkopBdvNXBs0OGZqorwBT314dO7CMUJ2P
	iNSkUHYh3r8ooRCg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Expand the width of domid by replacing
 mon_data_bits
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-13-james.morse@arm.com>
References: <20250515165855.31452-13-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747617850.406.17426651359690062441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2a65660385444e9d9deffe995c71ee20443ef76e
Gitweb:        https://git.kernel.org/tip/2a65660385444e9d9deffe995c71ee20443ef76e
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:42 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 10:46:45 +02:00

x86/resctrl: Expand the width of domid by replacing mon_data_bits

MPAM platforms retrieve the cache-id property from the ACPI PPTT table.
The cache-id field is 32 bits wide. Under resctrl, the cache-id becomes
the domain-id, and is packed into the mon_data_bits union bitfield.
The width of cache-id in this field is 14 bits.

Expanding the union would break 32bit x86 platforms as this union is
stored as the kernfs kn->priv pointer. This saved allocating memory
for the priv data storage.

The firmware on MPAM platforms have used the PPTT cache-id field to
expose the interconnect's id for the cache, which is sparse and uses
more than 14 bits. Use of this id is to enable PCIe direct cache
injection hints. Using this feature with VFIO means the value provided
by the ACPI table should be exposed to user-space.

To support cache-id values greater than 14 bits, convert the
mon_data_bits union to a structure. These are shared between control
and monitor groups, and are allocated on first use. The list of
allocated struct mon_data is free'd when the filesystem is umount()ed.

Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-13-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 24 ++++---
 arch/x86/kernel/cpu/resctrl/internal.h    | 39 +++++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 79 ++++++++++++++++++++--
 3 files changed, 106 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 0a0ac5f..110b534 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -661,14 +661,15 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
+	enum resctrl_res_level resid;
+	enum resctrl_event_id evtid;
 	struct rdt_domain_hdr *hdr;
 	struct rmid_read rr = {0};
 	struct rdt_mon_domain *d;
-	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
-	union mon_data_bits md;
-	int ret = 0;
+	struct mon_data *md;
+	int domid, ret = 0;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -676,17 +677,22 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		goto out;
 	}
 
-	md.priv = of->kn->priv;
-	resid = md.u.rid;
-	domid = md.u.domid;
-	evtid = md.u.evtid;
+	md = of->kn->priv;
+	if (WARN_ON_ONCE(!md)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	resid = md->rid;
+	domid = md->domid;
+	evtid = md->evtid;
 	r = resctrl_arch_get_resource(resid);
 
-	if (md.u.sum) {
+	if (md->sum) {
 		/*
 		 * This file requires summing across all domains that share
 		 * the L3 cache id that was provided in the "domid" field of the
-		 * mon_data_bits union. Search all domains in the resource for
+		 * struct mon_data. Search all domains in the resource for
 		 * one that matches this cache id.
 		 */
 		list_for_each_entry(d, &r->mon_domains, hdr.list) {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 576383a..01cb0ff 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -89,27 +89,26 @@ struct mon_evt {
 };
 
 /**
- * union mon_data_bits - Monitoring details for each event file.
- * @priv:              Used to store monitoring event data in @u
- *                     as kernfs private data.
- * @u.rid:             Resource id associated with the event file.
- * @u.evtid:           Event id associated with the event file.
- * @u.sum:             Set when event must be summed across multiple
- *                     domains.
- * @u.domid:           When @u.sum is zero this is the domain to which
- *                     the event file belongs. When @sum is one this
- *                     is the id of the L3 cache that all domains to be
- *                     summed share.
- * @u:                 Name of the bit fields struct.
+ * struct mon_data - Monitoring details for each event file.
+ * @list:            Member of the global @mon_data_kn_priv_list list.
+ * @rid:             Resource id associated with the event file.
+ * @evtid:           Event id associated with the event file.
+ * @sum:             Set when event must be summed across multiple
+ *                   domains.
+ * @domid:           When @sum is zero this is the domain to which
+ *                   the event file belongs. When @sum is one this
+ *                   is the id of the L3 cache that all domains to be
+ *                   summed share.
+ *
+ * Pointed to by the kernfs kn->priv field of monitoring event files.
+ * Readers and writers must hold rdtgroup_mutex.
  */
-union mon_data_bits {
-	void *priv;
-	struct {
-		unsigned int rid		: 10;
-		enum resctrl_event_id evtid	: 7;
-		unsigned int sum		: 1;
-		unsigned int domid		: 14;
-	} u;
+struct mon_data {
+	struct list_head	list;
+	enum resctrl_res_level	rid;
+	enum resctrl_event_id	evtid;
+	int			domid;
+	bool			sum;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e2999f6..d480784 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -45,6 +45,12 @@ LIST_HEAD(rdt_all_groups);
 /* list of entries for the schemata file */
 LIST_HEAD(resctrl_schema_all);
 
+/*
+ * List of struct mon_data containing private data of event files for use by
+ * rdtgroup_mondata_show(). Protected by rdtgroup_mutex.
+ */
+static LIST_HEAD(mon_data_kn_priv_list);
+
 /* The filesystem can only be mounted once. */
 bool resctrl_mounted;
 
@@ -3093,6 +3099,63 @@ static void rmdir_all_sub(void)
 	kernfs_remove(kn_mondata);
 }
 
+/**
+ * mon_get_kn_priv() - Get the mon_data priv data for this event.
+ *
+ * The same values are used across the mon_data directories of all control and
+ * monitor groups for the same event in the same domain. Keep a list of
+ * allocated structures and re-use an existing one with the same values for
+ * @rid, @domid, etc.
+ *
+ * @rid:    The resource id for the event file being created.
+ * @domid:  The domain id for the event file being created.
+ * @mevt:   The type of event file being created.
+ * @do_sum: Whether SNC summing monitors are being created.
+ */
+static struct mon_data *mon_get_kn_priv(enum resctrl_res_level rid, int domid,
+					struct mon_evt *mevt,
+					bool do_sum)
+{
+	struct mon_data *priv;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	list_for_each_entry(priv, &mon_data_kn_priv_list, list) {
+		if (priv->rid == rid && priv->domid == domid &&
+		    priv->sum == do_sum && priv->evtid == mevt->evtid)
+			return priv;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	priv->rid = rid;
+	priv->domid = domid;
+	priv->sum = do_sum;
+	priv->evtid = mevt->evtid;
+	list_add_tail(&priv->list, &mon_data_kn_priv_list);
+
+	return priv;
+}
+
+/**
+ * mon_put_kn_priv() - Free all allocated mon_data structures.
+ *
+ * Called when resctrl file system is unmounted.
+ */
+static void mon_put_kn_priv(void)
+{
+	struct mon_data *priv, *tmp;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	list_for_each_entry_safe(priv, tmp, &mon_data_kn_priv_list, list) {
+		list_del(&priv->list);
+		kfree(priv);
+	}
+}
+
 static void resctrl_fs_teardown(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
@@ -3102,6 +3165,7 @@ static void resctrl_fs_teardown(void)
 		return;
 
 	rmdir_all_sub();
+	mon_put_kn_priv();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
 	closid_exit();
@@ -3208,19 +3272,20 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
 			     bool do_sum)
 {
 	struct rmid_read rr = {0};
-	union mon_data_bits priv;
+	struct mon_data *priv;
 	struct mon_evt *mevt;
-	int ret;
+	int ret, domid;
 
 	if (WARN_ON(list_empty(&r->evt_list)))
 		return -EPERM;
 
-	priv.u.rid = r->rid;
-	priv.u.domid = do_sum ? d->ci->id : d->hdr.id;
-	priv.u.sum = do_sum;
 	list_for_each_entry(mevt, &r->evt_list, list) {
-		priv.u.evtid = mevt->evtid;
-		ret = mon_addfile(kn, mevt->name, priv.priv);
+		domid = do_sum ? d->ci->id : d->hdr.id;
+		priv = mon_get_kn_priv(r->rid, domid, mevt, do_sum);
+		if (WARN_ON_ONCE(!priv))
+			return -EINVAL;
+
+		ret = mon_addfile(kn, mevt->name, priv);
 		if (ret)
 			return ret;
 


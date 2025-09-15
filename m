Return-Path: <linux-tip-commits+bounces-6624-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F53AB5784D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0BA204D71
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2DC305E29;
	Mon, 15 Sep 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fyOAxgU2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HzjaCZVi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E260305076;
	Mon, 15 Sep 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935670; cv=none; b=OligRVgTeArF0TOebfbHt6qciTt00s9cRwZuU4IHKWUQQkCyLqfEs0cnE1g4xjo5wNUtB68uS/CdCCKhI2mLFbuG4eJa/rqzSexzvVXxO+d8BPrScyusNh485AYF+s+8Feur2+I16ljwKFmSd9Xd07YNa8vuPdY7Uu+SO9RgD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935670; c=relaxed/simple;
	bh=jAhCrrc7s4tKj4DwXI2pKhz5y9KKs25quEPQGn1bDos=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IuRkhllxtNDmwwzKmaWq92xIkpA+VkAVJ5HwFrlIFPoiJnihfFm7OLSbn4htjK2FpZ9HE/QS6QHBTLlPFYZVWYGJ+JYfLS9ZFq0B2SQyxwWmyKdO7zOn7X9WV2jcK+rPJ389hI/r2R+c+nfUdB9i5AhTcDTwaLCQYWeG+tRRUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fyOAxgU2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HzjaCZVi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935664;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsZ7ik7a5BeRfgDXQ5qeVaC/qZSQRbV/mdbryF8MlRU=;
	b=fyOAxgU2KzdRxC6cmOzz4CKs1bO78CE6fpzZlPGZAAU/9mExEJk3c49RgylOdDNLqjkff+
	EgjHLANnZp/5OxYb+3fz19i3uxXZ2O9No4Ap8bPfLYulQD6PS0OuAMfx9V+KYX1xEagDV1
	mvFFpns2kG7jC4uhdxYdxEyttRoOF6zZ44Kq0n6TZ0PeQDYugWCTHCLCkqjujHcofZmOcH
	xkklfIlneGd0ixvGm3AOQ12WW/SiAAhY0PhX73dKl5zAqNeSjStEZO+ugJJLNWPy7LO/Db
	RehoQ00m+KHwAZWo/3pXOjxvgl7aG4qLYQI83So4SpxpHMnlkM+f6E64wUKGyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935664;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsZ7ik7a5BeRfgDXQ5qeVaC/qZSQRbV/mdbryF8MlRU=;
	b=HzjaCZVizenj2dSxJtA3aFlvv0OTJVrf7bB2YTqGg9XyL9GTvZmOJufaUscc/sKYmatHPR
	PFT3ZAnSwN1S15Cg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Introduce mbm_cntr_cfg to track
 assignable counters per domain
Cc: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <c11ea8f305e3f72032e1b8f8cf292959189e0c12.1757108044.git.babu.moger@amd.com>
References:
 <c11ea8f305e3f72032e1b8f8cf292959189e0c12.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793566350.709179.17586685149927345001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     4d32c24a74f2c12ff440d381ba01de574f6631ce
Gitweb:        https://git.kernel.org/tip/4d32c24a74f2c12ff440d381ba01de574f6=
631ce
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:11 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:13:16 +02:00

fs/resctrl: Introduce mbm_cntr_cfg to track assignable counters per domain

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor bandwidth usage as long as it is
assigned.  The hardware continues to track the assigned counter until it is
explicitly unassigned by the user. Counters are assigned/unassigned at
monitoring domain level.

Manage a monitoring domain's hardware counters using a per monitoring
domain array of struct mbm_cntr_cfg that is indexed by the hardware
counter ID. A hardware counter's configuration contains the MBM event
ID and points to the monitoring group that it is assigned to, with a NULL
pointer meaning that the hardware counter is available for assignment.

There is no direct way to determine which hardware counters are assigned
to a particular monitoring group. Check every entry of every hardware
counter configuration array in every monitoring domain to query which
MBM events of a monitoring group is tracked by hardware. Such queries are
acceptable because of a very small number of assignable counters (32
to 64).

Suggested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 fs/resctrl/rdtgroup.c   |  8 ++++++++
 include/linux/resctrl.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 9d95d01..61f7b68 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4029,6 +4029,7 @@ static void domain_destroy_mon_state(struct rdt_mon_dom=
ain *d)
 {
 	int idx;
=20
+	kfree(d->cntr_cfg);
 	bitmap_free(d->rmid_busy_llc);
 	for_each_mbm_idx(idx) {
 		kfree(d->mbm_states[idx]);
@@ -4112,6 +4113,13 @@ static int domain_setup_mon_state(struct rdt_resource =
*r, struct rdt_mon_domain=20
 			goto cleanup;
 	}
=20
+	if (resctrl_is_mbm_enabled() && r->mon.mbm_cntr_assignable) {
+		tsize =3D sizeof(*d->cntr_cfg);
+		d->cntr_cfg =3D kcalloc(r->mon.num_mbm_cntrs, tsize, GFP_KERNEL);
+		if (!d->cntr_cfg)
+			goto cleanup;
+	}
+
 	return 0;
 cleanup:
 	bitmap_free(d->rmid_busy_llc);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 9198061..e013cab 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -157,6 +157,18 @@ struct rdt_ctrl_domain {
 };
=20
 /**
+ * struct mbm_cntr_cfg - Assignable counter configuration.
+ * @evtid:		MBM event to which the counter is assigned. Only valid
+ *			if @rdtgroup is not NULL.
+ * @rdtgrp:		resctrl group assigned to the counter. NULL if the
+ *			counter is free.
+ */
+struct mbm_cntr_cfg {
+	enum resctrl_event_id	evtid;
+	struct rdtgroup		*rdtgrp;
+};
+
+/**
  * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor resource
  * @hdr:		common header for different domain types
  * @ci_id:		cache info id for this domain
@@ -168,6 +180,8 @@ struct rdt_ctrl_domain {
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
+ * @cntr_cfg:		array of assignable counters' configuration (indexed
+ *			by counter ID)
  */
 struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
@@ -178,6 +192,7 @@ struct rdt_mon_domain {
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
+	struct mbm_cntr_cfg		*cntr_cfg;
 };
=20
 /**


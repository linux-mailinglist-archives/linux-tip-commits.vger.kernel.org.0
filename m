Return-Path: <linux-tip-commits+bounces-7841-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F71D0DC2E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 600563011985
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0713D29A322;
	Sat, 10 Jan 2026 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m+u/2zyW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ur/8fJsY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCF2777E0;
	Sat, 10 Jan 2026 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074363; cv=none; b=CfF782j0yozq9qJVKPnDj106IEY2HsN8r0HUlIWHn/Nn+nnfLir+5+jkUQk64U3SOjx+gwgcOmrmOxnOpRk2zdCgVZEWAJvJbd6qJBS1O4XscR/gkgFdR3QS5BFH8yNfGU2Xd8KkvRI/9RnnxWpYDQVSNzrl09k2/iqSVWFJhbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074363; c=relaxed/simple;
	bh=Lsg5F+gqNr5p0nePREmUzaD5eF8vki+79t25nUlNsYw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=powUaXCnPyfKQxMQPatelagB8CIQd8gkp1n4cpT8vxBq327zaVD3+a/QhRrPLdam1EGCBsVnG0/QuEEs0Ur3ZDXPguWgtaziFf9sNhOI/lI9WvO2TJNfiXq4ybCdZpE/i9R/nDRkneSuK397EVz3L9cFv74BCfvrqTi0Uuw6owM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m+u/2zyW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ur/8fJsY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:45:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074354;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=02JMhiMjrnW3rS1KlTRYepU6N6IU3t+z4JM0H7GIuG0=;
	b=m+u/2zyW/ioJLjEGfxDhvx9k89Xt0pvAopJWPjvwywc5TliO41Jo8a9cnwQsnVM4apakvs
	UCX0l6aaGbsBsd2fP0mrHCSMmGgJ11Wh7A5xU3UfK17msqFZ7j6KlftsLk1rkTl+KkXHxV
	+Hs9IxcBUUf6ebCG+8X/E/hRscZEWqDz3a5ZnjZypQ7RNq4Iz0O+0ENjmq/9KpElntPaIm
	Sqcj8SNxndNgrNEIoeS6Guv4LOXwhx4bihSEi4GMMUNGn5dJcaiacutfTE8byMF+bAMZEQ
	14SBZUl73r+yRZ41xdMRM+U3/WVUkhOk+QywtqwLnEgg/T/Z8aElH4pL4bd6Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074354;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=02JMhiMjrnW3rS1KlTRYepU6N6IU3t+z4JM0H7GIuG0=;
	b=ur/8fJsYeTK2fo5t4v/HKzbW+ShD74142sOsEkto6rzS/SFjvTeLTfBzNfGE3yMHw5u351
	j8Z/JdBqJgfDLiAg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Compute number of RMIDs as minimum
 across resources
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807435347.510.6488635991773829032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     0ecc988b0232259cbdb2b7e452bda74f550f0911
Gitweb:        https://git.kernel.org/tip/0ecc988b0232259cbdb2b7e452bda74f550=
f0911
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:14 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 10 Jan 2026 11:43:58 +01:00

x86,fs/resctrl: Compute number of RMIDs as minimum across resources

resctrl assumes that only the L3 resource supports monitor events, so it
simply takes the rdt_resource::num_rmid from RDT_RESOURCE_L3 as the system's
number of RMIDs.

The addition of telemetry events in a different resource breaks that
assumption.

Compute the number of available RMIDs as the minimum value across all
mon_capable resources (analogous to how the number of CLOSIDs is computed
across alloc_capable resources).

Note that mount time enumeration of the telemetry resource means that
this number can be reduced. If this happens, then some memory will
be wasted as the allocations for rdt_l3_mon_domain::mbm_states[] and
rdt_l3_mon_domain::rmid_busy_llc created during resctrl initialization will
be larger than needed.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 15 +++++++++++++--
 fs/resctrl/rdtgroup.c              |  6 ++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index e38d7fc..0da44ca 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -110,12 +110,23 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOUR=
CES] =3D {
 	},
 };
=20
+/**
+ * resctrl_arch_system_num_rmid_idx - Compute number of supported RMIDs
+ *				      (minimum across all mon_capable resource)
+ *
+ * Return: Number of supported RMIDs at time of call. Note that mount time
+ * enumeration of resources may reduce the number.
+ */
 u32 resctrl_arch_system_num_rmid_idx(void)
 {
-	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	u32 num_rmids =3D U32_MAX;
+	struct rdt_resource *r;
+
+	for_each_mon_capable_rdt_resource(r)
+		num_rmids =3D min(num_rmids, r->mon.num_rmid);
=20
 	/* RMID are independent numbers for x86. num_rmid_idx =3D=3D num_rmid */
-	return r->mon.num_rmid;
+	return num_rmids =3D=3D U32_MAX ? 0 : num_rmids;
 }
=20
 struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 90c4a19..666cac7 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4353,6 +4353,12 @@ out_unlock:
  * During boot this may be called before global allocations have been made by
  * resctrl_l3_mon_resource_init().
  *
+ * Called during CPU online that may run as soon as CPU online callbacks
+ * are set up during resctrl initialization. The number of supported RMIDs
+ * may be reduced if additional mon_capable resources are enumerated
+ * at mount time. This means the rdt_l3_mon_domain::mbm_states[] and
+ * rdt_l3_mon_domain::rmid_busy_llc allocations may be larger than needed.
+ *
  * Return: 0 for success, or -ENOMEM.
  */
 static int domain_setup_l3_mon_state(struct rdt_resource *r, struct rdt_l3_m=
on_domain *d)


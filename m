Return-Path: <linux-tip-commits+bounces-7849-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F68D0DC70
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E60C4307CECC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EA92D9481;
	Sat, 10 Jan 2026 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mX0x4IYU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bcOVS+XE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB52459EA;
	Sat, 10 Jan 2026 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074369; cv=none; b=Utzb1c3v9LPcDWkDInW2kY9RYazQ+0cUf/aIxa53uct6yHO5JQQxsWoeyDwSpGuvgmtZgvuTsp7UpGMcRuVfRAvKm1YHnzth7iNsy9u8VJFVbh68rCMiaEdg1vsQFdBvpGLbZMIxRsnqySTXdHOhyHCnnRDvTngOyh/ZoXUg+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074369; c=relaxed/simple;
	bh=QPzRkK6+6KBSL32+2LPiLAj7gx3fodyUyE6AQ1rzJVw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=LORtk3bjwjwUes+/zjNn4koR771yAjPugQ/zIE6CIJKnKMzt127KHQw7nw12XM/P71umV7s7bDBEKYNhF/q3jTwRszNMEcAKnUr/zN8bkBMkWF3pjWeLLxWaSbPfh7xQ2oy0DCq2j5f5bs9apiY832ZzWWbqWJw/eMHiRmaM4T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mX0x4IYU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bcOVS+XE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074362;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Yrhhz6qWeNxzwCFzGZyfwuSPwiC9uWPM6bKYVUPWgQ8=;
	b=mX0x4IYUWElYykOlbkoe2R++x6GieF25xv70rHFaaXDtvldFcZbb7DBRdRYUrLZdme8OdE
	xtfD/Uf9sBCwdoNVaZSFcktL4G4e4dawaUzWwST9+kzxH7+T9sAcrzasE8p6+niEfMVidV
	f3fyv0RHDhu4EupbmmvL5mXy7QVsAKDtcmFqW+mrdxybJ1MiFnkh/zVvYgHkeu4YKtk0L/
	1HjED0KlSbSsPhDJKPDyLQ3ZMmVCxAPRC/PxmJ0wFwGaAFyRIUW1EdgkXsNE9hWjCUaGfT
	6GdTjo+thX0BgLBpG+SDAo5AGD3l73zgjTcNPv5D/y1UUSqUnrtVVdaFiv77eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074362;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Yrhhz6qWeNxzwCFzGZyfwuSPwiC9uWPM6bKYVUPWgQ8=;
	b=bcOVS+XEkThLcvXOtrR0BeAB+Fp2RmMVTpwGAnuesitEcxioookg4Y2NJcVu/VpbkSuljP
	L3Gf/HKwKiOx+7Cw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Read telemetry events
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807436091.510.4406725397186849830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     51541f6ca7718d8278e12fe80af80033268743b2
Gitweb:        https://git.kernel.org/tip/51541f6ca7718d8278e12fe80af80033268=
743b2
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:07 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 23:02:57 +01:00

x86/resctrl: Read telemetry events

Introduce intel_aet_read_event() to read telemetry events for resource
RDT_RESOURCE_PERF_PKG. There may be multiple aggregators tracking each
package, so scan all of them and add up all counters. Aggregators may return
an invalid data indication if they have received no records for a given RMID.
The user will see "Unavailable" if none of the aggregators on a package
provide valid counts.

Resctrl now uses readq() so depends on X86_64. Update Kconfig.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/Kconfig                        |  2 +-
 arch/x86/kernel/cpu/resctrl/intel_aet.c | 51 ++++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h  |  5 ++-
 arch/x86/kernel/cpu/resctrl/monitor.c   |  4 ++-
 fs/resctrl/monitor.c                    | 14 +++++++-
 5 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0d874a9..c25ea0f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -542,7 +542,7 @@ config X86_CPU_RESCTRL
=20
 config X86_CPU_RESCTRL_INTEL_AET
 	bool "Intel Application Energy Telemetry"
-	depends on X86_CPU_RESCTRL && CPU_SUP_INTEL && INTEL_PMT_TELEMETRY=3Dy && I=
NTEL_TPMI=3Dy
+	depends on X86_64 && X86_CPU_RESCTRL && CPU_SUP_INTEL && INTEL_PMT_TELEMETR=
Y=3Dy && INTEL_TPMI=3Dy
 	help
 	  Enable per-RMID telemetry events in resctrl.
=20
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/re=
sctrl/intel_aet.c
index 7d0bd7b..96d627e 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -11,11 +11,15 @@
=20
 #define pr_fmt(fmt)   "resctrl: " fmt
=20
+#include <linux/bits.h>
 #include <linux/compiler_types.h>
+#include <linux/container_of.h>
 #include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/intel_pmt_features.h>
 #include <linux/intel_vsec.h>
+#include <linux/io.h>
 #include <linux/printk.h>
 #include <linux/resctrl.h>
 #include <linux/resctrl_types.h>
@@ -232,3 +236,50 @@ void __exit intel_aet_exit(void)
 		}
 	}
 }
+
+#define DATA_VALID	BIT_ULL(63)
+#define DATA_BITS	GENMASK_ULL(62, 0)
+
+/*
+ * Read counter for an event on a domain (summing all aggregators on the
+ * domain). If an aggregator hasn't received any data for a specific RMID,
+ * the MMIO read indicates that data is not valid.  Return success if at
+ * least one aggregator has valid data.
+ */
+int intel_aet_read_event(int domid, u32 rmid, void *arch_priv, u64 *val)
+{
+	struct pmt_event *pevt =3D arch_priv;
+	struct event_group *e;
+	bool valid =3D false;
+	u64 total =3D 0;
+	u64 evtcount;
+	void *pevt0;
+	u32 idx;
+
+	pevt0 =3D pevt - pevt->idx;
+	e =3D container_of(pevt0, struct event_group, evts);
+	idx =3D rmid * e->num_events;
+	idx +=3D pevt->idx;
+
+	if (idx * sizeof(u64) + sizeof(u64) > e->mmio_size) {
+		pr_warn_once("MMIO index %u out of range\n", idx);
+		return -EIO;
+	}
+
+	for (int i =3D 0; i < e->pfg->count; i++) {
+		if (!e->pfg->regions[i].addr)
+			continue;
+		if (e->pfg->regions[i].plat_info.package_id !=3D domid)
+			continue;
+		evtcount =3D readq(e->pfg->regions[i].addr + idx * sizeof(u64));
+		if (!(evtcount & DATA_VALID))
+			continue;
+		total +=3D evtcount & DATA_BITS;
+		valid =3D true;
+	}
+
+	if (valid)
+		*val =3D total;
+
+	return valid ? 0 : -EINVAL;
+}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index f2e6e35..10743f5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -225,9 +225,14 @@ void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_res=
ource *r);
 #ifdef CONFIG_X86_CPU_RESCTRL_INTEL_AET
 bool intel_aet_get_events(void);
 void __exit intel_aet_exit(void);
+int intel_aet_read_event(int domid, u32 rmid, void *arch_priv, u64 *val);
 #else
 static inline bool intel_aet_get_events(void) { return false; }
 static inline void __exit intel_aet_exit(void) { }
+static inline int intel_aet_read_event(int domid, u32 rmid, void *arch_priv,=
 u64 *val)
+{
+	return -EINVAL;
+}
 #endif
=20
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 6929614..e6a1542 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -251,6 +251,10 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struc=
t rdt_domain_hdr *hdr,
 	int ret;
=20
 	resctrl_arch_rmid_read_context_check();
+
+	if (r->rid =3D=3D RDT_RESOURCE_PERF_PKG)
+		return intel_aet_read_event(hdr->id, rmid, arch_priv, val);
+
 	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
 		return -EINVAL;
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 9af08b6..8a4c2ae 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -527,6 +527,20 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, st=
ruct rmid_read *rr)
 			return __l3_mon_event_count(rdtgrp, rr);
 		else
 			return __l3_mon_event_count_sum(rdtgrp, rr);
+	case RDT_RESOURCE_PERF_PKG: {
+		u64 tval =3D 0;
+
+		rr->err =3D resctrl_arch_rmid_read(rr->r, rr->hdr, rdtgrp->closid,
+						 rdtgrp->mon.rmid, rr->evt->evtid,
+						 rr->evt->arch_priv,
+						 &tval, rr->arch_mon_ctx);
+		if (rr->err)
+			return rr->err;
+
+		rr->val +=3D tval;
+
+		return 0;
+	}
 	default:
 		rr->err =3D -EINVAL;
 		return -EINVAL;


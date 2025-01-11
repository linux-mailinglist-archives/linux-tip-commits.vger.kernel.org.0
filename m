Return-Path: <linux-tip-commits+bounces-3203-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A4A0A3DF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Jan 2025 14:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFE97A239D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Jan 2025 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7399A1A8F7F;
	Sat, 11 Jan 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="auorwwXL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5S/4pfPf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D1199921;
	Sat, 11 Jan 2025 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601723; cv=none; b=Z9iaaBDwZoR7EonRHCLuXOZCfPFMxiKsFh1REjW2Vlz9qToQZhaN62xZcxAAxm9SatZk4zk/9Z5p5Fqwro8BjxrqrSohigxbIAUBZ9zlVjEIJ4pNo6E7z3HVWAE88i1kREiTNjy8o6GHuyQT5zwmKrQcNxgNaOzXl+I6I3Z7y2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601723; c=relaxed/simple;
	bh=P2YB1rx3c2OJdK43Ueb/GYWH07Z3mwP2t999lRoM8rE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bfw3LN5in1RkiZ4NDXkvGzNdRrJx1WlVutfTcN8Wj4khkp+lejXTkRCXkNGK7tmnb+PZsdvtWeFEzRinXFkO2lQmWIY/NUHbQqYszqyqLadlCR2lD+9op8VEI4cdpsJDmcHnAuQ0tsxkhX6z6WN3D/2xnsl8X8if5Sj++alNlh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=auorwwXL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5S/4pfPf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 11 Jan 2025 13:21:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736601718;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yi/dzC69hcceot4/94r64O3/1x3QiFDGqzHye90Jyr4=;
	b=auorwwXLmcRiwXANT+9o8kyHIwEO5p4JnX/L9BdFmtMrhg5JxMWodCwCuYYKzznf0KOQP8
	INZeQi91MO0zl2/gJm1KqJobi+D+XOLUvyxKyCfGddjOz4hkE0D8G78QPdRpE+zQPKdYBr
	RWTajwNLIe71ah76QW6SzhpUPNZ7JUeyY6IxR6+WfNHTJbt0/+qM4zzU2YSx0boZV80FKC
	0cjBK1c8i6ElpJRZM3hq5SxLZhNu0K2zedpzNcOeTDqRj7/YNLVuRD4dc9Cb3/TPJyMvEO
	2tLv6v56uaLUTisUUQVbcumJRUhPIrnq8g7E7wicKizVggCdRAOwJaRUDx6KOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736601718;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yi/dzC69hcceot4/94r64O3/1x3QiFDGqzHye90Jyr4=;
	b=5S/4pfPf9uNF2iuDnpJltJmfb7AWj7RduTqvqF3c+S1sBI3b5HoQgGgnSsrXRvKJzCX//m
	Whyy7GHQDMxPLyCA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Clean up func_id
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Eric Hu <eric.hu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250108143017.1793781-1-kan.liang@linux.intel.com>
References: <20250108143017.1793781-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173660171833.399.6020197243844358296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3f710be02ea648001ba18fb2c9fa7765e743dec2
Gitweb:        https://git.kernel.org/tip/3f710be02ea648001ba18fb2c9fa7765e743dec2
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 08 Jan 2025 06:30:16 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jan 2025 18:16:50 +01:00

perf/x86/intel/uncore: Clean up func_id

The below warning may be triggered on GNR when the PCIE uncore units are
exposed.

WARNING: CPU: 4 PID: 1 at arch/x86/events/intel/uncore.c:1169 uncore_pci_pmu_register+0x158/0x190

The current uncore driver assumes that all the devices in the same PMU
have the exact same devfn. It's true for the previous platforms. But it
doesn't work for the new PCIE uncore units on GNR.

The assumption doesn't make sense. There is no reason to limit the
devices from the same PMU to the same devfn. Also, the current code just
throws the warning, but still registers the device. The WARN_ON_ONCE()
should be removed.

The func_id is used by the later event_init() to check if a event->pmu
has valid devices. For cpu and mmio uncore PMUs, they are always valid.
For pci uncore PMUs, it's set when the PMU is registered. It can be
replaced by the pmu->registered. Clean up the func_id.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Eric Hu <eric.hu@intel.com>
Link: https://lkml.kernel.org/r/20250108143017.1793781-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c     | 20 +++++++-------------
 arch/x86/events/intel/uncore.h     |  1 -
 arch/x86/events/intel/uncore_snb.c |  2 +-
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d98fac5..24372cf 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -745,7 +745,7 @@ static int uncore_pmu_event_init(struct perf_event *event)
 
 	pmu = uncore_event_to_pmu(event);
 	/* no device found for this pmu */
-	if (pmu->func_id < 0)
+	if (!pmu->registered)
 		return -ENOENT;
 
 	/* Sampling not supported yet */
@@ -992,7 +992,7 @@ static void uncore_types_exit(struct intel_uncore_type **types)
 		uncore_type_exit(*types);
 }
 
-static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
+static int __init uncore_type_init(struct intel_uncore_type *type)
 {
 	struct intel_uncore_pmu *pmus;
 	size_t size;
@@ -1005,7 +1005,6 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 	size = uncore_max_dies() * sizeof(struct intel_uncore_box *);
 
 	for (i = 0; i < type->num_boxes; i++) {
-		pmus[i].func_id	= setid ? i : -1;
 		pmus[i].pmu_idx	= i;
 		pmus[i].type	= type;
 		pmus[i].boxes	= kzalloc(size, GFP_KERNEL);
@@ -1055,12 +1054,12 @@ err:
 }
 
 static int __init
-uncore_types_init(struct intel_uncore_type **types, bool setid)
+uncore_types_init(struct intel_uncore_type **types)
 {
 	int ret;
 
 	for (; *types; types++) {
-		ret = uncore_type_init(*types, setid);
+		ret = uncore_type_init(*types);
 		if (ret)
 			return ret;
 	}
@@ -1160,11 +1159,6 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
 	if (!box)
 		return -ENOMEM;
 
-	if (pmu->func_id < 0)
-		pmu->func_id = pdev->devfn;
-	else
-		WARN_ON_ONCE(pmu->func_id != pdev->devfn);
-
 	atomic_inc(&box->refcnt);
 	box->dieid = die;
 	box->pci_dev = pdev;
@@ -1410,7 +1404,7 @@ static int __init uncore_pci_init(void)
 		goto err;
 	}
 
-	ret = uncore_types_init(uncore_pci_uncores, false);
+	ret = uncore_types_init(uncore_pci_uncores);
 	if (ret)
 		goto errtype;
 
@@ -1678,7 +1672,7 @@ static int __init uncore_cpu_init(void)
 {
 	int ret;
 
-	ret = uncore_types_init(uncore_msr_uncores, true);
+	ret = uncore_types_init(uncore_msr_uncores);
 	if (ret)
 		goto err;
 
@@ -1697,7 +1691,7 @@ static int __init uncore_mmio_init(void)
 	struct intel_uncore_type **types = uncore_mmio_uncores;
 	int ret;
 
-	ret = uncore_types_init(types, true);
+	ret = uncore_types_init(types);
 	if (ret)
 		goto err;
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 79ff32e..3dcb88c 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -125,7 +125,6 @@ struct intel_uncore_pmu {
 	struct pmu			pmu;
 	char				name[UNCORE_PMU_NAME_LEN];
 	int				pmu_idx;
-	int				func_id;
 	bool				registered;
 	atomic_t			activeboxes;
 	cpumask_t			cpu_mask;
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3934e1e..edb7fd5 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -910,7 +910,7 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 
 	pmu = uncore_event_to_pmu(event);
 	/* no device found for this pmu */
-	if (pmu->func_id < 0)
+	if (!pmu->registered)
 		return -ENOENT;
 
 	/* Sampling not supported yet */


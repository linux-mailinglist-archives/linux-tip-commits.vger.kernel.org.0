Return-Path: <linux-tip-commits+bounces-7743-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EC5CC7B21
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07C84304EF49
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ECA346AED;
	Wed, 17 Dec 2025 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e17GlCeb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mmlnZXma"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C434679D;
	Wed, 17 Dec 2025 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975093; cv=none; b=j0SW7lzdOa/o2sMfvJG20giKtfUoS0jrC9QmxExlpdnPPbVWASIqVO3zjqdjWNlRUzNpwshJYMbPEbop7MSpGwXI/MsE9lgt6m78nifFSjuCa4gp7ixvTQgyR+57ZgENguHimQq0b1esL72bvPesfiaXdhSmqQ3kptKE44T+4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975093; c=relaxed/simple;
	bh=Pkcn2y8Zp1WOC7lo6IvZcgBSYeaQ7PkwFvNqPf0X0iY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fF6RVMx+PXIiUmEIzCkSHUeg7dxmSsV5H93ZODCrG4LjgfmbdTMdoRPojWZp85BTyZCqU1kOFIUeQL03xnm+QwjRhBid4NmKBOezRCy380ecDomKOZOa/uakcrwdqNAk2MhvhgFupfHTrwedZ8dbUDqmwZfx/SQ13g0mrDmww0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e17GlCeb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mmlnZXma; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lwyel4h2M9nhsrutt5VRiLpd5aZbOg1q++jnnGQjj+s=;
	b=e17GlCebBTBI/TIxFTpscZrWl+r/PkRLzPMe++oLORp/fkspnZzjw9QGnkdtk3bqVpeWnq
	mkuZ9Tcx6Mpg5YSgOUsi3+EIaT69HhteRImlIw4FBS38dvfTsqguYZp1YQSGLXUiQKg44u
	SuPrZcHmG2ofd1OA/rk0ut52XRDAp0nZKzA7b9NW7RQjlfPjZCRyd+GydDuTQCdyOt98Mk
	a+M1zI9XXV7+kcDOHHZWtkAhyxWl1qviAr011EqjtmvXlmdwVgZ0AwOJL137WoMRT8yScn
	P1Iylp/nAb74GdC7Pd4rP9ZyHiPe9B70q9yfhmBBgrYI+Vf4p8M8pVpD5AXyeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lwyel4h2M9nhsrutt5VRiLpd5aZbOg1q++jnnGQjj+s=;
	b=mmlnZXma32DfyBiHTsGUWd+soPC81SJrWls2f5+JaR/+t3IFzZ/oDGIc75d5ZxExFykKLq
	QdAJnEyXm414vJCw==
From: "tip-bot2 for Mingwei Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/core: Plumb mediated PMU capability from
 x86_pmu to x86_pmu_cap
Cc: Mingwei Zhang <mizhang@google.com>,
 Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Xudong Hao <xudong.hao@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-12-seanjc@google.com>
References: <20251206001720.468579-12-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597508848.510.8870965127520651682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c8824a95d9673763a0a9d642f8c79b2162296923
Gitweb:        https://git.kernel.org/tip/c8824a95d9673763a0a9d642f8c79b21622=
96923
Author:        Mingwei Zhang <mizhang@google.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:47 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:06 +01:00

perf/x86/core: Plumb mediated PMU capability from x86_pmu to x86_pmu_cap

Plumb mediated PMU capability to x86_pmu_cap in order to let any kernel
entity such as KVM know that host PMU support mediated PMU mode and has
the implementation.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Link: https://patch.msgid.link/20251206001720.468579-12-seanjc@google.com
---
 arch/x86/events/core.c            | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3f78388..df7a32b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3110,6 +3110,7 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capabil=
ity *cap)
 	cap->events_mask	=3D (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	=3D x86_pmu.events_mask_len;
 	cap->pebs_ept		=3D x86_pmu.pebs_ept;
+	cap->mediated		=3D !!(pmu.capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
 }
 EXPORT_SYMBOL_FOR_KVM(perf_get_x86_pmu_capability);
=20
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_ev=
ent.h
index fb7b261..0d9af41 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -301,6 +301,7 @@ struct x86_pmu_capability {
 	unsigned int	events_mask;
 	int		events_mask_len;
 	unsigned int	pebs_ept	:1;
+	unsigned int	mediated	:1;
 };
=20
 /*


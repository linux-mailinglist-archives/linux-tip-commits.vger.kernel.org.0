Return-Path: <linux-tip-commits+bounces-6338-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B124CB33C82
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8950E177B93
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BB2D6E78;
	Mon, 25 Aug 2025 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ym0+q85N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6+AIVoL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE22C3248;
	Mon, 25 Aug 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117468; cv=none; b=XzhnNOn2PMbctkm6uQhZh3eNMMuaSeFvlW1Dc8fn+dt8fhy9pbuFLD9PFZPioPqeSZMT2HeUXibFCf+lRGibTkzrTmH1JmBgykB4cLUtO/tvLBFjKnxfpePlhGJiTDsn982CiPa+TyOXaGidNEOgwzUEOPIU6l8e5Jk66emuFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117468; c=relaxed/simple;
	bh=th6BBfWQSSDQfipDU5ZIZ7NcUMRHRDxqvCeI2w9/iFg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aU4aOcmHZOuuuE/BJs/HYXc1vx8g8cSTEqxOgDE+RoNrmai6aJjO0rMFnQ6nzkAOPrq+ELafMfy+xJYHkx4jJQXfpIc9flrgPk3RABwYRBTXck9q2me+qQ5KoNAVqA52YP4nRKW8ya0NknxIsqfNl4+bTxztGBcIelYlRLA2PmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ym0+q85N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6+AIVoL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHUADTI5IYbDZrdsEOkwkc5ETFr1zf3HLMd5LjkGuzI=;
	b=ym0+q85NRmssna0PjTmvegxLDK7UC/wSWA8B7XWZJeUK54x9YhWd0rfkE9Qmv83fdRtOt/
	lOb3mCNlEVKonPPKQPZpvBwxjjPjF/xBMpZ2d2Zez05DMSUEOAu8sf4FJFzWE+biOolsTX
	Ucp4i6LIz+fQhsYntios7Om61IGeoSrBDO8Pk5gW/v97LdnjUDgOxxV4gDqRin2Ch3PEsx
	nRdDLa4cjg5ph1+JOedHibBBwcQxkUJx/iCDftmLWlew0YSObEIZSCnoaPiCzYZlEtTI0I
	sDknBf227+42myOn8tapmEkADRH7LER2ZM9KECwQHR4xCfI10cRdTxOWGGfPNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHUADTI5IYbDZrdsEOkwkc5ETFr1zf3HLMd5LjkGuzI=;
	b=D6+AIVoLZnU0nU38hFP/28mER47NjPv/Mp+p4UXSneHMnpLU64SMLczKansQdXDhtp74LN
	9Re5qUWmJvzmB6DA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Print PMU counters bitmap in
 x86_pmu_show_pmu_cap()
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250820023032.17128-8-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-8-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611746330.1420.16102406624758094897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f49e1be19542487921e82b29004908966cb99d7c
Gitweb:        https://git.kernel.org/tip/f49e1be19542487921e82b29004908966cb=
99d7c
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 20 Aug 2025 10:30:32 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:28 +02:00

perf/x86: Print PMU counters bitmap in x86_pmu_show_pmu_cap()

Along with the introduction Perfmon v6, pmu counters could be
incontinuous, like fixed counters on CWF, only fixed counters 0-3 and
5-7 are supported, there is no fixed counter 4 on CWF. To accommodate
this change, archPerfmonExt CPUID (0x23) leaves are introduced to
enumerate the true-view of counters bitmap.

Current perf code already supports archPerfmonExt CPUID and uses
counters-bitmap to enumerate HW really supported counters, but
x86_pmu_show_pmu_cap() still only dumps the absolute counter number
instead of true-view bitmap, it's out-dated and may mislead readers.

So dump counters true-view bitmap in x86_pmu_show_pmu_cap() and
opportunistically change the dump sequence and words.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20250820023032.17128-8-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7610f26..745caa6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2069,13 +2069,15 @@ static void _x86_pmu_read(struct perf_event *event)
=20
 void x86_pmu_show_pmu_cap(struct pmu *pmu)
 {
-	pr_info("... version:                %d\n",     x86_pmu.version);
-	pr_info("... bit width:              %d\n",     x86_pmu.cntval_bits);
-	pr_info("... generic registers:      %d\n",     x86_pmu_num_counters(pmu));
-	pr_info("... value mask:             %016Lx\n", x86_pmu.cntval_mask);
-	pr_info("... max period:             %016Lx\n", x86_pmu.max_period);
-	pr_info("... fixed-purpose events:   %d\n",     x86_pmu_num_counters_fixed(=
pmu));
-	pr_info("... event mask:             %016Lx\n", hybrid(pmu, intel_ctrl));
+	pr_info("... version:                   %d\n", x86_pmu.version);
+	pr_info("... bit width:                 %d\n", x86_pmu.cntval_bits);
+	pr_info("... generic counters:          %d\n", x86_pmu_num_counters(pmu));
+	pr_info("... generic bitmap:            %016llx\n", hybrid(pmu, cntr_mask64=
));
+	pr_info("... fixed-purpose counters:    %d\n", x86_pmu_num_counters_fixed(p=
mu));
+	pr_info("... fixed-purpose bitmap:      %016llx\n", hybrid(pmu, fixed_cntr_=
mask64));
+	pr_info("... value mask:                %016llx\n", x86_pmu.cntval_mask);
+	pr_info("... max period:                %016llx\n", x86_pmu.max_period);
+	pr_info("... global_ctrl mask:          %016llx\n", hybrid(pmu, intel_ctrl)=
);
 }
=20
 static int __init init_hw_perf_events(void)


Return-Path: <linux-tip-commits+bounces-2379-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075DC994624
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F434B25A09
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4C71DED7F;
	Tue,  8 Oct 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="azkkdXgb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lsNyete8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FBE1DE892;
	Tue,  8 Oct 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385522; cv=none; b=PatphXgGst+40DOJZ+2X2hgp6+VPx2VwrWKGp6oyR5e+BPESClkL9RmbLRN6QLVNCsoVtjjbA24kEv/QjdWKFBjlg/NfYNtc7mzrFSbTzpr3PVPu41I9XPWmfqUroPV52iC5D64sked2EKmflTxYIfDQv9InQTQAyc08yDGtwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385522; c=relaxed/simple;
	bh=j2/iyaHtD0vrmq77GJFXhspObyssbb6TQ3qK7tLutIg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HXmtd3uO2ih1ZA3JPyyiqaIsYm3EqtfewIRWF5eDNDqBlepeHq+T3O3/80RSAzN+avjRxF+RkqMfeFRisXBKVb5yeJBOD+VfHyCzoL31HVx+T93SSnXPBNupndCIrtPix76nZfJ2chNINZmnNnD7GYFLltoAD9RvvCXVDU1wOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=azkkdXgb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lsNyete8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4Qp4+/Y20JCC1Yfc2XHF2QY7OmMHrb4iBtTDd7xo+M=;
	b=azkkdXgbHsBIqmbChixmIj3FTSZCQVZBYavgLV2E9pmBiq7Ion72RUgeNnLTC7cmqvqw/F
	VVfSg5PyopAQb3tBN4tDDK+6LVxdBZ2937IWFaZojcWjydYh4QLPg9HIRgQl6BsFly/D1r
	AfyHqSFhhrZ6XlW6Zr6PTBtWBB1DREWYrtOgOx0IY1DSj+6dyXprGkQBx5J6oNO3wkEZL7
	X4U7IoA0M/PdcyXhl/QpvZ5vFhH7/IFzzqL1yrOW2JxA/oiF1Xi6iw+jMKCicZ6efgLr0C
	Tss8tfPsjQ/GAmb0oIc94jldod0hMSex594GJawJtOakz5SNUJpR5rdmrogyrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385519;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4Qp4+/Y20JCC1Yfc2XHF2QY7OmMHrb4iBtTDd7xo+M=;
	b=lsNyete88agWEHahCDs40q85yFddZMPXj3iAd7pE4tt/N/X3ApRa4C+yZAyYrg16MlWq35
	4DNMDb3diIjdN3BA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Refine hybrid_pmu_type defination
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820073853.1974746-2-dapeng1.mi@linux.intel.com>
References: <20240820073853.1974746-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838551867.1442.9258188862438365129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     79390db9eb32b2ba63c6be9fb83f12617259011d
Gitweb:        https://git.kernel.org/tip/79390db9eb32b2ba63c6be9fb83f12617259011d
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 20 Aug 2024 07:38:50 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:43 +02:00

perf/x86: Refine hybrid_pmu_type defination

Use macros instead of magic number to define hybrid_pmu_type and remove
X86_HYBRID_NUM_PMUS since it's never used.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Link: https://lkml.kernel.org/r/20240820073853.1974746-2-dapeng1.mi@linux.intel.com
---
 arch/x86/events/perf_event.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ac11821..fdd7d03 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -674,19 +674,17 @@ enum hybrid_cpu_type {
 	HYBRID_INTEL_CORE	= 0x40,
 };
 
+#define X86_HYBRID_PMU_ATOM_IDX		0
+#define X86_HYBRID_PMU_CORE_IDX		1
+
 enum hybrid_pmu_type {
 	not_hybrid,
-	hybrid_small		= BIT(0),
-	hybrid_big		= BIT(1),
+	hybrid_small		= BIT(X86_HYBRID_PMU_ATOM_IDX),
+	hybrid_big		= BIT(X86_HYBRID_PMU_CORE_IDX),
 
 	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
 };
 
-#define X86_HYBRID_PMU_ATOM_IDX		0
-#define X86_HYBRID_PMU_CORE_IDX		1
-
-#define X86_HYBRID_NUM_PMUS		2
-
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;


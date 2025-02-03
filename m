Return-Path: <linux-tip-commits+bounces-3307-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA9EA259C0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0463A33DC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A33205500;
	Mon,  3 Feb 2025 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jTMXaKa/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jZO9xfmS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8B204F75;
	Mon,  3 Feb 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586904; cv=none; b=SUhvES+oGe9OUWU5th+hTZJZjcd6v2WhHJBm3b+Gvo3DiBaLHMFtcJAYlnsV6ePLR+Pvwfy5rh70/h1JWYi8q6obQRAvEvFs14MheMXSku6I9sYu9Zp8uHiMgdgvja9KH18LUCez2nagI0WM3n42yUY+32SD71CdzlyH1DWR/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586904; c=relaxed/simple;
	bh=2JL/PSOAvQ+/mo5mTM8nS0x08Y12n+0vyD/R9eRdgYw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KZFb3r8vy41CrYiPzC0DJmDLBxaefa8DE53ZTZtmAaiInP5Iq3VpQzZymtKtyH62pXRqPplbANetcf97mPIRmO9h8GQj7gW5uB8GuqDkELdVQVnRVKYlEFlbR0WQXKlPRNNJVwsxGOgSXyn9qHh+p9hJ/u3aF49uYRAKqlUdJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jTMXaKa/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jZO9xfmS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:48:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738586900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rj4OxfH4o/VyIevxDccsdL1EnWtdZfrWDDxrvUKYaD8=;
	b=jTMXaKa/q9OJJ3+SOhnWEz29WJW+mhdoR67ARxf6NusKADl8y8Q2IZZvb7ORphAQBkSUvn
	S4E6CMiXsLusYg1OHZKOS/WVJarfudQ2lOJ26iC9eFAS1pFnerQJdSBFTXCAcEXR+CGN4V
	Sa+TREby5U3oOwsEvQscEpdy9hFepQmfx0wwiwB3U7379jpVMHOv/y3eBccV7LjM7mTcO6
	3ee1HSm4Jb7NFlF2emBDMOQiKW1nIL0BBKOsrGD0nJCTxfzicELGo0oEe/27BCj/B8zbgF
	zV2IlQi0SGR2iB1oNpPwjs2QOHanW+6NogAe7jlN0Wefg+scL5vgLYBojij6LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586900;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rj4OxfH4o/VyIevxDccsdL1EnWtdZfrWDDxrvUKYaD8=;
	b=jZO9xfmSZm5H1l8gNXVOGjhsrdSDuR62QA+oK31iFW3FzD7v4qz+LkSzNEI2HlKHoAjBHa
	Cf326w+tMPZLzuDg==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250115054438.1021-5-ravi.bangoria@amd.com>
References: <20250115054438.1021-5-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858689970.10177.16512730043338946121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     46dcf85566170d4528b842bf83ffc350d71771fa
Gitweb:        https://git.kernel.org/tip/46dcf85566170d4528b842bf83ffc350d71771fa
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 15 Jan 2025 05:44:33 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:05 +01:00

perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt

IBS Op uses two counters: MaxCnt and CurCnt. MaxCnt is programmed with
the desired sample period. IBS hw generates sample when CurCnt reaches
to MaxCnt. The size of these counter used to be 20 bits but later they
were extended to 27 bits. The 7 bit extension is indicated by CPUID
Fn8000_001B_EAX[6 / OpCntExt].

perf_ibs->cnt_mask variable contains bit masks for MaxCnt and CurCnt.
But IBS driver does not set upper 7 bits of CurCnt in cnt_mask even
when OpCntExt CPUID bit is set. Fix this.

IBS driver uses cnt_mask[CurCnt] bits only while disabling an event.
Fortunately, CurCnt bits are not read from MSR while re-enabling the
event, instead MaxCnt is programmed with desired period and CurCnt is
set to 0. Hence, we did not see any issues so far.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20250115054438.1021-5-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c         | 3 ++-
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index f95542b..d9c84f1 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1245,7 +1245,8 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
 		perf_ibs_op.config_mask	|= IBS_OP_MAX_CNT_EXT_MASK;
-		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.cnt_mask    |= (IBS_OP_MAX_CNT_EXT_MASK |
+					    IBS_OP_CUR_CNT_EXT_MASK);
 	}
 
 	if (ibs_caps & IBS_CAPS_ZEN4)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1ac79f3..ee55817 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -514,6 +514,7 @@ struct pebs_xmm {
  */
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
+#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)


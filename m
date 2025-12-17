Return-Path: <linux-tip-commits+bounces-7744-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4C0CC7BFD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 14:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 555A8304A5A4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802D347BA3;
	Wed, 17 Dec 2025 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3HBt+Xis";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fs7N5WAf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B395346A1A;
	Wed, 17 Dec 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975094; cv=none; b=TrRq7lPKnVJz/gUJd957c1gze9Xjt6jz7/Ur49sABFYqNzpxN6idrodlq/Z2HuY63u9a/aUcGni7amPv7gxhLZiE2NWwgVZJOrb1DINGyJ5s7+kj5M5pbBUTxHnmIJDIAdFrv7NFh5TvmLGtKIhOt1oKyz6plBihCzNzt8UtEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975094; c=relaxed/simple;
	bh=tpgDgvw8CrmralGLY7BiTBpozoWphTRoNXrjHIUOWQM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YeybECXquLViLpN0g99Nud0LaG5teiCr2VpAOCKq3jnNo5WbbnqnePvs9iBuwtu1H9b4Uibzc4zo/I/S7L5vaJSSrmoUIgfEXhaVyU9abHIxmR5oCulEaSRlP1OCLhS8hBk2M7t6bFWcgG3u4r1PF+/MspH3vvWmmGzXCx2U5X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3HBt+Xis; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fs7N5WAf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRWkVOqkQCpHGO0Tt7y0eWZQStur0XqlAqcxVeIRwuQ=;
	b=3HBt+XisAOSHnvgFcnlw2K/XTjK+pievFUh9TUo46ovAXCeZUX08TEX4yMwXz4TkiwB2al
	A5zKn2EudpGbF4imXI43ze32ZKxFXMLbZ8e78rn/DHIhykbZ8IEMHHwN6saqp9yFoZ+HdQ
	1cCP55wVvdjpI/pR10mQHXTBdWEh06DSgCNycznQAs/b/s7I+P8doW362rvYPdhqdfv3y1
	PtpAMEE4xaXCsD8XGClE+t9jwSxHPYAzFwXkHJjmtaSCpRdRkECM6sch3+zdsmWsSmJWOJ
	M4Dsi9mQ9SFRuKOLNU2YoRlf1s/c9XpcE6XxSkL0X4WD8Y/GOpu7rXjSMwuuxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRWkVOqkQCpHGO0Tt7y0eWZQStur0XqlAqcxVeIRwuQ=;
	b=Fs7N5WAfqgtibB1cGF3Dd7BGD9bvkMalkG9MjJo3OtPv7YXCNTJ1HZ6qwkBWCr4Ngex6mr
	shB6eLvIiBq83TAw==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/core: Do not set bit width for unavailable counters
Cc: Sandipan Das <sandipan.das@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Mingwei Zhang <mizhang@google.com>,
 Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Xudong Hao <xudong.hao@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-11-seanjc@google.com>
References: <20251206001720.468579-11-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597508955.510.3883765445504586547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b456a6ba5756b6fb7e651775343e713bd08418e7
Gitweb:        https://git.kernel.org/tip/b456a6ba5756b6fb7e651775343e713bd08=
418e7
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:46 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:06 +01:00

perf/x86/core: Do not set bit width for unavailable counters

Not all x86 processors have fixed counters. It may also be the case that
a processor has only fixed counters and no general-purpose counters. Set
the bit widths corresponding to each counter type only if such counters
are available.

Fixes: b3d9468a8bd2 ("perf, x86: Expose perf capability to other modules")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Link: https://patch.msgid.link/20251206001720.468579-11-seanjc@google.com
---
 arch/x86/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3ad5c65..3f78388 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3105,8 +3105,8 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capabil=
ity *cap)
 	cap->version		=3D x86_pmu.version;
 	cap->num_counters_gp	=3D x86_pmu_num_counters(NULL);
 	cap->num_counters_fixed	=3D x86_pmu_num_counters_fixed(NULL);
-	cap->bit_width_gp	=3D x86_pmu.cntval_bits;
-	cap->bit_width_fixed	=3D x86_pmu.cntval_bits;
+	cap->bit_width_gp	=3D cap->num_counters_gp ? x86_pmu.cntval_bits : 0;
+	cap->bit_width_fixed	=3D cap->num_counters_fixed ? x86_pmu.cntval_bits : 0;
 	cap->events_mask	=3D (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	=3D x86_pmu.events_mask_len;
 	cap->pebs_ept		=3D x86_pmu.pebs_ept;


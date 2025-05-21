Return-Path: <linux-tip-commits+bounces-5695-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52691ABF40A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF887A90D2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3C26A0DB;
	Wed, 21 May 2025 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="42b6OKPa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jH+SOQRJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195D2686BE;
	Wed, 21 May 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829762; cv=none; b=RgddMQ+p+pdBGmp7qwL9IWohmvpzzip9jb+zAKidxgFpu02X5tvLqpufgUKlq7gdqpEayb8fnqTDiKfCtDCoroPDjrEciZUIesb31vnXFLWP+V/6b2DZgdV28ksfKi+Yk/vclkE1Df7PlzqA+W4ZswaDbfGpe1z3H02CdiP/v0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829762; c=relaxed/simple;
	bh=FXZdMtAVWXiufldFfDu7uex54uhqoPdMVs2oieUxtcA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uhmby5yLz2QRCHd9JOGjmfihuo7sO4/WVKhDpMTnF8vy0lH695W739kUghg48mtQA1oLT3i9rK1I0HF+V3gCLrVJvio7Op9lGHEAoIGjut0qqBI66EsdiTKbGtRGfyld4KIZ8eHnxvIqwyFxUXi0/NZ62FZYPkVdCMffz8LDlvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=42b6OKPa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jH+SOQRJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:15:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sy/FKjz+FeLWhv//pJxzXNPKyr5zldMpRCH0jIGAdZQ=;
	b=42b6OKPaJ6KbJvCD4qwMoJBgQ5G0dz3LEReyLt1QKp4NGSKsN3bH1QT+HvTpxvCEe3rVEv
	AlSYXQ1HrzXCfmaw1zHFnvUNDwI6nXdls7Ix8FQ695LBVMzyxVA02E4BewMDUrg8PAJoRi
	nXyq9GRaziovnNq//hTMBrR2N+Ez0AVX+4FsR1NCZZ70iS0s769WJkUBqwKEWIOBhZTbwQ
	WBxEcUPf3w4Z0puSJQLPs5C5cdyYaOBaQRfx1kOrKiUjdV0nD6+mOgnKfRMdNBgCpzL7FR
	bEdng9/XhujYQCQ7BSI0ma6Nwu0yhrFDa6mLpuGMaKX57ftYWO1CGpaUsETQ2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sy/FKjz+FeLWhv//pJxzXNPKyr5zldMpRCH0jIGAdZQ=;
	b=jH+SOQRJ2MlFbEv/1mXBvFpoD/BVynUpcjgK129jAdzi6kmvKFf/ytciMa+mPR9VAucAbC
	OdZrf9seC/T2sHBA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/arm: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Leo Yan <leo.yan@arm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-9-kan.liang@linux.intel.com>
References: <20250520181644.2673067-9-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782975830.406.13397032667513134760.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     15073765285b965f70e4a29eb9a8d2a94e9abd48
Gitweb:        https://git.kernel.org/tip/15073765285b965f70e4a29eb9a8d2a94e9abd48
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:44 +02:00

perf/arm: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Link: https://lore.kernel.org/r/20250520181644.2673067-9-kan.liang@linux.intel.com
---
 drivers/perf/arm_pmuv3.c      | 3 +--
 drivers/perf/arm_v6_pmu.c     | 3 +--
 drivers/perf/arm_v7_pmu.c     | 3 +--
 drivers/perf/arm_xscale_pmu.c | 6 ++----
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index e506d59..3db9f4e 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -887,8 +887,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		 * an irq_work which will be taken care of in the handling of
 		 * IPI_IRQ_WORK.
 		 */
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 	armv8pmu_start(cpu_pmu);
 
diff --git a/drivers/perf/arm_v6_pmu.c b/drivers/perf/arm_v6_pmu.c
index b09615b..7cb12c8 100644
--- a/drivers/perf/arm_v6_pmu.c
+++ b/drivers/perf/arm_v6_pmu.c
@@ -276,8 +276,7 @@ armv6pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
diff --git a/drivers/perf/arm_v7_pmu.c b/drivers/perf/arm_v7_pmu.c
index 17831e1..a1e4381 100644
--- a/drivers/perf/arm_v7_pmu.c
+++ b/drivers/perf/arm_v7_pmu.c
@@ -930,8 +930,7 @@ static irqreturn_t armv7pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
diff --git a/drivers/perf/arm_xscale_pmu.c b/drivers/perf/arm_xscale_pmu.c
index 638fea9..c2ac41d 100644
--- a/drivers/perf/arm_xscale_pmu.c
+++ b/drivers/perf/arm_xscale_pmu.c
@@ -186,8 +186,7 @@ xscale1pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	irq_work_run();
@@ -519,8 +518,7 @@ xscale2pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			cpu_pmu->disable(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	irq_work_run();


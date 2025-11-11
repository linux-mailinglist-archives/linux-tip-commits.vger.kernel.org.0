Return-Path: <linux-tip-commits+bounces-7294-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A453C4D70F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F33189D6F3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D38B3596FA;
	Tue, 11 Nov 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s9nb6o87";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UFN0PlCO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693C357A30;
	Tue, 11 Nov 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861035; cv=none; b=nXfvnAsJIW28N3KqFcsSPU7iRJjd7CClFjr8jky2ImGwpbanUDPiKrGImNqt5yIv5gBI2nh3Uhusvax745AIsrLwiXhmkYWVsQ0ttWKXDX/NkN0GiFz57FhJBH9Lazg/Nm/fyknPa/UeDfUSg3emyycYUaJlHjO1o8JmcKm0AA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861035; c=relaxed/simple;
	bh=sra5uw6RgLkz74uqNZwUeZju4hutjty1Tp7welzDf34=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GgpR/qscSnOKLNXahNTeAgcVxXM2neXFaHEHPc9AZj3daH+EcbIbgOxEoo64bLe7ee/YOS846KsgJ6R4/m1gIZgn35XbcGrRwAQh7LepfoKgN84ZgSvVH81mOZQNx/B1ZTwtW7hxBGLnEVUchEr2u1s97feFPpUWNmsI6Vb0WCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s9nb6o87; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UFN0PlCO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snjjKrvB6vNdI+mVgi6+TwKsYHpFzaC9IgQJ3ut/Jp8=;
	b=s9nb6o87a6eAHjxk+skSu3EgmOkiiEjK50yzZWR/HIZFYn3NdS+xl19eEc3SK8dinJXMPt
	M3Blr8ybND7AvPUoT3uREbRjASqd8He0xpHz+iVAbvWCOnNYVLdbmHTF2OEKt+kHry+7xA
	LrtDrVeIQFTFV9/D7i/u80CmRaZ6CiLixnGIl1JcdrGaWMJhBz8My6Pw7XrlQ2viIE015w
	s96Z3P9ABKaIvMsoU+LIMJqNxgqnezX1k+AWIIQoIxV49zCLYsPUUM/kgFUC8dU5jQxSt8
	e1Gu1navNAoDtCbJ6hjgkgPpT2N7fDQiD3+8H31fHdbHDngPD8rsK7SnI86rlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snjjKrvB6vNdI+mVgi6+TwKsYHpFzaC9IgQJ3ut/Jp8=;
	b=UFN0PlCODgMPsDtqDZxrww+QMmxSpej1pI6MPt3+lBsPvjIfjxNI77skZVJ1bRwVB3lobh
	k3kdt3vTdA3IgrCg==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Fix NULL event access and potential PEBS
 record loss
Cc: kernel test robot <oliver.sang@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-3-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286102971.498.14931037233192413460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7e772a93eb61cb6265bdd1c5bde17d0f2718b452
Gitweb:        https://git.kernel.org/tip/7e772a93eb61cb6265bdd1c5bde17d0f271=
8b452
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:26 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:19 +01:00

perf/x86: Fix NULL event access and potential PEBS record loss

When intel_pmu_drain_pebs_icl() is called to drain PEBS records, the
perf_event_overflow() could be called to process the last PEBS record.

While perf_event_overflow() could trigger the interrupt throttle and
stop all events of the group, like what the below call-chain shows.

perf_event_overflow()
  -> __perf_event_overflow()
    ->__perf_event_account_interrupt()
      -> perf_event_throttle_group()
        -> perf_event_throttle()
          -> event->pmu->stop()
            -> x86_pmu_stop()

The side effect of stopping the events is that all corresponding event
pointers in cpuc->events[] array are cleared to NULL.

Assume there are two PEBS events (event a and event b) in a group. When
intel_pmu_drain_pebs_icl() calls perf_event_overflow() to process the
last PEBS record of PEBS event a, interrupt throttle is triggered and
all pointers of event a and event b are cleared to NULL. Then
intel_pmu_drain_pebs_icl() tries to process the last PEBS record of
event b and encounters NULL pointer access.

To avoid this issue, move cpuc->events[] clearing from x86_pmu_stop()
to x86_pmu_del(). It's safe since cpuc->active_mask or
cpuc->pebs_enabled is always checked before access the event pointer
from cpuc->events[].

Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Reported-by: kernel test robot <oliver.sang@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-3-dapeng1.mi@linux.intel.=
com
---
 arch/x86/events/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0cf68ad..b2868fe 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1344,6 +1344,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 				hwc->state |=3D PERF_HES_ARCH;
=20
 			x86_pmu_stop(event, PERF_EF_UPDATE);
+			cpuc->events[hwc->idx] =3D NULL;
 		}
=20
 		/*
@@ -1365,6 +1366,7 @@ static void x86_pmu_enable(struct pmu *pmu)
 			 * if cpuc->enabled =3D 0, then no wrmsr as
 			 * per x86_pmu_enable_event()
 			 */
+			cpuc->events[hwc->idx] =3D event;
 			x86_pmu_start(event, PERF_EF_RELOAD);
 		}
 		cpuc->n_added =3D 0;
@@ -1531,7 +1533,6 @@ static void x86_pmu_start(struct perf_event *event, int=
 flags)
=20
 	event->hw.state =3D 0;
=20
-	cpuc->events[idx] =3D event;
 	__set_bit(idx, cpuc->active_mask);
 	static_call(x86_pmu_enable)(event);
 	perf_event_update_userpage(event);
@@ -1610,7 +1611,6 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 	if (test_bit(hwc->idx, cpuc->active_mask)) {
 		static_call(x86_pmu_disable)(event);
 		__clear_bit(hwc->idx, cpuc->active_mask);
-		cpuc->events[hwc->idx] =3D NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 		hwc->state |=3D PERF_HES_STOPPED;
 	}
@@ -1648,6 +1648,7 @@ static void x86_pmu_del(struct perf_event *event, int f=
lags)
 	 * Not a TXN, therefore cleanup properly.
 	 */
 	x86_pmu_stop(event, PERF_EF_UPDATE);
+	cpuc->events[event->hw.idx] =3D NULL;
=20
 	for (i =3D 0; i < cpuc->n_events; i++) {
 		if (event =3D=3D cpuc->event_list[i])


Return-Path: <linux-tip-commits+bounces-7406-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D34CAC7351C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 10:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4ED4353FBA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A1372AC9;
	Thu, 20 Nov 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGIAbjE8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q2PZ1/bS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D124CEEA;
	Thu, 20 Nov 2025 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632080; cv=none; b=D1q5MpYlSU4R3ynVm0KPx6Cw2IqLjLUVtLCttg182WCIAwL3g1K0ljwOqQmTMqinuO5vfyEe2EmpeyTWhvC39+ojpvYaKkqhgHSRCtAph2R/3krINIdaH90fmKzXjLpSX7htQecE4/kr3bpIrAmyRVbZ1WnpdVXjGh4fR19QS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632080; c=relaxed/simple;
	bh=UeFIKeRT+TVE+PshlLLeyJzmKS3aLub55FaHQaa+bMs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YElCgGlPX3f9xnj2rZ5Rw57D5gnyr2pR3sBhhnERK9OR21Yl2QurhQgSzm/5i5yZcY5PKkk80TcY6CmMOj8FR/vfdzrX9XeG8KqP18uQk2kuHl4Pht1UHDkX1Uh83X+nhNT0CAsiNkhukE0ng/1YQDjImHo88Rvbq1oBvnzcphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGIAbjE8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q2PZ1/bS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 09:47:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763632076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkkV842PoIAhHNvH4yCAvnitDrTg6R4YmolinNdSppc=;
	b=mGIAbjE8SnvHk+g98D+DHl8R2Hnca/chHEnb4cXw4vD95ceRMVNrKo/Dkjg97oQLxVXZSz
	ODFGz0Po6c0Ix011M7i9jOLO7bEIp+9VbwWU7X/SqRNuJIZga7e3BW82OeX5kMSq8s6C19
	+i5GmcPkpEH3wosEa76VJiZmVXVsgUWey5TGa2bJcUHkmgEkj3Q4gEKHkvB5uSm1vnAoGr
	gJx3Ztg1kjZfSJP/iAYteBCiq+WJdIJw0B0idawprAWXL+bqJSYbwX+mPyLF4IbOhqfnc2
	GQYimQtcIbly966qOyIwAvzA5KOgDbNeQMVbGpHM5m6jgwfI+9pnnhNJHNgjAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763632076;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkkV842PoIAhHNvH4yCAvnitDrTg6R4YmolinNdSppc=;
	b=q2PZ1/bSi2u5XBTO9OND0Fny8dX6FEjtQyAZ3EzL9e7F1pR/aeBNGPB+gPnvMQALXXw4Yd
	XCcL2qhp6UTe1qBw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix 0 count issue of cpu-clock
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
References: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363207041.498.7734531032867658405.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f1f96511b1c4c33e53f05909dd267878e0643a9a
Gitweb:        https://git.kernel.org/tip/f1f96511b1c4c33e53f05909dd267878e06=
43a9a
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 12 Nov 2025 16:05:26 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 10:42:12 +01:00

perf: Fix 0 count issue of cpu-clock

Currently cpu-clock event always returns 0 count, e.g.,

perf stat -e cpu-clock -- sleep 1

 Performance counter stats for 'sleep 1':
                 0      cpu-clock                        #    0.000 CPUs util=
ized
       1.002308394 seconds time elapsed

The root cause is the commit 'bc4394e5e79c ("perf: Fix the throttle
 error of some clock events")' adds PERF_EF_UPDATE flag check before
calling cpu_clock_event_update() to update the count, however the
PERF_EF_UPDATE flag is never set when the cpu-clock event is stopped in
counting mode (pmu->dev() -> cpu_clock_event_del() ->
cpu_clock_event_stop()). This leads to the cpu-clock event count is
never updated.

To fix this issue, force to set PERF_EF_UPDATE flag for cpu-clock event
just like what task-clock does.

Fixes: bc4394e5e79c ("perf: Fix the throttle error of some clock events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://patch.msgid.link/20251112080526.3971392-1-dapeng1.mi@linux.inte=
l.com
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1fd347d..2c35acc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11901,7 +11901,7 @@ static int cpu_clock_event_add(struct perf_event *eve=
nt, int flags)
=20
 static void cpu_clock_event_del(struct perf_event *event, int flags)
 {
-	cpu_clock_event_stop(event, flags);
+	cpu_clock_event_stop(event, PERF_EF_UPDATE);
 }
=20
 static void cpu_clock_event_read(struct perf_event *event)


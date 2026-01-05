Return-Path: <linux-tip-commits+bounces-7782-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDD8CF24A3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 08:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BE3D3011188
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A462BEFF5;
	Mon,  5 Jan 2026 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rQiDCc73";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTWd+KwP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF061F63CD;
	Mon,  5 Jan 2026 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599882; cv=none; b=bsTKycxVv7pYtxq4i/cTR5WYKQq4eejLu/SKD7KceWu9NgoztD4L/Btz1PAlYgxq0Yke+OYne3QlJEzQK9u8eGa/xT5OWsTn7LwPXpYruYS1tMS8jjhU+fqL43/HvykKp0qmpjsUGhSQJm1XiABojwqPIjDJy3fJq4TfD+Jw/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599882; c=relaxed/simple;
	bh=M6AhQ5ilfsMDWf2QWcHHavGMgqQ2u2bxHNFgC3p298Q=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=WkIVRRyaWy46rEGVFaerP6LIB193OI0BreHHOuBcSGqo3goJlOzjOGuMuSevvummMdmhSzMFA7eP0/qft0RzNQmta0lbQfjS30Y/ik4sF6Pclr+wC6Ks0or1nWBTqF/5tr1OJD68kssXUT7x+K2Iy/9wMi4pc3EqQVkAgAbqiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rQiDCc73; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTWd+KwP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 07:57:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767599878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XcEO+Dl/SGsWHkELSMX3IJpJjA1fTMv+0SSz5qPXRDc=;
	b=rQiDCc73lt07scR/GsC7RT07slFhoYnx2QOTvpNjPgoD4rJ9nxyD0mEJuSGoZ9eVzcI1Ix
	FXbEfQyctwfW143/mocodwRCOZ4DN4GqhjCsvkb7ax9UUo28i1FVwO6dSMkHyaGbrkh5dO
	BDsdvhX9+IQGi2VU3nUh0+sVsDZBUegbyCkAOWgu+TmXr+HeYdQks5qisHgfEjUygFMmj+
	eZ7uLE+qUcLbT7bY7llzoyHH5K6h3IGxZwsxKz0NjgVDCxRG6rNflMFfwpL4xYDpL11oqc
	w+KPCpzpquODh+OGYrt49RxO+/Ox9lIUspsab6Ze4su3/Zb1gZU+K3TOr3nr6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767599878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XcEO+Dl/SGsWHkELSMX3IJpJjA1fTMv+0SSz5qPXRDc=;
	b=bTWd+KwP+5dinBJ5aaBOuib0Jpbv6ju2CAVaFAUHxXOWnrqHERfizqzIK7AZuw8XCCGIdP
	K1Frd9BfyRAzoUCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Ensure swevent hrtimer is properly destroyed
Cc: CyberUnicorns <a101e_iotvul@163.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176759987385.510.3913340745145777460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ff5860f5088e9076ebcccf05a6ca709d5935cfa9
Gitweb:        https://git.kernel.org/tip/ff5860f5088e9076ebcccf05a6ca709d593=
5cfa9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 20 Dec 2025 14:14:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 08:55:54 +01:00

perf: Ensure swevent hrtimer is properly destroyed

With the change to hrtimer_try_to_cancel() in
perf_swevent_cancel_hrtimer() it appears possible for the hrtimer to
still be active by the time the event gets freed.

Make sure the event does a full hrtimer_cancel() on the free path by
installing a perf_event::destroy handler.

Fixes: eb3182ef0405 ("perf/core: Fix system hang caused by cpu-clock usage")
Reported-by: CyberUnicorns <a101e_iotvul@163.com>
Tested-by: CyberUnicorns <a101e_iotvul@163.com>
Debugged-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dad0d3d..e3d8338 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11906,6 +11906,11 @@ static void perf_swevent_cancel_hrtimer(struct perf_=
event *event)
 	}
 }
=20
+static void perf_swevent_destroy_hrtimer(struct perf_event *event)
+{
+	hrtimer_cancel(&event->hw.hrtimer);
+}
+
 static void perf_swevent_init_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc =3D &event->hw;
@@ -11914,6 +11919,7 @@ static void perf_swevent_init_hrtimer(struct perf_eve=
nt *event)
 		return;
=20
 	hrtimer_setup(&hwc->hrtimer, perf_swevent_hrtimer, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL_HARD);
+	event->destroy =3D perf_swevent_destroy_hrtimer;
=20
 	/*
 	 * Since hrtimers have a fixed rate, we can do a static freq->period


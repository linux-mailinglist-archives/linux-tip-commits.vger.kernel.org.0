Return-Path: <linux-tip-commits+bounces-6539-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48084B4F51F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 14:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFB044658B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD932BF31;
	Tue,  9 Sep 2025 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2C0rzCcx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/NJuCT2w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C6334716;
	Tue,  9 Sep 2025 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419798; cv=none; b=W3G6jWQld6qrJE0fsV45OPi3jmYLVnLBLocAAzkl1+plOlTOS9pFFoVik5GQ1PpxBnGShtYVDwBm6115FS0+dU4qB3vDYhiTOPemismJt0eOmII4SASzuLlmbB+MYkrpylotOqTak1NV838d3Cz1pVLShH6TT3uBPfxRb/MBaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419798; c=relaxed/simple;
	bh=damzLcpdcwKo6IXGMInjvSuc2zDrFmhK6GOFuUkxAtQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ato9nL/sEyYN0u4nrs7Ts5C2wHP8T6e1AGY+8gnNSHNbB3VcWnpW0vKEI2vy2pjiEVtgHIqiaTDKXu7pGPVj4Zj39ehVKVmK1wrfeFVpO2Tn6IzkWY5pLOh4jAzNoN/eaNMT10Gt1MtutGF+BplGu+AwPsYuPXpsk7mKQU+VnPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2C0rzCcx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/NJuCT2w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 12:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757419795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnfqrFJ4O/Wtn+OmpN1tli48AdTUMNJJAmYxx+BmnBM=;
	b=2C0rzCcxjWiborktzy62wibBSbyr6xI2YXPpZqbyS2rGcO0NYodOcnZowv0mQGx2wcZwZn
	nWxfAtzXHq0z7rp35jcR4TxwgMRrcRBiYBTzvpxizeyhDFwNR5HOWUqaIRZT2mi++hkbv9
	z0eMTR8x4YjsABQr5r+6/QldxLl2o3qOEbTS8TlK4VFJ4ClvY8UvOTBIFdyhkStjp8B44p
	2hra7IQce7uDkbYuaQCwC3/V32jO7i6vvChEKQd+g4bzvy8AZ3Iedgn5kxEg94nZUbZTqa
	vtqnNje0W4QOLvMlm4sJdI+g2QPHgvC4ysU8HqA10iVC5DnZY2k33Aq7ROWxjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757419795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnfqrFJ4O/Wtn+OmpN1tli48AdTUMNJJAmYxx+BmnBM=;
	b=/NJuCT2wqKj2tWEtG5bLzPvrbgFWa1NVjmvm+I0Y2pZLKxdx/s1bwuw+WMKmQjokdgtcBy
	idS3nSD4xplFgfBg==
From: "tip-bot2 for Jiri Wiesner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Print durations for sync check
 unconditionally
Cc: Jiri Wiesner <jwiesner@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <aIuXXfdITXdI0lLp@incl>
References: <aIuXXfdITXdI0lLp@incl>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741979368.1920.4318552244633752782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b9aa93aa5185aee76c4c7a5ba4432b4d0d15f797
Gitweb:        https://git.kernel.org/tip/b9aa93aa5185aee76c4c7a5ba4432b4d0d1=
5f797
Author:        Jiri Wiesner <jwiesner@suse.de>
AuthorDate:    Thu, 31 Jul 2025 18:18:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 14:08:19 +02:00

clocksource: Print durations for sync check unconditionally

A typical set of messages that gets printed as a result of the clocksource
watchdog finding the TSC unstable usually does not contain messages
indicating CPUs being ahead of or behind the CPU from which the check is
carried out. That fact suggests that the TSC does not experience time skew
between CPUs (if the clocksource.verify_n_cpus parameter is set to a
negative value) but quantitative information is missing.

The cs_nsec_max value printed by the "CPU %d check durations" message
actually provides a worst case estimate of the time skew. If all CPUs have
been checked, the cs_nsec_max value multiplied by 2 is the maximum
possible time skew between the TSCs of any two CPUs on the system. The
worst case estimate is derived from two boundary cases:

1. No time is consumed to execute instructions between csnow_begin and
csnow_mid while all the cs_nsec_max time is consumed by the code between
csnow_mid and csnow_end. In this case, the maximum undetectable time skew
of a CPU being ahead would be cs_nsec_max.

2. All the cs_nsec_max time is consumed to execute instructions between
csnow_begin and csnow_mid while no time is consumed by the code between
csnow_mid and csnow_end. In this case, the maximum undetectable time skew
of a CPU being behind would be cs_nsec_max.

The worst case estimate assumes a system experiencing a corner case
consisting of the two boundary cases.

Always print the "CPU %d check durations" message so that the maximum
possible time skew measured by the TSC sync check can be compared to the
time skew measured by the clocksource watchdog.

Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/all/aIuXXfdITXdI0lLp@incl

---
 kernel/time/clocksource.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 0aef0e3..3edb01d 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -407,9 +407,8 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	if (!cpumask_empty(&cpus_behind))
 		pr_warn("        CPUs %*pbl behind CPU %d for clocksource %s.\n",
 			cpumask_pr_args(&cpus_behind), testcpu, cs->name);
-	if (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind))
-		pr_warn("        CPU %d check durations %lldns - %lldns for clocksource %s=
.\n",
-			testcpu, cs_nsec_min, cs_nsec_max, cs->name);
+	pr_info("        CPU %d check durations %lldns - %lldns for clocksource %s.=
\n",
+		testcpu, cs_nsec_min, cs_nsec_max, cs->name);
 }
 EXPORT_SYMBOL_GPL(clocksource_verify_percpu);
=20


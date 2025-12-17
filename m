Return-Path: <linux-tip-commits+bounces-7733-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D68CC7AFD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C378305E35C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30CC33D6E9;
	Wed, 17 Dec 2025 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0cJaP47";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DkGuP1Ze"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D6237163;
	Wed, 17 Dec 2025 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975083; cv=none; b=Ubw9Bo6GWXCjncAxhR0+ol/JdYhqSs1NpsUWtoQAghzVSfOBTP4au6w1W8t0qR6N3JRdhkQ2ZsWXhD5p8LqBbMm2NFJb8B6r/frBBJzcc0lTsLuD/a+Dj7/2yZHnmf2gDqqTGBOHnOUvRyBC7uVAPU/kUbkWqk6B8q2eWXS9TJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975083; c=relaxed/simple;
	bh=tSy7K1ENOOXUd1Ai0ZZcGJY3j9Qg7rSuwqKC+2fBX1c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lWwwogU4uQw2qgljLQTHPoY81JdDtzBSfk/mrZ/AhcLJdfTzr0Lwbk41bJaxZ4Fgm0LrbYRDZyMF71hcMTfJOxE1OwxMnauWGFrjhpIsmppA602XXfbfbH/svrskaL0c6RmSXPMj/MouhZiqccB0WV145AnJdH4gGfqwQ3pn89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0cJaP47; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DkGuP1Ze; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:37:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lUUi4ldqHxDvlZGeL/OwvtwTZnKCHVYnVTzJbA2WT0=;
	b=D0cJaP47fEH/GixwAJlbG7y8n9DAiNZGj7onN2EkG2M+X/Q8n+i93onJ27T1I1K8WhdwF6
	LtHIPXfuaol8wf7rMolX/ZBHXHIdcBef7Mmbvbb7bLdoEOreYsoyGHSXa7mtMQYzAjKOF2
	5sCnbrMay2tnji+pR4UlEAdqeFq+VjkxxR2JOhGFsFbOG6x5yxz15f/ZOGzJvA/Jw+OAtF
	9vDC8q4N4IneCPkuXCgXSaiLqq3riRzmqRysVrdPyEOA6YI97fqBUna0iwsoMJccuR59tT
	EqH1Tchs//GBPqdFWXpL+q7lY0VI3Dwqh+HYdE240JdNjPkAyYtJ6W/l9ZwsDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lUUi4ldqHxDvlZGeL/OwvtwTZnKCHVYnVTzJbA2WT0=;
	b=DkGuP1ZeAScfpSdz6EIzb3S2AGhYonSjldIUYBA7xtZ4GSnXSiEANhRiyXlwydlcsV3JY6
	keEx4L0duAfaBlDA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Clean up mediated vPMU accounting
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251208115156.GE3707891@noisy.programming.kicks-ass.net>
References: <20251208115156.GE3707891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597507837.510.17276279543690494180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3cb3c2f6886f9489df13de8efe7a1e803a3f21ea
Gitweb:        https://git.kernel.org/tip/3cb3c2f6886f9489df13de8efe7a1e803a3=
f21ea
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 17 Dec 2025 12:08:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:09 +01:00

perf: Clean up mediated vPMU accounting

The mediated_pmu_account_event() and perf_create_mediated_pmu()
functions implement the exclusion between '!exclude_guest' counters
and mediated vPMUs. Their implementation is basically identical,
except mirrored in what they count/check.

Make sure the actual implementations reflect this similarity.

Notably:
 - while perf_release_mediated_pmu() has an underflow check;
   mediated_pmu_unaccount_event() did not.
 - while perf_create_mediated_pmu() has an inc_not_zero() path;
   mediated_pmu_account_event() did not.

Also, the inc_not_zero() path can be outsite of
perf_mediated_pmu_mutex. The mutex must guard the 0->1 (of either
nr_include_guest_events or nr_mediated_pmu_vms) transition, but once a
counter is already non-zero, it can safely be incremented further.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251208115156.GE3707891@noisy.programming.kic=
ks-ass.net
---
 kernel/events/core.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dd842a4..e6a4b1e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6344,8 +6344,10 @@ static int mediated_pmu_account_event(struct perf_even=
t *event)
 	if (!is_include_guest_event(event))
 		return 0;
=20
-	guard(mutex)(&perf_mediated_pmu_mutex);
+	if (atomic_inc_not_zero(&nr_include_guest_events))
+		return 0;
=20
+	guard(mutex)(&perf_mediated_pmu_mutex);
 	if (atomic_read(&nr_mediated_pmu_vms))
 		return -EOPNOTSUPP;
=20
@@ -6358,6 +6360,9 @@ static void mediated_pmu_unaccount_event(struct perf_ev=
ent *event)
 	if (!is_include_guest_event(event))
 		return;
=20
+	if (WARN_ON_ONCE(!atomic_read(&nr_include_guest_events)))
+		return;
+
 	atomic_dec(&nr_include_guest_events);
 }
=20
@@ -6373,10 +6378,10 @@ static void mediated_pmu_unaccount_event(struct perf_=
event *event)
  */
 int perf_create_mediated_pmu(void)
 {
-	guard(mutex)(&perf_mediated_pmu_mutex);
 	if (atomic_inc_not_zero(&nr_mediated_pmu_vms))
 		return 0;
=20
+	guard(mutex)(&perf_mediated_pmu_mutex);
 	if (atomic_read(&nr_include_guest_events))
 		return -EBUSY;
=20


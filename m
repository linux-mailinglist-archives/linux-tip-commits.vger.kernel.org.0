Return-Path: <linux-tip-commits+bounces-7339-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8DEC5D167
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6804ED1CB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 12:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA353315D4D;
	Fri, 14 Nov 2025 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACmZ5dFi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dXIdI3bl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35DB30F539;
	Fri, 14 Nov 2025 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122749; cv=none; b=ofCW+mfvR06slXR1cROEJxSPMXGlzbVdSvCmDaQhaGcJAcDzIgxGv6fhIYYbHFiu3DjViJcCYbs7a5uIZQSipnLQ2K2cUT9YPebNpUC0nE2puVQklHhDMxPKoxhAorUUTTiX/82/eOnMszjshSFMOY14x6SiE+WPJeeUF7HghaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122749; c=relaxed/simple;
	bh=0SSBkKFVhxOQ98QQ/XdnvXMA1DyFcoRvLdRGRCd+B98=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OlCTDDVvx7ndQFZy33QQATk+CXXRUIo/Qy/jR/HHpM86VfzI2cefltAQ/jaeG65fvLjgRW/2E6d3FCeWhOdCyPZaSiVSC2Grv9G6q7C+d67YeAyequnSiIv0vAu+brJhP2uek4wu7jPSk6Y6B/AikakzqIDLwRh9iGgN1y/GgKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ACmZ5dFi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dXIdI3bl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 12:19:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763122746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hbu9r6o002WD9K31n1lCznwou9whWsnzNsC6RBAo5A=;
	b=ACmZ5dFiliK6BrZ7SbnTTmyGxCNfrs/o2CHL0W6eESpOfBaegqZ6tR30TQSqFTYwnyID6R
	QX6t7Rvz+l+nDqcsYJbhHq5G2yYyxC0y8n8ZNb1Hi7M7jLXp7L4u7hrLHliyPmkomBfSB6
	BNZ0/4hWJWYCF/7iYFgFk7iI7Sg96bt1fjjC+h51PzHVt05MpIlSpVvwYEE/at7MZDwCxW
	UJANs6Wm1mnT6QyJBf27q9V3UM94v1vaHaFUCTc8sgLsMoh+RBmB8WmTqbtzjSzlQQNdbm
	KifJ/0LYWwFGYJLim6dGEQOlIT7/oH1oW8Kl/fEua6hmvOcwzMHgWzF06bjiog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763122746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hbu9r6o002WD9K31n1lCznwou9whWsnzNsC6RBAo5A=;
	b=dXIdI3bl8m3gGKZIL6v7Ot3WI7WnLcg8FcBNjlDVblH3iKNqg09T6TiyFUFH7OzxAo4mv/
	yygz914gigr5BGAg==
From: "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Enable scheduler feature NEXT_BUDDY
Cc: Mel Gorman <mgorman@techsingularity.net>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251112122521.1331238-2-mgorman@techsingularity.net>
References: <20251112122521.1331238-2-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312274502.498.14375992311761736776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8f839c9c55f2a034867b5d382950f6bc9acd1a3f
Gitweb:        https://git.kernel.org/tip/8f839c9c55f2a034867b5d382950f6bc9ac=
d1a3f
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Wed, 12 Nov 2025 12:25:20=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Nov 2025 13:03:06 +01:00

sched/fair: Enable scheduler feature NEXT_BUDDY

The NEXT_BUDDY feature reinforces wakeup preemption to encourage the last
wakee to be scheduled sooner on the assumption that the waker/wakee share
cache-hot data. In CFS, it was paired with LAST_BUDDY to switch back on
the assumption that the pair of tasks still share data but also relied
on START_DEBIT and the exact WAKEUP_PREEMPTION implementation to get
good results.

NEXT_BUDDY has been disabled since commit 0ec9fab3d186 ("sched: Improve
latencies and throughput") and LAST_BUDDY was removed in commit 5e963f2bd465
("sched/fair: Commit to EEVDF"). The reasoning is not clear but as vruntime
spread is mentioned so the expectation is that NEXT_BUDDY had an impact
on overall fairness. It was not noted why LAST_BUDDY was removed but it
is assumed that it's very difficult to reason what LAST_BUDDY's correct
and effective behaviour should be while still respecting EEVDFs goals.
Peter Zijlstra noted during review;

	I think I was just struggling to make sense of things and figured
	less is more and axed it.

	I have vague memories trying to work through the dynamics of
	a wakeup-stack and the EEVDF latency requirements and getting
	a head-ache.

NEXT_BUDDY is easier to reason about given that it's a point-in-time
decision on the wakees deadline and eligibilty relative to the waker. Enable
NEXT_BUDDY as a preparation path to document that the decision to ignore
the current implementation is deliberate. While not presented, the results
were at best neutral and often much more variable.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251112122521.1331238-2-mgorman@techsingulari=
ty.net
---
 kernel/sched/features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 3c12d9f..0607def 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -29,7 +29,7 @@ SCHED_FEAT(PREEMPT_SHORT, true)
  * wakeup-preemption), since its likely going to consume data we
  * touched, increases cache locality.
  */
-SCHED_FEAT(NEXT_BUDDY, false)
+SCHED_FEAT(NEXT_BUDDY, true)
=20
 /*
  * Allow completely ignoring cfs_rq->next; which can be set from various


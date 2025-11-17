Return-Path: <linux-tip-commits+bounces-7377-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AAEC65294
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 17:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE6FA365F62
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F32D77E5;
	Mon, 17 Nov 2025 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZXSVa3Wi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NQfuI9CV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727F2D5950;
	Mon, 17 Nov 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396621; cv=none; b=UdkkDQscFFo5r7Kt2qVsXPgECGov8ov3PwH9QPzmIFM4dQ0jnOReb5+Y/BYnovkPRs30Kj3oRA6YPaPrfHQu2z0QQKL37eKrAIiIjUQcNeaFWPDtTTXHfMXi8xraPrDER7NBnBtEQ2EF+HE7tcPezlRF5MI30Qm5WhX2ChZnmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396621; c=relaxed/simple;
	bh=eiLdimgjYVzHUnW18qs6pXYPS2GaPLaTh1gMfOOKT6w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W6qhmxqWjnZXBsforZMgV13QgmeOVA+e4Bt1UC++bPEJm70QpyHae0HY4PeuFIMACYxrUMnvESDi0QoE61tWjfsRsvewU6iFmnWvSbEtNOq465h7h2MRqfphpjFupeLg+fg3hRGUZtOZle4F3qJEdzeW5IlsC8TiD/c11vhJloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZXSVa3Wi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NQfuI9CV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Nov 2025 16:23:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763396617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3FXaRZdwWBkIC36AryE4VEGwcSH9I08qPMCUjKm9e4=;
	b=ZXSVa3WidOtXLHHivcxMkJBXBRqv33JZ6vWAoeecckpUI3PNhoUtLvbZ1h0jdht2x3yrx8
	qQ+5CIWAd2ajpbRbBnaDaTHX5ImM0j4WkVPJYIEfgBc3IMNscKPqFzyjfJxhWX7BtiBmNH
	y4IWGs2Kazfgy+D1MmqC15sFFs7cYA4X81g7CiTDKcvwMk9jqwHtT8z3bjWWjdPck4G4ns
	beSx7Nwac62nK+W17ArO0PdqKDM3c6j8wPomo/cRLv8pbcQ3gOy0TxK2drAn41bnOQ9fGO
	qVCac6B9Nv157fYeE2eO3GasNB0Ewrb0HViAl7xF0Z49YFxe+cVw4trJcHp0Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763396617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3FXaRZdwWBkIC36AryE4VEGwcSH9I08qPMCUjKm9e4=;
	b=NQfuI9CVKrd4SsmKAXiHI2Zraa1EBbD5h9ahRybL9a/auHqwJmtVOAjunYUuosoB0iDWhE
	VCqxW7oWpUsGasBQ==
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
Message-ID: <176339661634.498.10741159141335442500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     aceccac58ad76305d147165788ea6b939bef179b
Gitweb:        https://git.kernel.org/tip/aceccac58ad76305d147165788ea6b939be=
f179b
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Wed, 12 Nov 2025 12:25:20=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Nov 2025 17:13:15 +01:00

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


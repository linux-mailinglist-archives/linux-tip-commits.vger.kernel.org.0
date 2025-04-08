Return-Path: <linux-tip-commits+bounces-4769-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387FBA81595
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936433BA6DC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB8B256C7E;
	Tue,  8 Apr 2025 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A+J6lvat";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nmXDujPA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C72566C5;
	Tue,  8 Apr 2025 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139140; cv=none; b=LNGqQdxpvpTYvna12rnMqAs0zg0p0t0/NpuDLai1nBDVWDIkXDw9RL+1VTBRk7A5JS2XshSCELAk8QANGBhsDYiWb9U7eAKwZCNNpcIctjJBSZnd1B1mwnUFCLznihHmZUkIQjG54hBbozY4/JnkT0NJNzlR6Q165+jd117mk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139140; c=relaxed/simple;
	bh=s4JEBEwII3wXvrOi9+xhBgzE80CAiq489dR798Ruzzs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mOMl1in5JUg1BDIb0KiEJfD3zQPrT/Y8Bp/2PHn8u8SVzOhhur2TZquR9WHNTqPubT0IEm3enqzi9kdYt9lIDvXyHP7FuNaK3+mzpw+5BN2rFqp4h4coOKZwcDYfh+enSFNfrwaVFR4kcQAvA1nTOtWytg2osgwGtk9y45Evyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A+J6lvat; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nmXDujPA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139137;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mXJxz2TrJRPIO94iSjpc9expW0ZPt8bFwZ9hxNkLDg=;
	b=A+J6lvatJ8xSeyuznyBN27nCeNBpGA71nrB4erzfBkPdqYl5k3/5UnBVOM/+qHxVeWdRUN
	7tIDtHVt2U5fz1HJDUjqK9g8VQ7Z/jlGS6U1l5/hDYt68JXbIokyLtkXGmgzI6FMrlP7oZ
	VeEOD7ZcLx+cL5DjNlaxotnXDYNk5LyeeacLaFVv0Ux5t/wzSK7uE/CaVL1oVwqrZhCR9j
	QkaIpPuIsTBpwZpfF9wGj46+ZKN1YGPzwxkEj1zbfA3EiuPlgH7vATBgRSdSiBnhnollwP
	PRQBc33CCIUSBAVevjCeGPLjgbY/eFDXDStoOdQfujv6EadykmIv4DpnpMbltA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139137;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mXJxz2TrJRPIO94iSjpc9expW0ZPt8bFwZ9hxNkLDg=;
	b=nmXDujPAd7ujAHIWG9sU/agXtl/0BZj3rxgkPpJOt/6WV271kXOd474ca2W901YJqoK4LA
	JNrq9+hOP1YTcFAA==
From: tip-bot2 for Michal =?utf-8?q?Koutn=C3=BD?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove unneeed macro wrap
Cc: mkoutny@suse.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250310170442.504716-3-mkoutny@suse.com>
References: <20250310170442.504716-3-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913691.31282.2382422250869084572.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e285313f0848157cc3c6827d233a2510167b50cf
Gitweb:        https://git.kernel.org/tip/e285313f0848157cc3c6827d233a2510167=
b50cf
Author:        Michal Koutn=C3=BD <mkoutny@suse.com>
AuthorDate:    Mon, 10 Mar 2025 18:04:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:53 +02:00

sched: Remove unneeed macro wrap

rt_entity_is_task has split definitions based on CONFIG_RT_GROUP_SCHED,
therefore we can use it always. No functional change intended.

Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250310170442.504716-3-mkoutny@suse.com
---
 kernel/sched/rt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2ade81e..61ec29b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1255,11 +1255,9 @@ static void __delist_rt_entity(struct sched_rt_entity =
*rt_se, struct rt_prio_arr
 static inline struct sched_statistics *
 __schedstats_from_rt_se(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_RT_GROUP_SCHED
 	/* schedstats is not supported for rt group. */
 	if (!rt_entity_is_task(rt_se))
 		return NULL;
-#endif
=20
 	return &rt_task_of(rt_se)->stats;
 }


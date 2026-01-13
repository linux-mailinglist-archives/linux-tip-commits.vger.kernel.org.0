Return-Path: <linux-tip-commits+bounces-7943-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC544D1841B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBFE83012945
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C341538BDDC;
	Tue, 13 Jan 2026 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mh/ld/IW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hIfpgQJ4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E10392B69;
	Tue, 13 Jan 2026 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301424; cv=none; b=JZq6n9QhG68LsiweHy9e405xQnXi0owUaplXn94yFzTpdbkJqYwLWat1TvGDpJJRDKzqouDFd2aWMVP64SqEgh6uCW9z60US/IbPIrOUaJsLvDK9dHXzSU+uAehp/KF9bzG6nfWBH0KoQlCF/x0kFm8Si5/gc1sDruOTBMc9Pis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301424; c=relaxed/simple;
	bh=DCJVVAAr1F0mlugeowSYXmIWGJgR9DQjDbdA3xIjthE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l8FzEa7rTdrY/yAZ6giR6xih/4CNZ207uc+rLNEvSJ3eJDgbey8nT9XxeOmuFO7TyFZngjl28FgEg8RYDLH15IRiBrhpX+pFQH7TRSc1TP0PrpmX980f0Xd28hLrq7Wf3T+WwOUcQ25S7DdhFz6Te5TR2hmM2fCG/ln8wz98IpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mh/ld/IW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hIfpgQJ4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:50:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuYn6vYMRfKzwhRbfNpR6fLPcF/DuOt9x/7+6XC6fjY=;
	b=Mh/ld/IWxyBPCdNKm+CmG3GiGhvOrP9YtfbJGUEqurt3Fx4n1UXCWFgR9VXuj4AW1GkKyv
	ZXOSq59rK6m9Q0ObXPNSzOAGi5J7OZPH9xCPq8FCKCGejzmxTvHnER5nmJbhx+IAF3ERzU
	oBuUuZGuv/4ME43kbZTN8pFAZ21UllHZ7Ae7B5koFgTtaoGSWHw/3IvvofTGQzkHQLqLuJ
	byXrF8U8RNv/0AqB3/2UN8J7BEuYd+6XNx65hYcgjaAOF/DX7c9WYF2S197GXlUAQItcaG
	nQFTTRN7uuWVaXwE9hZGLcxJM8pjO1GVKVDvuehIqXC+xudsJ8zrlhPz7KZ6Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuYn6vYMRfKzwhRbfNpR6fLPcF/DuOt9x/7+6XC6fjY=;
	b=hIfpgQJ4wKB5ePIrzhJoVmO/bJcppYdDkhtQ5G+vp4kL9eLeDqV8oGFHd1nlpPVzNkFAKK
	lgWWQlNO4T3g/yCA==
From: "tip-bot2 for Jan H. Sch=C3=B6nherr" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Speed up kexec shutdown by avoiding
 unnecessary cross CPU calls
Cc: jschoenh@amazon.de, David Woodhouse <dwmw@amazon.co.uk>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <0d0b7fe70e6dfa7979cb83b05317deb21187f74d.camel@infradead.org>
References: <0d0b7fe70e6dfa7979cb83b05317deb21187f74d.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830142057.510.10709265177300837716.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f4045e9dbb94825491b6da164f14f22b63de6a4e
Gitweb:        https://git.kernel.org/tip/f4045e9dbb94825491b6da164f14f22b63d=
e6a4e
Author:        Jan H. Sch=3DC3=3DB6nherr <jschoenh@amazon.de>
AuthorDate:    Thu, 08 Jan 2026 11:14:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Jan 2026 11:45:36 +01:00

perf/core: Speed up kexec shutdown by avoiding unnecessary cross CPU calls

There are typically a lot of PMUs registered, but in many cases only few
of them have an event registered (like the "cpu" PMU in the presence of
the watchdog). As the mutex is already held, it's safe to just check for
existing events before doing the cross CPU call.

This change saves tens of milliseconds from kexec time (perceived as
steal time during a hypervisor host update), with <2ms remaining for
this step in the shutdown. There might be additional potential for
parallelization or we could just disable performance monitoring during
the actual shutdown and be less graceful about it.

Signed-off-by: Jan H. Sch=C3=83=3DB6nherr <jschoenh@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/0d0b7fe70e6dfa7979cb83b05317deb21187f74d.camel=
@infradead.org
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 376fb07..101da5c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -15066,7 +15066,8 @@ static void perf_event_exit_cpu_context(int cpu)
 	ctx =3D &cpuctx->ctx;
=20
 	mutex_lock(&ctx->mutex);
-	smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
+	if (ctx->nr_events)
+		smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
 	cpuctx->online =3D 0;
 	mutex_unlock(&ctx->mutex);
 	mutex_unlock(&pmus_lock);


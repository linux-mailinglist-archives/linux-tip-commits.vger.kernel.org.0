Return-Path: <linux-tip-commits+bounces-7611-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F18ACAA339
	for <lists+linux-tip-commits@lfdr.de>; Sat, 06 Dec 2025 10:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3548430E7ACA
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Dec 2025 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571672E092E;
	Sat,  6 Dec 2025 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D2sbpisB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6zOS8Ns6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5682DECA8;
	Sat,  6 Dec 2025 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765012250; cv=none; b=nQve4vUG4EHlnrvUoL3uUjTyQYj7WngWy38PuMLlMnsOzREfjqFB6Q/8hKOx/JbZ/4IxF74/AGLWWoUWSjiLAaMTM8arH7H2zptX0GC+F5EVxYibxi8h2oVT9US8hiLUXKDdPEbCZLvgwLWwgELDv2/0eBjmLg0kXuQkGO6I81I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765012250; c=relaxed/simple;
	bh=3OenBRBj+/G3PQNKbXQS0ppXeMHRiJkCYaBS8TLXbdQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FxwO3QQ2MvR1aNzKrNMX78BtU8ekxXoijbI3B2V9UjrYV+mOBP1vhJtNUbLL34I/6PS/tj41gj2IX3sXZ+UkZgu4NxlgS53Qy+3/ln6HcAIXvUGPBh+OHV6UW+qMyLMhpzovsW6PA/5wNfK756crFmEFjQ4Tvuha1LoVTyD2j1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D2sbpisB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6zOS8Ns6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 06 Dec 2025 09:10:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765012246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYxhsbe8d4U5Ju5XrFZ49DqX+4rS1i/047n1vc1PpUA=;
	b=D2sbpisBWa+Gt3MQuzGLrwIzlTO4R7KKOCHZQwKpiLsNq8LKCIkbCtJ9qj5YadzniIkhP/
	SX9ZD7RuTHNFw8GMVZzvMsDQE0vJCldtq+yums98Q5dDcZaFXyxhVDnZDDQyxlcpbt2ksy
	fds46/qwLPpz9yqkIzFzTBIeH+xfPf/rfUM94Xh4SloIQ1rnfWczprmrj2BXc+2BZXSH7w
	uomXdQprL5I8KKHibqdMHIqNiAMTtfGsVnuVDEPcTpJ20H3uuocTLnoU2HCmx5XtS+aQ2Y
	KVsXSlukA8l+nOFzerOoJ8WRda35t/ZMt8wCVLLtmc16AtTfsrW/9p+1uZ2eEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765012246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYxhsbe8d4U5Ju5XrFZ49DqX+4rS1i/047n1vc1PpUA=;
	b=6zOS8Ns6uG19qD4pm93kB4X2wHqmLKEVRhAUTfUqdFwbxrGRpDPw5lD3c+YlMTU0dQKo5g
	L/GZIHe/wGciaJAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/hrtick: Fix hrtick() vs. scheduling context
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250918080205.442967033@infradead.org>
References: <20250918080205.442967033@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176501224495.498.10732399590654383440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e38e5299747b23015b00b0109891815db44a2f30
Gitweb:        https://git.kernel.org/tip/e38e5299747b23015b00b0109891815db44=
a2f30
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 01 Sep 2025 22:46:29 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Dec 2025 10:03:13 +01:00

sched/hrtick: Fix hrtick() vs. scheduling context

The sched_class::task_tick() method is called on the donor
sched_class, and sched_tick() hands it rq->donor as argument,
which is consistent.

However, while hrtick() uses the donor sched_class, it then passes
rq->curr, which is inconsistent. Fix it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: John Stultz <jstultz@google.com>
Link: https://patch.msgid.link/20250918080205.442967033@infradead.org
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc358c1..1711e9e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -878,7 +878,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
=20
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->donor->sched_class->task_tick(rq, rq->curr, 1);
+	rq->donor->sched_class->task_tick(rq, rq->donor, 1);
 	rq_unlock(rq, &rf);
=20
 	return HRTIMER_NORESTART;


Return-Path: <linux-tip-commits+bounces-2924-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC8F9E0014
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF916161979
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840C4208977;
	Mon,  2 Dec 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTQvIuEP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eL5anKVN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF5207A20;
	Mon,  2 Dec 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138089; cv=none; b=RboMco63vPT7rfK0q5HAHIkXGIAywvZvfvj5HH076rdJ4UeT/M2kRJ5hF4fuUUQrgSaGzNrD/zmQCZZ3i5gWSlDfY3Z2deqGg5K4OutQWnxmz51J9ptlKpp2UvYNGAtqmMEBso1dVd7bcx3T1i9n2gBwC2mUwPiTWbOCbTtzkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138089; c=relaxed/simple;
	bh=ursKbUO6S5VIGgMABMfqciX/FeVWG/gfYIcodH5TExc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=az0rUfrEbf5Yrv8zUfsdAk8JZCqnLF0TgBu0itcvaPPTJgu3HiTfMC8gE/vEYRXyfqoadkImB9OWr0WB/v/BTrXTQfJgjZLRukvnJiCCGfwMHBKM+lpuVpHwD95vshjs9Znc9CeYV78SKjvJB/cSzi+pBA3pPc58aO7jJaavcUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTQvIuEP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eL5anKVN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRDb/x5M8Ru3MlzC+mhGdTqtrrFoX56V8d9NerMgwfY=;
	b=aTQvIuEPE+arkl8tRH8PTMh47EeFbvK5aNrTnR+JGy2sW0Q35EYwVCqD7giJtED7oJ0jch
	5197cBu3KMNfO6Sp80CQQPnwoR6imTTAugp79nr+1usRftGCsvqvOoisfoRY5sdvmLr7Sn
	VjsYM/4xjwZVCR9kH0pgBv+dvrdL5FjEuhjJUy8Vhgk0bYxzzWmfrUY5nNdQie8cwgQast
	MIql2StIEve/5IGU74F389U1bU5TwIdmcJshKCMTW86k7et0NS/E1XTbVYTS1c2Xe0yhWs
	1ir3jasCufm9Sjd2dPinAguiE/xFl6KLxVTKDB21FMPziORjHHnJ/sQEXaoFdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138086;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRDb/x5M8Ru3MlzC+mhGdTqtrrFoX56V8d9NerMgwfY=;
	b=eL5anKVNyGgDY/UgR4BllEty+HOckFYouB8PCuMYuiUhGYqix4k0qAcwgmyHsFidultt8b
	II+gbTlHivVVMECQ==
From: "tip-bot2 for Suleiman Souhlal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Don't try to catch up excess steal time.
Cc: Suleiman Souhlal <suleiman@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241118043745.1857272-1-suleiman@google.com>
References: <20241118043745.1857272-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313808536.412.12990354782102728168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     108ad0999085df2366dd9ef437573955cb3f5586
Gitweb:        https://git.kernel.org/tip/108ad0999085df2366dd9ef437573955cb3f5586
Author:        Suleiman Souhlal <suleiman@google.com>
AuthorDate:    Mon, 18 Nov 2024 13:37:45 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:30 +01:00

sched: Don't try to catch up excess steal time.

When steal time exceeds the measured delta when updating clock_task, we
currently try to catch up the excess in future updates.
However, this results in inaccurate run times for the future things using
clock_task, in some situations, as they end up getting additional steal
time that did not actually happen.
This is because there is a window between reading the elapsed time in
update_rq_clock() and sampling the steal time in update_rq_clock_task().
If the VCPU gets preempted between those two points, any additional
steal time is accounted to the outgoing task even though the calculated
delta did not actually contain any of that "stolen" time.
When this race happens, we can end up with steal time that exceeds the
calculated delta, and the previous code would try to catch up that excess
steal time in future clock updates, which is given to the next,
incoming task, even though it did not actually have any time stolen.

This behavior is particularly bad when steal time can be very long,
which we've seen when trying to extend steal time to contain the duration
that the host was suspended [0]. When this happens, clock_task stays
frozen, during which the running task stays running for the whole
duration, since its run time doesn't increase.
However the race can happen even under normal operation.

Ideally we would read the elapsed cpu time and the steal time atomically,
to prevent this race from happening in the first place, but doing so
is non-trivial.

Since the time between those two points isn't otherwise accounted anywhere,
neither to the outgoing task nor the incoming task (because the "end of
outgoing task" and "start of incoming task" timestamps are the same),
I would argue that the right thing to do is to simply drop any excess steal
time, in order to prevent these issues.

[0] https://lore.kernel.org/kvm/20240820043543.837914-1-suleiman@google.com/

Signed-off-by: Suleiman Souhlal <suleiman@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241118043745.1857272-1-suleiman@google.com
---
 kernel/sched/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c6d8232..4ffaef8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -766,13 +766,15 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
-		steal = paravirt_steal_clock(cpu_of(rq));
+		u64 prev_steal;
+
+		steal = prev_steal = paravirt_steal_clock(cpu_of(rq));
 		steal -= rq->prev_steal_time_rq;
 
 		if (unlikely(steal > delta))
 			steal = delta;
 
-		rq->prev_steal_time_rq += steal;
+		rq->prev_steal_time_rq = prev_steal;
 		delta -= steal;
 	}
 #endif


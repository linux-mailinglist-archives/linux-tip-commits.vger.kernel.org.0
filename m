Return-Path: <linux-tip-commits+bounces-8008-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6341D28929
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE8AB300A9DC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CED31A542;
	Thu, 15 Jan 2026 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OiUHkvx1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RXEYdzQT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3926F291;
	Thu, 15 Jan 2026 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510863; cv=none; b=fKB3mPy7miRVtz3wwKVZiAQc1UXJlTydmjfJawjla8JnvO8YzZlDTBjEkyqCSBQBXC7wmBzn1e7Q+w96w5hWGkxdsOQ11BSn+ZHrrX+3E6FQqzV4CKsd7rttpLkZU6QZROMOk/4Xr8lk4bQ3VzOyYzisKzZfXsZOZ9xQ2FZr85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510863; c=relaxed/simple;
	bh=TiOlrA6LpnwFksyAWhqQtuLsYrdxsKsYEK8habOW6x0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ab5X1fib1Aw2Sgp0FXfwVlrLd3ktupI9ovOPbALmxrLsEg6cKcoQJBWEHmg5pPbbV7zUsZxcNPJv7nSNq/wYfugCxeTxojSWK5qvi87qca1c12iFMTXEtRD22U8oyMuWSugn3X8L7dRgcqzFaBI6unFbJ/KKDn/nzuI5NDC5XVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OiUHkvx1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RXEYdzQT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:00:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768510859;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJLCD3E/9+dQSD6jqBumAvXMcMsvFsY+OMvUQep1OS4=;
	b=OiUHkvx1im3IGgYpLnOjw7lug5C0na1UAzkJrerL0gX/keL8xAVYpOhDgvecKlDA9HW3H7
	9RQdUD5SqxnTVHZbPZ9i/pPWAUHQLNpR3OULtiJeucjcdPol6mgr0kZSzwV5sve0n7/LEE
	PS8ubaMhG41YiLND0eDz71PTO9Vb3NtjMpQ2aWBRUVFAwzRlqTrK58NbnmDeWkfCiOzkD5
	B+9NYhaH4pJoOmV3WEKiTdeqPOl34u/c00RgF+QCsvq3XZ48Q9g1pnZRL+DEmHv3BpdLsZ
	81dbz61RICU+axE0TnoxZ1eF5TWLKJyB486hr6AEh/d2TQJ2v4v7Vy/1i/zFDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768510859;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJLCD3E/9+dQSD6jqBumAvXMcMsvFsY+OMvUQep1OS4=;
	b=RXEYdzQTc65fbZh+/EglOUNcvBNhnnOnTPpX+jK1GDJg//oZCCcNeInSbFn0hImcWJYbid
	4VVriimC/0zLGwBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/deadline: Use ENQUEUE_MOVE to allow priority change
Cc: Pierre Gondois <pierre.gondois@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114130528.GB831285@noisy.programming.kicks-ass.net>
References: <20260114130528.GB831285@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851085734.510.9880802160643380085.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     627cc25f84466d557d86e5dc67b43a4eea604c80
Gitweb:        https://git.kernel.org/tip/627cc25f84466d557d86e5dc67b43a4eea6=
04c80
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Jan 2026 09:27:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 21:57:53 +01:00

sched/deadline: Use ENQUEUE_MOVE to allow priority change

Pierre reported hitting balance callback warnings for deadline tasks
after commit 6455ad5346c9 ("sched: Move sched_class::prio_changed()
into the change pattern").

It turns out that DEQUEUE_SAVE+ENQUEUE_RESTORE does not preserve DL
priority and subsequently trips a balance pass -- where one was not
expected.

>From discussion with Juri and Luca, the purpose of this clause was to
deal with tasks new to DL and all those sites will have MOVE set (as
well as CLASS, but MOVE is move conservative at this point).

Per the previous patches MOVE is audited to always run the balance
callbacks, so switch enqueue_dl_entity() to use MOVE for this case.

Fixes: 6455ad5346c9 ("sched: Move sched_class::prio_changed() into the change=
 pattern")
Reported-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://patch.msgid.link/20260114130528.GB831285@noisy.programming.kick=
s-ass.net
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5d6f3cc..c509f2e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2214,7 +2214,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int fl=
ags)
 		update_dl_entity(dl_se);
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se);
-	} else if ((flags & ENQUEUE_RESTORE) &&
+	} else if ((flags & ENQUEUE_MOVE) &&
 		   !is_dl_boosted(dl_se) &&
 		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
 		setup_new_dl_entity(dl_se);


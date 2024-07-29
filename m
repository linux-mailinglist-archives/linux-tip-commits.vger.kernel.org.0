Return-Path: <linux-tip-commits+bounces-1791-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A826493F2C8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1384EB22320
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B87144315;
	Mon, 29 Jul 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3EN84Bbo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dAIdbvyl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB857143C60;
	Mon, 29 Jul 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249246; cv=none; b=PnPmijm0qP7D1lwaUeszQvfEh7IqXPQ/brZIne9l5LFD6RVEUN3WwcBKp5FIYSTmlc7ZIpBoSDKlZZYQzaDRsBcydtBZaBxffkg3OpFjj/g6tui4kUruzSP0mlyzQVTBhDZ9wMCKIxubkn7kV6R7NalYDRyU47poYq7qSlpuEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249246; c=relaxed/simple;
	bh=Mi/0iuOBwhBLJgviybxgNDNgrIhPYnvsWES7oz0Dv2w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pDpT+8raCDQGOuHvTU2uhbwtXGuHzqTezuzGu6/2KXCPBLp7zEOuOJKb3Y7969YnOA5Twe5hjOzNHktOJRrvyJBt0rFo9p8yoFhe994gVAoiaLHuNoSxJ0irR0l9+UabBeXj03VDXdY5sJqiujUAC4im0KDJ8bqmBN63bRfbz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3EN84Bbo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dAIdbvyl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C//YlGBZJB6Ap4k/EdpFsSZdWp/8yFEnQxtfliRwatk=;
	b=3EN84Bbo1PxAm/NxYjYBK13PDegYMGDcsx8GyjymS5Fwij1z5JFt3Bi/du+Q3bb+GDOxb5
	oQb9DPNEuN/z2UdToVjsHuTv2aeDs2TqgQjsf10l/0P6CfFDWhOf6wDVwaW3jYsaQjstrh
	+zfZphSCckmNklOlbqSQhClyzJ9qd0eQr50GjPHUTvDu1K/z87GWs05EhzijYxxPHd7LGg
	JyTiCGOdB75NMCzoM0uRXF4humt/D5cEAtOtrImTFp4OxRhuT8VqfEYHY58zgN6ozNGx4H
	LVWKwhFzTCKzbWX9lZP+bXKn8wWMKYMFcMRtc0n5nLWtP7ZmcoNT19TytsXXTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C//YlGBZJB6Ap4k/EdpFsSZdWp/8yFEnQxtfliRwatk=;
	b=dAIdbvylfmNsxGZ2WXAMn3jPgzG02uL2YRa21NV0lRMHCOiBmSVM8wWGytOfCX6HKay7u9
	NCHQi7oMfpK7ApDw==
From: "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/core: Fix priority checking for DL server picks
Cc: Suleiman Souhlal <suleiman@google.com>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vineeth Pillai <vineeth@bitbyteword.org>, Juri Lelli <juri.lelli@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <48b78521d86f3b33c24994d843c1aad6b987dda9.1716811044.git.bristot@kernel.org>
References:
 <48b78521d86f3b33c24994d843c1aad6b987dda9.1716811044.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924308.2215.6808870474287482096.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4b26cfdd395638918e370f62bd2c33e6f63ffb5e
Gitweb:        https://git.kernel.org/tip/4b26cfdd395638918e370f62bd2c33e6f63ffb5e
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Mon, 27 May 2024 14:06:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:36 +02:00

sched/core: Fix priority checking for DL server picks

In core scheduling, a DL server pick (which is CFS task) should be
given higher priority than tasks in other classes.

Not doing so causes CFS starvation. A kselftest is added later to
demonstrate this.  A CFS task that is competing with RT tasks can
be completely starved without this and the DL server's boosting
completely ignored.

Fix these problems.

Reported-by: Suleiman Souhlal <suleiman@google.com>
Signed-off-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vineeth Pillai <vineeth@bitbyteword.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/48b78521d86f3b33c24994d843c1aad6b987dda9.1716811044.git.bristot@kernel.org
---
 kernel/sched/core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f95600c..11abfcd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -163,6 +163,9 @@ static inline int __task_prio(const struct task_struct *p)
 	if (p->sched_class == &stop_sched_class) /* trumps deadline */
 		return -2;
 
+	if (p->dl_server)
+		return -1; /* deadline */
+
 	if (rt_prio(p->prio)) /* includes deadline */
 		return p->prio; /* [-1, 99] */
 
@@ -192,8 +195,24 @@ static inline bool prio_less(const struct task_struct *a,
 	if (-pb < -pa)
 		return false;
 
-	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
-		return !dl_time_before(a->dl.deadline, b->dl.deadline);
+	if (pa == -1) { /* dl_prio() doesn't work because of stop_class above */
+		const struct sched_dl_entity *a_dl, *b_dl;
+
+		a_dl = &a->dl;
+		/*
+		 * Since,'a' and 'b' can be CFS tasks served by DL server,
+		 * __task_prio() can return -1 (for DL) even for those. In that
+		 * case, get to the dl_server's DL entity.
+		 */
+		if (a->dl_server)
+			a_dl = a->dl_server;
+
+		b_dl = &b->dl;
+		if (b->dl_server)
+			b_dl = b->dl_server;
+
+		return !dl_time_before(a_dl->deadline, b_dl->deadline);
+	}
 
 	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
 		return cfs_prio_less(a, b, in_fi);


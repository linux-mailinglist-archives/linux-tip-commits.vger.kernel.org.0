Return-Path: <linux-tip-commits+bounces-2153-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860DB969F30
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCF11F23BA5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760A2AF16;
	Tue,  3 Sep 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2EgzKSfL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bbRZCqYh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD31E4A2;
	Tue,  3 Sep 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370706; cv=none; b=qbMo0n9P8BAu/w+Od4EqYhuXaQ/8UUc1kifobWH4OcRX2Dwxg8+rRfsXrBeaGFAlwyQR/R3Bf934W3tVgfsyQroQRfckMlWzdND6kpVqO0ci5VKbvpQwBJMvaCmXLeTzYK1TpSNytHvHTFO9aHIVTVVY0vzMeoXuJb9hcSs1A9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370706; c=relaxed/simple;
	bh=gtmkZQ/qXJfwUolPpHvFrthHEdHQ/vlEg7nWsJoqAG0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UO7WHVKSOA9cR+ZuYqBoYYwX9S/iFKCGATaslSzaLIMI3DDyjJVex7JjcWtnKEM0HL6O+8q5m4/Eeg7geB/+F2ZAj7eshe3j21S09bPKPQeNznWccq/kEh4AMH30Th1ndqi/zWtA0FwigjNuvUN1rjrk+CzkPHNuaUTaZfurq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2EgzKSfL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bbRZCqYh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Sep 2024 13:38:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725370702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNOphQIpFrVrbC3vE/7srUJMLhXfTkqTB+Lgyr287aY=;
	b=2EgzKSfLJjn/PVclciB/bVLT7AOtfw3z17Nc9Ru9iG7ZNlJOoHL0JFDIoOtK5vziBuJeam
	+zDBJoL/FGzIkeCrQZR8CUbGwq/5emPm6hJCG1/M7LxGIjqHq56LqUwMfRWRLxTPG4naY1
	I53TLnrVdsO2ZWEUVkt0a5GRRGOpYLWwMWSI2oizOZG1YcpDNVlPsIw64U16/f/j+wvhRd
	pXW1JPtLK+bDs+jgNr8ODlB9N3IqEDdg72fCxTnVERu/lbF/uf6n9FdCI/bhs2+ZczZLig
	kJtbT152klMrXoVQw17HVqjIodS3OMLQbe9geu3nhngjsKKe6CvJOIHpXEU5lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725370702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNOphQIpFrVrbC3vE/7srUJMLhXfTkqTB+Lgyr287aY=;
	b=bbRZCqYhtSPaah6BYEqExj0hpQnEutXhBR5KobCeM8SOWDvj7YwMCyCaL22m+CMcmtbgR7
	T5PILTZcyOnCu3BA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Use set_next_task(.first) where required
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240813224015.614146342@infradead.org>
References: <20240813224015.614146342@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172537070223.2215.3833729181349769741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7d2180d9d943d31491d77e336557f33670cfe7fd
Gitweb:        https://git.kernel.org/tip/7d2180d9d943d31491d77e336557f33670cfe7fd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 14 Aug 2024 00:25:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Sep 2024 15:26:30 +02:00

sched: Use set_next_task(.first) where required

Turns out the core_sched bits forgot to use the
set_next_task(.first=true) variant. Notably:

  pick_next_task() := pick_task() + set_next_task(.first = true)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240813224015.614146342@infradead.org
---
 kernel/sched/core.c  | 4 ++--
 kernel/sched/sched.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0165811..406b794 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6010,7 +6010,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		next = rq->core_pick;
 		if (next != prev) {
 			put_prev_task(rq, prev);
-			set_next_task(rq, next);
+			set_next_task_first(rq, next);
 		}
 
 		rq->core_pick = NULL;
@@ -6184,7 +6184,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 out_set_next:
-	set_next_task(rq, next);
+	set_next_task_first(rq, next);
 out:
 	if (rq->core->core_forceidle_count && next == rq->idle)
 		queue_core_balance(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2f5d658..d33311d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2363,6 +2363,10 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
 	next->sched_class->set_next_task(rq, next, false);
 }
 
+static inline void set_next_task_first(struct rq *rq, struct task_struct *next)
+{
+	next->sched_class->set_next_task(rq, next, true);
+}
 
 /*
  * Helper to define a sched_class instance; each one is placed in a separate


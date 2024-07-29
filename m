Return-Path: <linux-tip-commits+bounces-1805-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FD193F2E2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E338B23A74
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979B114659C;
	Mon, 29 Jul 2024 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MgsqPd7W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0s2V//z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9A145B18;
	Mon, 29 Jul 2024 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249252; cv=none; b=mZDU7jbXwRSgP3xb+uSq+YtF+4JmEcDjIHkuU5VxGKLTIU8QSPN6p+bGAfw4EM+daHw17YFfpV+33e+IKE+uCX1BGUA+01uUfKXWOyzF+41MzBLl0Y65GrvNlDOxb52zpg16SBLL+r1I6e0XMtcPeQQnmXNzafPLUWns+r0DaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249252; c=relaxed/simple;
	bh=XS+mT+VrAuLF8YM4TKovBNVA/TZTdiITh3ElGYHJlxk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R69//nX37DxyTjyCDPp4fv+bzkmamQXLLKDccmsCJxbEig4syDLpRiYXgA36UQoIuMr+Gk4RXM8toFya4sTg21nQL21Pw8ng0LkHZhiYAGU3YpFtgEtsEn6Lf47Mil39lx72OPbyPtAYVPU8jslJqBaPZkqajFlic/R53Ztkfaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MgsqPd7W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0s2V//z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V98rvIkgNZn/JIGSFebZUaiKs+GZcLsn2eJ/6B3HsBs=;
	b=MgsqPd7WStJshZ9ShRnLo3VrkRDZ4CaF1z2uAhVABW5DlHaRbXDKVc8CKIdNWQy+7TZyx5
	3IsyI3lmCE8ynEBgHL/KRWnBLr/evnixPjfLvcB1MtbC6RrP0Z7u1D02MSQ0xm8pAfsmfv
	GzNnL5MiE47xHRXU4kYKYZ2H/Lc2osKYihGF3vcnwC6EhPB9xXTk9W4u1HEeO0YlRPw29P
	KPzwsgQyH8cTDLLgWYSRV+iBAG06PoPQfh9r+uK6CMifEjeK8ZmijybiYY9UpByPcPrlac
	ylX0nYRD9COTdN+WlibfRWFbql0X5H/igSjvCbBce4vH7CcyQtQpp1cqyIk96g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V98rvIkgNZn/JIGSFebZUaiKs+GZcLsn2eJ/6B3HsBs=;
	b=Q0s2V//z7wZfIkbb66xR425msPIfeuYlpM2pq92K1wnIC6YdgjwtSbpTRpbduJLAQ5rhZ8
	Sl0Nx50d132UmXCw==
From: "tip-bot2 for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/core: Introduce sched_set_rq_on/offline() helper
Cc: stable@kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240703031610.587047-4-yangyingliang@huaweicloud.com>
References: <20240703031610.587047-4-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924890.2215.10394606121970381113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2f027354122f58ee846468a6f6b48672fff92e9b
Gitweb:        https://git.kernel.org/tip/2f027354122f58ee846468a6f6b48672fff92e9b
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Wed, 03 Jul 2024 11:16:09 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:32 +02:00

sched/core: Introduce sched_set_rq_on/offline() helper

Introduce sched_set_rq_on/offline() helper, so it can be called
in normal or error path simply. No functional changed.

Cc: stable@kernel.org
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240703031610.587047-4-yangyingliang@huaweicloud.com
---
 kernel/sched/core.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 949473e..4d119e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7845,6 +7845,30 @@ void set_rq_offline(struct rq *rq)
 	}
 }
 
+static inline void sched_set_rq_online(struct rq *rq, int cpu)
+{
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_online(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+static inline void sched_set_rq_offline(struct rq *rq, int cpu)
+{
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_offline(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 /*
  * used to mark begin/end of suspend/resume:
  */
@@ -7914,7 +7938,6 @@ static inline void sched_smt_present_dec(int cpu)
 int sched_cpu_activate(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
 
 	/*
 	 * Clear the balance_push callback and prepare to schedule
@@ -7943,12 +7966,7 @@ int sched_cpu_activate(unsigned int cpu)
 	 * 2) At runtime, if cpuset_cpu_active() fails to rebuild the
 	 *    domains.
 	 */
-	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_online(rq);
-	}
-	rq_unlock_irqrestore(rq, &rf);
+	sched_set_rq_online(rq, cpu);
 
 	return 0;
 }
@@ -7956,7 +7974,6 @@ int sched_cpu_activate(unsigned int cpu)
 int sched_cpu_deactivate(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
 	int ret;
 
 	/*
@@ -7987,12 +8004,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	synchronize_rcu();
 
-	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
-	}
-	rq_unlock_irqrestore(rq, &rf);
+	sched_set_rq_offline(rq, cpu);
 
 	/*
 	 * When going down, decrement the number of cores with SMT present.


Return-Path: <linux-tip-commits+bounces-2759-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A59BE49D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF2A1C2345D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9790C1DE4CA;
	Wed,  6 Nov 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hPnV3971";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lb13YhI1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002471DE3A2;
	Wed,  6 Nov 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890067; cv=none; b=k6pXe7l7xl0Whn27Xwx7Lx7V7Fx3TG/KGR5x2m/BV1BlBh2l8TNVr1ezTiNhGQLiVhB3itfuHeHsO6dlzvXOzjid57fbVjaE0rCLPWbtuc8MIXECmAj8TiB0HojszKBTyJSSu6ZEQz8e96tujm0/+2z+hhDPc6kq2z08HVxLDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890067; c=relaxed/simple;
	bh=moV8IWasGTN81Z3Q6PosMhpz3DEijlwV+76x94sMnJw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sGE5SpOVkgr84HvLTmIo1fqEWAvmMNRrlWYVn4TBjdnJn5H41HMV6PRaEHL9OFT5bmMazsb8Nn8mLrEgWKKRBIDCAgVQOXLX4m0wGl08Nn2ZToR/h0MOxq5UwR0e1Jjyj0TvrTReo5BlukpyXJjDwWeu2hwAPnEMGcFYW/tR/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hPnV3971; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lb13YhI1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:47:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890064;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=objdhy+RMyetWLbDPqaexCwVdVwZfK9p36hw0rsZs44=;
	b=hPnV3971qREZlOfXX8jPxSOlJeo69+fUDFKvE+uJ51PZdTgBvs0yXrpz8n8xjSiuypi28S
	+PGSKivreXlXQu/mZzo6rNlkoREbSk/H/GmsqF0UwQADSvTQ0u+zcvktU+tidKMXdECp/Q
	DtxACtmloQN4YPrKscg6W4g2OTtLRAztHSBazigQNxwYNd0qEo4p44mQhYgTk2cqwTy28n
	6kj7T5Od3ZlUckKHd13oycXzqB7IZ6n1JBtA01d6kKH5OYa26TVB1U0OeAabtbnw8bhXAu
	sjSlybqbANYJMztEXyacTps6l4Exj9t1vEqzRI3jjdJJ6v0txylZlxFndZhpaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890064;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=objdhy+RMyetWLbDPqaexCwVdVwZfK9p36hw0rsZs44=;
	b=lb13YhI1JPgd20JDNp0R9icEE+giJQp8hYEsuF3CaascX6ny4qbzlF6GqwUdd4S4zy12He
	dqI7vc/xV1GZ+PAg==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] time/sched_clock: Broaden sched_clock()'s
 instrumentation coverage
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104161910.780003-3-elver@google.com>
References: <20241104161910.780003-3-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089006323.32228.18347923409718973574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8ab40fc2b9086b915e46890bb9252dc7692f1da0
Gitweb:        https://git.kernel.org/tip/8ab40fc2b9086b915e46890bb9252dc7692f1da0
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 04 Nov 2024 16:43:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:35 +01:00

time/sched_clock: Broaden sched_clock()'s instrumentation coverage

Most of sched_clock()'s implementation is ineligible for instrumentation
due to relying on sched_clock_noinstr().

Split the implementation off into an __always_inline function
__sched_clock(), which is then used by the noinstr and instrumentable
version, to allow more of sched_clock() to be covered by various
instrumentation.

This will allow instrumentation with the various sanitizers (KASAN,
KCSAN, KMSAN, UBSAN). For KCSAN, we know that raw seqcount_latch usage
without annotations will result in false positive reports: tell it that
all of __sched_clock() is "atomic" for the latch reader; later changes
in this series will take care of the writers.

Co-developed-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241104161910.780003-3-elver@google.com
---
 kernel/time/sched_clock.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 85595fc..29bdf30 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -80,7 +80,7 @@ notrace int sched_clock_read_retry(unsigned int seq)
 	return raw_read_seqcount_latch_retry(&cd.seq, seq);
 }
 
-unsigned long long noinstr sched_clock_noinstr(void)
+static __always_inline unsigned long long __sched_clock(void)
 {
 	struct clock_read_data *rd;
 	unsigned int seq;
@@ -98,11 +98,23 @@ unsigned long long noinstr sched_clock_noinstr(void)
 	return res;
 }
 
+unsigned long long noinstr sched_clock_noinstr(void)
+{
+	return __sched_clock();
+}
+
 unsigned long long notrace sched_clock(void)
 {
 	unsigned long long ns;
 	preempt_disable_notrace();
-	ns = sched_clock_noinstr();
+	/*
+	 * All of __sched_clock() is a seqcount_latch reader critical section,
+	 * but relies on the raw helpers which are uninstrumented. For KCSAN,
+	 * mark all accesses in __sched_clock() as atomic.
+	 */
+	kcsan_nestable_atomic_begin();
+	ns = __sched_clock();
+	kcsan_nestable_atomic_end();
 	preempt_enable_notrace();
 	return ns;
 }


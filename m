Return-Path: <linux-tip-commits+bounces-5819-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3505AD84D2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09575189E5AD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11A4279DCF;
	Fri, 13 Jun 2025 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qFnoV5bJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tC8FYBtd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550BB2727E3;
	Fri, 13 Jun 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800265; cv=none; b=ZAlLAHMhJ2woeuVvyoOd5mkP7wTVMz9ddWlN+hMi9ojULRjqkudG6XmZm7KCuqf1DuSjJsqbpvAOjqVgZ+xDvNcj2NcVUxS35d2P0OSgKivUO32/jrrLcMxV5qrWdPS+lCbITVLkAvQBJYH8oyaSYX+EPbnjR75Ve9aPNKeVNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800265; c=relaxed/simple;
	bh=0AMZfhnIwRwuu7V5o03IRrgJNauRsXnWGnny+4IU1Gw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IQM+DrKNMZculYFPEKTz0JDoJqyvDAS/zO0zTXOlT//Wm7fl/fSUVYmIdq7HOy1uCXFD8a2XMJPNHQd/vurJ7o3uR7zB0aFYFp3iullUBolUR3aOl9AQdBY24SsfDiVggH8BfZN9CQHe/ApgoBPeIc7nxtl1mrX5Su/+wrdu1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qFnoV5bJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tC8FYBtd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OV0rqunmkX8amKY64c+YpHiWIM9kTzdckatMyzPHrs=;
	b=qFnoV5bJEYdH/XCkf6d4N0b3kWAqPNBhYzoZuc5gT9vYDfFaJgURYryotjmSuMgQNI5PNe
	wyMrMM0A5IWozaYa1X3/O4hrQOZKFWxdWwmPVidPatheoJ9gufsMn/ceeWrc5tvrT6PRr1
	Jgkl7J5Hi6pJK7BHXhlKLDl1RLkVMoI2hnbq7nurWzu5uN0l57f8ySRVcegUmw65FjLawK
	AMFdc0sHPDEmmUidaOa/xU7aNySq4a+C/GOI2waHgKj8sbicN0637wx31HCnmUtXoWzmhc
	Z2MFloseDWLO3eD2UmtAZv42JXwmbZOmMAsVd1AvvHusfKHviR5miAGCMOcI4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OV0rqunmkX8amKY64c+YpHiWIM9kTzdckatMyzPHrs=;
	b=tC8FYBtdjLXNFQpY/u+rjnmihZjMjh0UrfVHL4vUj8utEhRjI/mB17CSa7WOQKnkY9MOkl
	fG1yH36/di56TbAg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/clock.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-3-mingo@kernel.org>
References: <20250528080924.2273858-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980026088.406.3159322197524205354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bbb1b274e85b739ade5f9bc060a8c4fa00388e29
Gitweb:        https://git.kernel.org/tip/bbb1b274e85b739ade5f9bc060a8c4fa00388e29
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:14 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/clock.c

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-3-mingo@kernel.org
---
 kernel/sched/clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index e62b551..f5e6dd6 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -474,7 +474,7 @@ notrace void sched_clock_idle_wakeup_event(void)
 }
 EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 
-#else /* CONFIG_HAVE_UNSTABLE_SCHED_CLOCK */
+#else /* !CONFIG_HAVE_UNSTABLE_SCHED_CLOCK: */
 
 void __init sched_clock_init(void)
 {
@@ -492,7 +492,7 @@ notrace u64 sched_clock_cpu(int cpu)
 	return sched_clock();
 }
 
-#endif /* CONFIG_HAVE_UNSTABLE_SCHED_CLOCK */
+#endif /* !CONFIG_HAVE_UNSTABLE_SCHED_CLOCK */
 
 /*
  * Running clock - returns the time that has elapsed while a guest has been


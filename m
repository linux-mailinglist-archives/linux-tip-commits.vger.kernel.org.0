Return-Path: <linux-tip-commits+bounces-5816-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9271CAD849A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21133177FEF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E95A2F365A;
	Fri, 13 Jun 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TrI7BH/3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FqQCO5oP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F142ED857;
	Fri, 13 Jun 2025 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800262; cv=none; b=EQyW5yfkejN0qNQzakTF8l+6EUYXerwCbXCai5ys+6sj2NBUHZ/4UxPck7Dk+pCUjJ4lyYU9l4l6eHRfM75V4rSfVxY1poGRI+zkxFwegESgjhkxxIThB+w7vjzSCko0GJhQOeTj64RlZWNhJSTfjTxP1YETczZl0UM/WQ8eYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800262; c=relaxed/simple;
	bh=YsTJqgXCzmjxKd7oWdahJy+NR8dliU7011jwEQosxKc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VjjstsAKrNTWcDMA+nsttH+FXZZjUbKYN/ydyfutNnsonp7+2snoeen9H3z9TBf79xFYVxnFegAmMVEU0klwGWCDZ9BCjgP76e70RpKBc9SXuvt0dOQSYQV2R2ZULqXQuL4ZziOy+QwsCMoe3TNQXRA9t4LjYZywgRJcSNHWT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TrI7BH/3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FqQCO5oP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejDjetF/6f4i+oGbZVlrG237fAm1w66F/WwMI3mMiL4=;
	b=TrI7BH/3ANcQLINhjCYEbJeSkc1Sd9gnFZ+9jxoNla/VKJC5e0eHb7L+aKblynCRugSgTA
	GGQMSShK3GfGsEtk9pGXGv0+CQM6PO6dNoG5ZtlAl1ruNpKqkYnTPQXiaEHRurwH4sUYuS
	SPZ8zPcL0nmylACzJDwvgRMIbLx4aDBwyGEmvsoI1+hfC2rj9I7oZ/NOpsa6noZtkrG3jF
	Tj6DNQ/87MHlMqIyecoTSqdK0ee/2qDFRX0n4d660RdZ76WXG8brmtqXyJtFhTyez5a3ww
	nP/JOH5Lf9RHyYgADoHxx3VJiLNK0H9gr62prqrz+nUU/GD4elPlkffdFpGUjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejDjetF/6f4i+oGbZVlrG237fAm1w66F/WwMI3mMiL4=;
	b=FqQCO5oPYvFeP19jScmXggKsw5csw5QlqtuuHPP1KtOgKjLHXVdGYpuLGBpbJwJpBZeGzd
	NXM+DEhKOPaU20AQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/loadavg.c
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-12-mingo@kernel.org>
References: <20250528080924.2273858-12-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025295.406.5691782431674798418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c215dff7f80caab4a25160f0ded369eba5cb9190
Gitweb:        https://git.kernel.org/tip/c215dff7f80caab4a25160f0ded369eba5cb9190
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:16 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/loadavg.c

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

 - Fix whitespace noise and other inconsistencies.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-12-mingo@kernel.org
---
 kernel/sched/loadavg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index f6df84c..e3a1ce9 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -335,12 +335,12 @@ static void calc_global_nohz(void)
 	smp_wmb();
 	calc_load_idx++;
 }
-#else /* !CONFIG_NO_HZ_COMMON */
+#else /* !CONFIG_NO_HZ_COMMON: */
 
 static inline long calc_load_nohz_read(void) { return 0; }
 static inline void calc_global_nohz(void) { }
 
-#endif /* CONFIG_NO_HZ_COMMON */
+#endif /* !CONFIG_NO_HZ_COMMON */
 
 /*
  * calc_load - update the avenrun load estimates 10 ticks after the


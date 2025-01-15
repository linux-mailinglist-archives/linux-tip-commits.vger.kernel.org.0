Return-Path: <linux-tip-commits+bounces-3227-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F16A11D3E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDAC160767
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37BE3DAC10;
	Wed, 15 Jan 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NgiQQdEi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZkPlZaOW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895523F282;
	Wed, 15 Jan 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932642; cv=none; b=AcdJaVS0SL6LLw0jvUnxmNRJqYEJ9mD+1zn2J7T0v4SnJiAIRqW0HFBZqPdfKwnwQkxhuYuskU/kaFidgw7nmiRKsYNqvUAHJjPHpnnJBDiWcw/UQXxfuCyr2J2HsUlL3QdsnZmiCIah+SJOWLlAAv4UJiPB1pGAIAki/AhJZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932642; c=relaxed/simple;
	bh=znCBjG8XvFPQFn+pFVLiH7/Yad5d8PJY7mmESC4xdVk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WD81TBMfcB3OEfgQRoTTygdP41HnYDjcgz6KIY1JAh4Rj1kr++utGrT87ALjHNtVJmy9cHslAyK+nxYZqaQKDYccvntMQcPKWv0cnkj48bCcU84zv+IqUtwqm5yq51UqpFJUzrO6LgrCmXeLxyiVCgc2/SspG3bLwYp+7jVhDow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NgiQQdEi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZkPlZaOW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=432vMk0lBL3wDlAsPwLsMn0f9pDXxMPEFtgN7N3agiY=;
	b=NgiQQdEi3loX/CPyhp0Ixx5GZrzJvFl5px+Kf7NanC+nlnKM+ZQt4A73EGC1yGa3nlahvD
	zvwNXXhDTh1D5Yhvrd4HSAHMwJKkfnAobzOSwlYElvGqJbs3/Zle4PWLZZIXEGxRov1/v5
	bae9fOziUp6OzrtlrHtBBbzwHTxC6xZUdMK6L8dUNrFBB4xOi8lfm9Y4J4tq1HtcUTNi6e
	N0mJ8gXdrvt3tI2JoEEqh22r7pR37EWajS7jrVCwJu7HlE7HupgiRMsA0Bu9d/jLOZ41SQ
	aPEUnJ4BJDlzk8Mabcu/BM+vRmDOgmL1HS08aqlDlCXlCx6qtG72NJ3+GZ81yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=432vMk0lBL3wDlAsPwLsMn0f9pDXxMPEFtgN7N3agiY=;
	b=ZkPlZaOW3nq4uOAdtD1IMP+GEfv/Z9+b4XkhQEdv0XZNQ4kipzrrIXdcp1omIPmDAUinJx
	oj3qG3so/WLLCxAg==
From: "tip-bot2 for David Rientjes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Change need_resched warnings to pr_err
Cc: David Rientjes <rientjes@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Josh Don <joshdon@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <e8d52023-5291-26bd-5299-8bb9eb604929@google.com>
References: <e8d52023-5291-26bd-5299-8bb9eb604929@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263859.31546.8029050012535413270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8061b9f5e111a3012f8b691e5b75dd81eafbb793
Gitweb:        https://git.kernel.org/tip/8061b9f5e111a3012f8b691e5b75dd81eafbb793
Author:        David Rientjes <rientjes@google.com>
AuthorDate:    Thu, 09 Jan 2025 16:24:33 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:23 +01:00

sched/debug: Change need_resched warnings to pr_err

need_resched warnings, if enabled, are treated as WARNINGs.  If
kernel.panic_on_warn is enabled, then this causes a kernel panic.

It's highly unlikely that a panic is desired for these warnings, only a
stack trace is normally required to debug and resolve.

Thus, switch need_resched warnings to simply be a printk with an
associated stack trace so they are no longer in scope for panic_on_warn.

Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Acked-by: Josh Don <joshdon@google.com>
Link: https://lkml.kernel.org/r/e8d52023-5291-26bd-5299-8bb9eb604929@google.com
---
 kernel/sched/debug.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 5e8e84a..fd7e852 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1292,8 +1292,10 @@ void resched_latency_warn(int cpu, u64 latency)
 {
 	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
 
-	WARN(__ratelimit(&latency_check_ratelimit),
-	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
-	     "without schedule\n",
-	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
+	if (likely(!__ratelimit(&latency_check_ratelimit)))
+		return;
+
+	pr_err("sched: CPU %d need_resched set for > %llu ns (%d ticks) without schedule\n",
+	       cpu, latency, cpu_rq(cpu)->ticks_without_resched);
+	dump_stack();
 }


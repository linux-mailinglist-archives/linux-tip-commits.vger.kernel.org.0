Return-Path: <linux-tip-commits+bounces-5787-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A99AD8464
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CEA188FCD7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C862E6D08;
	Fri, 13 Jun 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wUSV/zSh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ng11vUE3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4F2E3394;
	Fri, 13 Jun 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800235; cv=none; b=iUhg3p0ofqnmgxA/adytiRTpuHtGyorBuQKow3DI52vjCqUf/6QZUfltcYobBUsdImO81+cJ5K6SONy0O74VWpIwOzTSTRORfWmEJzAmeaIgoOltklmmjv1h8cG8Cas0qeDVdwFBqHGw0FPXEmYzsZWqD0bCZoCoDE67n78VGEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800235; c=relaxed/simple;
	bh=2LYdxA42B/mpp8+vGF4/mb58wpdwyK/rosy4kyO4BE8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A/HJ7Vmh+kTrBa7uNCzLCHGRqlh5+mD7m1ka9Pc3KsjPJr+3UU4CjFi2SrHSJE9fnwF/BXDBZYqfj3o3Euw0gIOLYfEfyi3z451RhLct55MUDpLCdMxUvSsVvSFISMsjYvrnyLcw06r4E3IkFnYxUQCO1KvXYkg4b/YjBZIrCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wUSV/zSh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ng11vUE3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fH7EJYwhoap0x6TmKk6jqG/VkozNiWrDEVpRpsSTp4A=;
	b=wUSV/zSh5dUDq5aqalacYO9BVLxPptVrNCIZbBwkOWyN30iihUm0Fny4qYfsUU1nxk02oe
	+Av46wf01KwA3Koj+imlZmN/0uyAHZGgIo7fy6eZKuPpKNgrZtVVpcon7TpS8yDUpQXSYq
	htjKOlHFrsvvReRYxpI5i8eiHVl8HSPCwKrF4ZS/4vjKXyHhFchiqztApSStHv0QOgOqrH
	n6/eHXQ2E1YyQUPrDW6a8+p0/AmHImRA7T8wZugJwr//dy6BPpr5aWWKb/T2Jq7mWLlDA7
	IxEpXTUOUx1tAhAeb3bSO1NqHTqSv+nFvB3ZovWnRn9sw4cZ0W0C+b/3j4KUHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fH7EJYwhoap0x6TmKk6jqG/VkozNiWrDEVpRpsSTp4A=;
	b=Ng11vUE3xugPyk0ZHrrlyWz/6SzajYAT9udT+B7FYwE6Sb9OHYbZSpJZw6Z1tfHAmli+Ey
	wFM+VUlYbMcAtlCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of cpu_of()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-37-mingo@kernel.org>
References: <20250528080924.2273858-37-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980023158.406.17035812454114367831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     172408811961d7facbd1ec9af66893b058d5d542
Gitweb:        https://git.kernel.org/tip/172408811961d7facbd1ec9af66893b058d5d542
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:22 +02:00

sched/smp: Use the SMP version of cpu_of()

Simplify the scheduler by making CONFIG_SMP=y code in cpu_of()
unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-37-mingo@kernel.org
---
 kernel/sched/sched.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6bc8e42..234dd28 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1294,11 +1294,7 @@ static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
 
 static inline int cpu_of(struct rq *rq)
 {
-#ifdef CONFIG_SMP
 	return rq->cpu;
-#else
-	return 0;
-#endif
 }
 
 #define MDF_PUSH		0x01


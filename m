Return-Path: <linux-tip-commits+bounces-2062-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF7C955B2D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7666628250F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB7517C7C;
	Sun, 18 Aug 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M6D3kr6g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E2gARCg1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B931401C;
	Sun, 18 Aug 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962193; cv=none; b=g0Gr9yLulHAMAuZzShJ9KZkTbpBV0hczyYXeEbCQ/rLH4TjUDbTYwhs/+DsXzzMAGU1tSMnlaRgPOcASFc0KMxxvIgw1D/AQNDKKF88hdSCG7q62BXEfQHd1Fh9LiCSDm3RZ0Q7FiQQ7vo74pDKz9xXUFDEX8FCyzvW8xC5bMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962193; c=relaxed/simple;
	bh=MK9Vr/rgw9dOz7G618gvrVNz1shIKhxTvtHiZK77oeI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A2K+1oLskH7yUKxH140jZs+gE1hjCBXlJ9ghIHrlSloXt+U97p+lCnkby1BCUjpYvIRmHd/Mn2Z5nCa4LWpE49WI7qkcsbpsFfYaDWKwEFmbABSKMaiC3yydfmqh9mXQSBMh0WpHqhc+UrPKqNP9VDF6/FNojaXWQW0XSQu0Ei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M6D3kr6g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E2gARCg1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkU+Mfj0uphibWitP1caG2OqWz5t1LM4taXw2x9/QzE=;
	b=M6D3kr6gucUTHGKdPVLDTFrCoH/lokeCrtkH/eW9TC88nikzcBtrLgDUP1s4mIl+KNvX2C
	emmDQGlzfzutbchpf70LzE0H3wBdqk7QCXnfjF+7qWpq+XAchbC9luFTdOefB7QMFKm5XD
	pjhv+ia4M/asr98pe5Nx/tvi1p+whz0C4oPz39ZdW+Ox/LBKd9/GxSGmRts3VSbB2W0P3n
	Qo/xwQWG5k6Z0BgJL3YKhTyUcOXUNMENnP+rJ7QSwlndKnIpKeC432694Kg1mZcbo2VTdM
	/pCAVQ/57jTxagrPv4NEZq7VzJVNjZgC3aNNxbOvg1MdNwGxWU/94HLE5JdmOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkU+Mfj0uphibWitP1caG2OqWz5t1LM4taXw2x9/QzE=;
	b=E2gARCg1eUzT9I580NiB8oPSfsHd6Kr6FljbbJQocXLUN70lFRpl6qmFFgnEMEsNSrlhjX
	umzs4s2ANKh/0LCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,freezer: Mark TASK_FROZEN special
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105029.998329901@infradead.org>
References: <20240727105029.998329901@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218829.2215.16575655194610162180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a1c446611e31ca5363d4db51e398271da1dce0af
Gitweb:        https://git.kernel.org/tip/a1c446611e31ca5363d4db51e398271da1dce0af
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 01 Jul 2024 21:30:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:44 +02:00

sched,freezer: Mark TASK_FROZEN special

The special task states are those that do not suffer spurious wakeups,
TASK_FROZEN is very much one of those, mark it as such.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105029.998329901@infradead.org
---
 include/linux/sched.h | 5 +++--
 kernel/freezer.c      | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f4a648e..8a3a389 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -149,8 +149,9 @@ struct user_event_mm;
  * Special states are those that do not use the normal wait-loop pattern. See
  * the comment with set_special_state().
  */
-#define is_special_task_state(state)				\
-	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
+#define is_special_task_state(state)					\
+	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED |	\
+		    TASK_DEAD | TASK_FROZEN))
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 # define debug_normal_state_change(state_value)				\
diff --git a/kernel/freezer.c b/kernel/freezer.c
index f57aaf9..44bbd7d 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -72,7 +72,7 @@ bool __refrigerator(bool check_kthr_stop)
 		bool freeze;
 
 		raw_spin_lock_irq(&current->pi_lock);
-		set_current_state(TASK_FROZEN);
+		WRITE_ONCE(current->__state, TASK_FROZEN);
 		/* unstale saved_state so that __thaw_task() will wake us up */
 		current->saved_state = TASK_RUNNING;
 		raw_spin_unlock_irq(&current->pi_lock);


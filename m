Return-Path: <linux-tip-commits+bounces-5562-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43496AB96B6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 09:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 154D17AA239
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 07:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D006227E99;
	Fri, 16 May 2025 07:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tMhxtrrt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRC1Mvas"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90E215F56;
	Fri, 16 May 2025 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381199; cv=none; b=UKt7x8IH6n9mI/OqplJED4SkjQRqEPxCKFLCuYxfizkVHcLOrygHCRW8ZgRjA5HErx+iYoXJnl1iJQOgzkzBnoZfcLPCTp0F+T/0ocwtz7orsYM6SyYtsxcyCgiPreSdpbYknZJdUk0zDAQgYITNU+TBNBn1dhDDHE11ZC+qosE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381199; c=relaxed/simple;
	bh=XTjLqTcoNMdGSbSKnQQPkVayOTpXLo05+7q7IPtqkYo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LdmQQKlYLM/TGdpzaul6/JQgvocJAKABQAkhuuDB6Tx9+nCfHsxh0qkqA8TFG7tEu7ZaZNFn1mEAv98TZBajEDowS2v35OSqNKN0Wkc7/9pG/ZKB5vfPQGMSSOPPxOIv9zOiLkW+uP0g5xBAkxhDPeqrcEDsaYhX1PdKmV6gjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tMhxtrrt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRC1Mvas; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 07:39:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747381194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBrAnIgcsqjR5hm3aw2mc2dVx93ozX/mOPLOqZD8ffw=;
	b=tMhxtrrtwNuPtkLnJ4HnugPjGKFnN+z6KpNrxBkvWyuwgc5QHBcGQ49fzPVKAYp7D9nEBk
	xgnQAa8gFhJQHkdCs7Ir9TpgBsuyf82agrq2da5GaoX7n2FdK2DQr6NB4k+TL3oiuPG9aU
	u4wKXTdnXKhBYrJc03thkMgNQiKe3CHJbI/QoUbdJVM+qxhFeedCnFNqCv/jDjti98MhWE
	hrNwkybNr1dYtaRvZJuadewvpRvMhuwUF+0FJcbeu2nW5f0Xmuqgv5ERUYjzJAphEEy2hL
	vGOuC+fy0p0RoTT+sfrlQCVPrSGb63pOeODTeNS9i8M5hk7FvH/5PS3BuflX8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747381194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBrAnIgcsqjR5hm3aw2mc2dVx93ozX/mOPLOqZD8ffw=;
	b=wRC1MvasgNOrGpKA3vJut46RL02lYAP09KWXu1iMx6f4oYz2cEJmgTJStYJPlrOSJ66pNI
	8xyzJ/HbpUBbZiDg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Fix kernel-doc comments
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515171641.24073-1-bp@kernel.org # submission>
References: <20250515171641.24073-1-bp@kernel.org # submission>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738119305.406.5896356423889834809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     bd59f6170968314c82e2b65f8bbaec55896b7a5f
Gitweb:        https://git.kernel.org/tip/bd59f6170968314c82e2b65f8bbaec55896b7a5f
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 15 May 2025 19:16:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 May 2025 09:33:53 +02:00

futex: Fix kernel-doc comments

Fix those:

  ./kernel/futex/futex.h:208: warning: Function parameter or struct member 'drop_hb_ref' not described in 'futex_q'
  ./kernel/futex/waitwake.c:343: warning: expecting prototype for futex_wait_queue(). Prototype was for futex_do_wait() instead
  ./kernel/futex/waitwake.c:594: warning: Function parameter or struct member 'task' not described in 'futex_wait_setup'

Fixes: 93f1b6d79a73 ("futex: Move futex_queue() into futex_wait_setup()")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250512185641.0450a99b@canb.auug.org.au # report
Link: https://lore.kernel.org/r/20250515171641.24073-1-bp@kernel.org     # submission
---
 kernel/futex/futex.h    | 1 +
 kernel/futex/waitwake.c | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 069fc2a..fcd1617 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -175,6 +175,7 @@ typedef void (futex_wake_fn)(struct wake_q_head *wake_q, struct futex_q *q);
  * @requeue_pi_key:	the requeue_pi target futex key
  * @bitset:		bitset for the optional bitmasked wakeup
  * @requeue_state:	State field for futex_requeue_pi()
+ * @drop_hb_ref:	Waiter should drop the extra hash bucket reference if true
  * @requeue_wait:	RCU wait for futex_requeue_pi() (RT only)
  *
  * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index bd8fef0..b3738fb 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -334,8 +334,7 @@ out_unlock:
 static long futex_wait_restart(struct restart_block *restart);
 
 /**
- * futex_wait_queue() - futex_queue() and wait for wakeup, timeout, or signal
- * @hb:		the futex hash bucket, must be locked by the caller
+ * futex_do_wait() - wait for wakeup, timeout, or signal
  * @q:		the futex_q to queue up on
  * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
  */
@@ -578,7 +577,7 @@ int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
  * @flags:	futex flags (FLAGS_SHARED, etc.)
  * @q:		the associated futex_q
  * @key2:	the second futex_key if used for requeue PI
- * task:	Task queueing this futex
+ * @task:	Task queueing this futex
  *
  * Setup the futex_q and locate the hash_bucket.  Get the futex value and
  * compare it with the expected value.  Handle atomic faults internally.


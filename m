Return-Path: <linux-tip-commits+bounces-2541-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD89AF446
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 23:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5CA1F21A55
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF8022B655;
	Thu, 24 Oct 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E+FpeVZc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x2qJu0qf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD019E975;
	Thu, 24 Oct 2024 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804075; cv=none; b=MTNUtT6XMU9jVX/weZ7CHqbCjt+CEFtKv/+An1xFZ64pvbzEAsC55geDcEy3UES7bpbWqLgUOpFR7v2Ztc7ELkFjYNgNBlO2fjZlstePFQt7Fsd7jlH09xSF38Um2bidiSvoLDyPcMiTB8GjrxrgNYEy92Z3fHUUZsIqGOO3SmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804075; c=relaxed/simple;
	bh=smej1KRyESzyLO551AVldkRuwH/40XlvSPD3hKGYdE0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AusCKz+k9OpfHpFYFj+j6ULjL1PyYz0z22oIxvIT1TSxpewSG4sW4g5z06h+7mxh5tpUjIOzTFsdMpA4Z5ddoDMvHPibAwcrui6m4JkmqumFkplB1LRKo0gi7zeAKtQVPruw6gFXnYXBIjKBVkbiE4Idc467CYHx2SLuW4hlVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E+FpeVZc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x2qJu0qf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Oct 2024 21:07:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729804070;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6O3txLMp6xeBdCjeYgrvuk/bjWXisBT3qhFv2W4tDpM=;
	b=E+FpeVZcYrNiCOqOZVRnqmFqy05UKUB4ZgFOme7lGIlD2rNjwa3jqX+3S6wnZxmtJWGXrJ
	zNYv56w5H9/eUc+vVCZ8iei5Xfctm7z2r7aY54iNAZyYWtuV/lAaZ3Ls0fndEkTNUIVJ9+
	C7YkbNyq6QzWp9yJbH3v3gMPOmBhiTgCDEqMOZUzhqzwSYvkz0PyPMopTnXfAVzB4jxZPG
	4KJzVU6azWNu7QPasWczBfhIvyAzmgNv4QjqkAJQzmLW343TCzPxrXiyEPVrpo/7xCeQfa
	qWJcv0D2CWdc5vaeWQ3NpYk9Bi0CKwI0AD6qjFvFQMBvEcM00g3ds6FOeR8IhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729804070;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6O3txLMp6xeBdCjeYgrvuk/bjWXisBT3qhFv2W4tDpM=;
	b=x2qJu0qfznLXPrYJnmFGvDVsqok7+2JHuPhMouboMQdwE+o5m5Vw4vJXKHmyEIwvPKKAr3
	g8bNIoIY0DOMAGCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Fix misleading comment
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241008092606.GJ33184@noisy.programming.kicks-ass.net>
References: <20241008092606.GJ33184@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172980406969.1442.8080555865587712726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d12b802f183667d4c28589314c99c380a458d57e
Gitweb:        https://git.kernel.org/tip/d12b802f183667d4c28589314c99c380a458d57e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Oct 2024 11:26:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Oct 2024 23:03:30 +02:00

locking/rtmutex: Fix misleading comment

Going through the RCU-boost and rtmutex code, I ran into this utterly
confusing comment. Fix it to avoid confusing future readers.

[ tglx: Wordsmithed the comment ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/all/20241008092606.GJ33184@noisy.programming.kicks-ass.net

---
 kernel/locking/rtmutex_api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index a6974d0..7e79258 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -175,10 +175,10 @@ bool __sched __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
 	}
 
 	/*
-	 * We've already deboosted, mark_wakeup_next_waiter() will
-	 * retain preempt_disabled when we drop the wait_lock, to
-	 * avoid inversion prior to the wakeup.  preempt_disable()
-	 * therein pairs with rt_mutex_postunlock().
+	 * mark_wakeup_next_waiter() deboosts and retains preemption
+	 * disabled when dropping the wait_lock, to avoid inversion prior
+	 * to the wakeup.  preempt_disable() therein pairs with the
+	 * preempt_enable() in rt_mutex_postunlock().
 	 */
 	mark_wakeup_next_waiter(wqh, lock);
 


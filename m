Return-Path: <linux-tip-commits+bounces-2354-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2CB9941DD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D4D1F2AE87
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DA11E412A;
	Tue,  8 Oct 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cjIvrDha";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+1omvOJl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A61E2603;
	Tue,  8 Oct 2024 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374181; cv=none; b=edMQ+ILapnUNk1mD8K4eGV7/M+LyO8QwyZBjZ3mFoJbUAUffcwsrnDLAOo1WclNYzRAMXrXfiRXBeW0ESqahQW3Goc12ZcheyAuMIxZ5SJTO1H8TD43Sd0UsXfDmguj093d/CCQKdNpMQaQZNmj++BgPZfqjqtAUKw+BnGppCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374181; c=relaxed/simple;
	bh=tW6FjVs8rdfrSdbqB/hbyAeWQZ4AfQZbg52Z1De7wn4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LbrdB16hIiJ/zkCa6/TId8jRARiELfo7iO5nU7uT/Ws3v0GsspMebiLvivzplY9bP0+sqMHmhbkE9fz9lYR/o30AO8R5/LqyC0WHyLN3Ed6kO9pNzro21Kxa0kbmy9nszXVKZTFsXTMzfkp3sfHCu1Zu0bgv1clHOxnE3AQt/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cjIvrDha; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+1omvOJl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:56:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f33rXneyoOQoOG4fs6xv1oEWbm66pGkEy0QJQI2MWl8=;
	b=cjIvrDhapHREZrp+rwpMhhKX5LpDGK76Xd9aH36IAg5Qk7qymrV++eyCNzc3q6y8inFj/u
	lpRN0AQsYODXCRGtcWcY355rGHT5z7Zxb64oNF88+hA/b4tad0w1tHGJTkJqZ56KctYJ5i
	5BhEiCQc4EpNoxUYPYS9MaeAyVtnWZCybHxtJAOJuo5Ovcugj1qe47ptJvwlMDCQajzYLP
	ynzbCaZRU5SrlmbDG20abetoMhhA5QQJ0jhvii5dwvofXjiRqRgrQboJSSnk0mg/dD45Fw
	EVb5vxtcgyx23cS6gpS1jgSfavtVaUxkvr8Y5nNWMXpHdd7Kjp5c0a8ZzlL+FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f33rXneyoOQoOG4fs6xv1oEWbm66pGkEy0QJQI2MWl8=;
	b=+1omvOJlrqUArSJYO/YO5JGX+d3hw8BRENWx63dNmNsCrX+kwPk9qTGYNrbZnB+SxuPm49
	ZJ4NILwFfREL82Dw==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/wait: Remove unused bit_wait_io_timeout
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001234016.231696-1-linux@treblig.org>
References: <20241001234016.231696-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837417767.1442.4080625791503272844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0ac8f14ef22a1592b44dc90272aab35e43b0106a
Gitweb:        https://git.kernel.org/tip/0ac8f14ef22a1592b44dc90272aab35e43b0106a
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Wed, 02 Oct 2024 00:40:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:41 +02:00

sched/wait: Remove unused bit_wait_io_timeout

bit_wait_io_timeout has been unused since 2016's
commit 62906027091f ("mm: add PageWaiters indicating tasks are waiting for a page bit")

Remove it.

Signed-off-by: "Dr. David Alan Gilbert" <linux@treblig.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Link: https://lore.kernel.org/r/20241001234016.231696-1-linux@treblig.org
---
 include/linux/wait_bit.h |  1 -
 kernel/sched/wait_bit.c  | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 6346e26..9e29d79 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -49,7 +49,6 @@ int wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync
 extern int bit_wait(struct wait_bit_key *key, int mode);
 extern int bit_wait_io(struct wait_bit_key *key, int mode);
 extern int bit_wait_timeout(struct wait_bit_key *key, int mode);
-extern int bit_wait_io_timeout(struct wait_bit_key *key, int mode);
 
 /**
  * wait_on_bit - wait for a bit to be cleared
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 22ec270..b410b61 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -266,20 +266,6 @@ __sched int bit_wait_timeout(struct wait_bit_key *word, int mode)
 }
 EXPORT_SYMBOL_GPL(bit_wait_timeout);
 
-__sched int bit_wait_io_timeout(struct wait_bit_key *word, int mode)
-{
-	unsigned long now = READ_ONCE(jiffies);
-
-	if (time_after_eq(now, word->timeout))
-		return -EAGAIN;
-	io_schedule_timeout(word->timeout - now);
-	if (signal_pending_state(mode, current))
-		return -EINTR;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bit_wait_io_timeout);
-
 void __init wait_bit_init(void)
 {
 	int i;


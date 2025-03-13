Return-Path: <linux-tip-commits+bounces-4195-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4F0A5F282
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E9C3AC15F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAFE267F4B;
	Thu, 13 Mar 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UuLKFJub";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3rnED6e/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2C267B1F;
	Thu, 13 Mar 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865499; cv=none; b=tfcbAv2S2GUoo2TYLwFSfU5zuT0eAjK9PMH9fvDI6SWNoJ30uLktxZ5UHWS+HV3iiFugFKVODquLM5NXkJSZwwSUHja87vKtqYH9aLhMCsJZWrl1QprRBLPhq8s1l6jwdrI3RMEkCa5dT0KZkbH7pQNw1KZRWeasykyYutmyqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865499; c=relaxed/simple;
	bh=giiXFqG0ECv8pLtzVv5KhENJdxNUeBg3ZKFFdD775cw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QPtIsCLT8rG9WoYWSJL85TTpOl+cH1fcqu9pYZWsJBepFvWINZztiYwYDJROL8087wC0huXUXcTz4FpfJfxWlF6magxTH6Ow4hksSmhUEP0SN0xguItrceQ778kGNrNXryRJOmPmeLzC8OzqptC1JF8WFj6Y4DFvtbzxR+JbxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UuLKFJub; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3rnED6e/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbrwDLDH/I00EU0IjAgCs1c+CH/2TjX2wk2KkRTzaQs=;
	b=UuLKFJubtOTjHmskwKMCNF7emCOQCoH3VvduaJl1G99YG29H5Kw5WDiGatvfg6OoOzMBqI
	uwiF2W9SgzaljvHuiuylvgZYUg4HkS+vxihSAPbQu/+A6R9mbqy+gTTyPiOrr9ii6sCVJ+
	Q33sEaEm0456e7yqqBnwMM2OF0eZb+7v1IKAMAdrGuwc2IGo4XM2MlO+EwdU7CNwDtpQf+
	97r8AWUuPMbQ3GJ8YJYgE/q1x79WF/tnhQbyJQ1TVhr3JMb+eeSNx+febzj0QZv3B+GXxZ
	4TP6Nl5Al1gu0ABrlqBLOdqetsE4CTCbBKSymu8V8YE2shj5sw2lvMz2zQF4NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865496;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbrwDLDH/I00EU0IjAgCs1c+CH/2TjX2wk2KkRTzaQs=;
	b=3rnED6e/xmHqDXtNGj0Vc7FvIjlqy6m7fNoggUi96Ms5e+yC9mp9i0KKhT7ttLVwGwk+WJ
	PXvu1sd+MLxzPjAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Ensure that timer initialization is
 fully visible
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155623.507944489@linutronix.de>
References: <20250308155623.507944489@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186549544.14745.7505846509956238171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2389c6efd3ad8edb3bcce0019b4edcc7d9c7de19
Gitweb:        https://git.kernel.org/tip/2389c6efd3ad8edb3bcce0019b4edcc7d9c7de19
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Mar 2025 17:48:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:16 +01:00

posix-timers: Ensure that timer initialization is fully visible

Frederic pointed out that the memory operations to initialize the timer are
not guaranteed to be visible, when __lock_timer() observes timer::it_signal
valid under timer::it_lock:

  T0                                      T1
  ---------                               -----------
  do_timer_create()
      // A
      new_timer->.... = ....
      spin_lock(current->sighand)
      // B
      WRITE_ONCE(new_timer->it_signal, current->signal)
      spin_unlock(current->sighand)
					sys_timer_*()
					   t =  __lock_timer()
						  spin_lock(&timr->it_lock)
						  // observes B
						  if (timr->it_signal == current->signal)
						    return timr;
			                   if (!t)
					       return;
					// Is not guaranteed to observe A

Protect the write of timer::it_signal, which makes the timer valid, with
timer::it_lock as well. This guarantees that T1 must observe the
initialization A completely, when it observes the valid signal pointer
under timer::it_lock. sighand::siglock must still be taken to protect the
signal::posix_timers list.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250308155623.507944489@linutronix.de

---
 kernel/time/posix-timers.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 44ba7db..6bf468b 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -462,14 +462,21 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	if (error)
 		goto out;
 
-	spin_lock_irq(&current->sighand->siglock);
-	/* This makes the timer valid in the hash table */
-	WRITE_ONCE(new_timer->it_signal, current->signal);
-	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
-	spin_unlock_irq(&current->sighand->siglock);
 	/*
-	 * After unlocking sighand::siglock @new_timer is subject to
-	 * concurrent removal and cannot be touched anymore
+	 * timer::it_lock ensures that __lock_timer() observes a fully
+	 * initialized timer when it observes a valid timer::it_signal.
+	 *
+	 * sighand::siglock is required to protect signal::posix_timers.
+	 */
+	scoped_guard (spinlock_irq, &new_timer->it_lock) {
+		guard(spinlock)(&current->sighand->siglock);
+		/* This makes the timer valid in the hash table */
+		WRITE_ONCE(new_timer->it_signal, current->signal);
+		hlist_add_head(&new_timer->list, &current->signal->posix_timers);
+	}
+	/*
+	 * After unlocking @new_timer is subject to concurrent removal and
+	 * cannot be touched anymore
 	 */
 	return 0;
 out:


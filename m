Return-Path: <linux-tip-commits+bounces-2217-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9649C97207B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E301285170
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7367A17C98C;
	Mon,  9 Sep 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RlsXhHPC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6wGEc5C8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72517799F;
	Mon,  9 Sep 2024 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902865; cv=none; b=n1b43HlcPFB6JExpgAExMDaj8vpEtpHe6H7hd5T2U/Hx55Ttoww0gIid6AU4Dyim5zU355Z33DDHkxpj2Z93Wp3ihs8jM7r7x5BzZW0cFDdhZ1bMowXIUl6SdYupuNWv/MRsThoyuGlgWYlHRIJRUigRer44//FGgTewwPWc+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902865; c=relaxed/simple;
	bh=1Bndh6fxwZRk1KXgpVszKvDGQ4SamFu1smtdmC5wyW8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ggk26cgH/Ndgk1UA38C21ymWc5drz2HXt2j4z1NUHS1ApsPTORKtRLihoJDadWVF6jiTrR+UFcNitQpiUmiqg28kEXU2vWA/1ODTVdhtx+iJl3ZfDpL1EFkuDUyxoHGKMGl09eDYrkE3GHHyqBM1Mo1PmYs8l1IgsXwzpYGlYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RlsXhHPC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6wGEc5C8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5UDGa6bCFH7ot+Y6NuicHuiY0KX2B+4r2uT5CFEuMU=;
	b=RlsXhHPCnCytQD/oZJpB/nH3lt6at8bQMuYEYZqt7zPF24TTJnQhKp4M5pFS9sZ/+C+mq9
	RSFXo29eIUW4cjKYtOReoYmHPgQZjwRpW8aeMcuA6ICVjZniMype56ZWV1s+/b0T/3GY/0
	2Hu85bfX8BrO0RrNnk+q3Cchh/LGn4r+RVh45ziIsANbgXFFZE1F3VQF5zs9N+r9FuQC+K
	pCJLVcpRYLjR5I9R2FQFD2N8rSGsanpU2+C4Q3sEyDFCggwhez5By0XcFKDA116DJqFAzu
	ccx5x6WBKEk+gALQLpZzqp5HucCKKKnVecsyirmZI66ICkzr42jhFuxx+DF18g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5UDGa6bCFH7ot+Y6NuicHuiY0KX2B+4r2uT5CFEuMU=;
	b=6wGEc5C8BYKlW9SgMBnhQ7aeP40ki9vDOOCR55t+BHcYEB4jATKAAsjXN1zPyholD34KAp
	Kgn0VkkMNcgHo3AQ==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: Avoid false positive lockdep report for
 legacy printing
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-18-john.ogness@linutronix.de>
References: <20240904120536.115780-18-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286176.2215.16089616119771582666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     daeed1595b4ddf314bad8ee40b2662e03fd012dc
Gitweb:        https://git.kernel.org/tip/daeed1595b4ddf314bad8ee40b2662e03fd012dc
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:36 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:33 +02:00

printk: Avoid false positive lockdep report for legacy printing

Legacy console printing from printk() caller context may invoke
the console driver from atomic context. This leads to a lockdep
splat because the console driver will acquire a sleeping lock
and the caller may already hold a spinning lock. This is noticed
by lockdep on !PREEMPT_RT configurations because it will lead to
a problem on PREEMPT_RT.

However, on PREEMPT_RT the printing path from atomic context is
always avoided and the console driver is always invoked from a
dedicated thread. Thus the lockdep splat on !PREEMPT_RT is a
false positive.

For !PREEMPT_RT override the lock-context before invoking the
console driver to avoid the false positive.

Do not override the lock-context for PREEMPT_RT in order to
allow lockdep to catch any real locking context issues related
to the write callback usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-18-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 83 +++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index afd9266..5787232 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2982,6 +2982,34 @@ out:
 }
 
 /*
+ * Legacy console printing from printk() caller context does not respect
+ * raw_spinlock/spinlock nesting. For !PREEMPT_RT the lockdep warning is a
+ * false positive. For PREEMPT_RT the false positive condition does not
+ * occur.
+ *
+ * This map is used to temporarily establish LD_WAIT_SLEEP context for the
+ * console write() callback when legacy printing to avoid false positive
+ * lockdep complaints, thus allowing lockdep to continue to function for
+ * real issues.
+ */
+#ifdef CONFIG_PREEMPT_RT
+static inline void printk_legacy_allow_spinlock_enter(void) { }
+static inline void printk_legacy_allow_spinlock_exit(void) { }
+#else
+static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
+
+static inline void printk_legacy_allow_spinlock_enter(void)
+{
+	lock_map_acquire_try(&printk_legacy_map);
+}
+
+static inline void printk_legacy_allow_spinlock_exit(void)
+{
+	lock_map_release(&printk_legacy_map);
+}
+#endif /* CONFIG_PREEMPT_RT */
+
+/*
  * Used as the printk buffers for non-panic, serialized console printing.
  * This is for legacy (!CON_NBCON) as well as all boot (CON_BOOT) consoles.
  * Its usage requires the console_lock held.
@@ -3030,31 +3058,46 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		con->dropped = 0;
 	}
 
-	/*
-	 * While actively printing out messages, if another printk()
-	 * were to occur on another CPU, it may wait for this one to
-	 * finish. This task can not be preempted if there is a
-	 * waiter waiting to take over.
-	 *
-	 * Interrupts are disabled because the hand over to a waiter
-	 * must not be interrupted until the hand over is completed
-	 * (@console_waiter is cleared).
-	 */
-	printk_safe_enter_irqsave(flags);
-	console_lock_spinning_enable();
+	/* Write everything out to the hardware. */
 
-	/* Do not trace print latency. */
-	stop_critical_timings();
+	if (force_legacy_kthread() && !panic_in_progress()) {
+		/*
+		 * With forced threading this function is in a task context
+		 * (either legacy kthread or get_init_console_seq()). There
+		 * is no need for concern about printk reentrance, handovers,
+		 * or lockdep complaints.
+		 */
 
-	/* Write everything out to the hardware. */
-	con->write(con, outbuf, pmsg.outbuf_len);
+		con->write(con, outbuf, pmsg.outbuf_len);
+		con->seq = pmsg.seq + 1;
+	} else {
+		/*
+		 * While actively printing out messages, if another printk()
+		 * were to occur on another CPU, it may wait for this one to
+		 * finish. This task can not be preempted if there is a
+		 * waiter waiting to take over.
+		 *
+		 * Interrupts are disabled because the hand over to a waiter
+		 * must not be interrupted until the hand over is completed
+		 * (@console_waiter is cleared).
+		 */
+		printk_safe_enter_irqsave(flags);
+		console_lock_spinning_enable();
 
-	start_critical_timings();
+		/* Do not trace print latency. */
+		stop_critical_timings();
 
-	con->seq = pmsg.seq + 1;
+		printk_legacy_allow_spinlock_enter();
+		con->write(con, outbuf, pmsg.outbuf_len);
+		printk_legacy_allow_spinlock_exit();
 
-	*handover = console_lock_spinning_disable_and_check(cookie);
-	printk_safe_exit_irqrestore(flags);
+		start_critical_timings();
+
+		con->seq = pmsg.seq + 1;
+
+		*handover = console_lock_spinning_disable_and_check(cookie);
+		printk_safe_exit_irqrestore(flags);
+	}
 skip:
 	return true;
 }


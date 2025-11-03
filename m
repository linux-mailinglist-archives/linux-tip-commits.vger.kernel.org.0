Return-Path: <linux-tip-commits+bounces-7202-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB950C2C9C7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20025427E58
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3202131D39C;
	Mon,  3 Nov 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0AGvO3Js";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5SkfcIYP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F131B837;
	Mon,  3 Nov 2025 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181278; cv=none; b=hpvUTvieElbzuyxBYI0yEk7uliX9FMxKL7/vmjZkA74DlJs9h4ZnzkCkZIwbyW2C+2nPVY+e807XLiJl6viklx4G/k38VPx8YzrlYngAC6PGh6sbAZMlRvcnpR4kuX7Dcm4VHD3Jp48+Jjmxgy/P/IL5M1krdI7eKybrl4YIZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181278; c=relaxed/simple;
	bh=wd0FIHtXop0dejChzXMfuUCEjUlbZesvC+QHFydj+cQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YUQiw7xvaK+GlmKHkSOrSzugW+l+DniAjG7K3gotUffdxk+ClPBWZpFobL51Bc7+e8qx0uryeD4TxnwBf8k4MaQdmX+Q5zaD40ht8i2iti+od5jPpKCn/APUYmJ4w+ZnDDlZnNdJLO7j4DNmXWm+6LvOFEVjmnSEwKJSdalIx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0AGvO3Js; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5SkfcIYP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9CqsLkw5wK6/Pcx0ETjrJIjMCGgroNr6gOEYaPFu0o=;
	b=0AGvO3JsVAx3Ef9e29ElNEe010A5Lt3sMyAloqqVoCavYrgJ1kMAmlukIij6biYZ1Fuk+h
	rC427n2/erQHYj6jweVWuNB2VsyLEY1Mj/yjWV5F5GLusXEmf/VOY8c6HNsuIOdJGij6Xl
	HYHBs4qK/deoNEye/s2dY4xXxBPBljsyiCmBS+2G+o3RTXszuECdwIYnwGrPC+QhLAFgS7
	X8/VSfy+cADnYBvuIPStXm6QfQ/4gWcuX4nPYTxEPwkH0/Eh7IM9U9R64hhojiLdqXCqRK
	6X/atOBlHnWqBB0kjOR2XTi+LqpFQa1iMu1IskPNReuHop3cbIi8G5zngKrHVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9CqsLkw5wK6/Pcx0ETjrJIjMCGgroNr6gOEYaPFu0o=;
	b=5SkfcIYPlEcvzMClKw5IdWFh4QDw16IsxHVXWjbx39QND3+d8QqY8Pcq6s/4+FeUBdE+nn
	AOlZ3AA0RKIQ5lCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Remove the ksig argument from
 rseq_handle_notify_resume()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.211520245@linutronix.de>
References: <20251027084306.211520245@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218127376.2601451.597933954988975518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     fd41ddc3ac6329c242faefccadabbdfa8512fee4
Gitweb:        https://git.kernel.org/tip/fd41ddc3ac6329c242faefccadabbdfa851=
2fee4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:13 +01:00

rseq: Remove the ksig argument from rseq_handle_notify_resume()

There is no point for this being visible in the resume_to_user_mode()
handling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.211520245@linutronix.de
---
 include/linux/resume_user_mode.h |  2 +-
 include/linux/rseq.h             | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/resume_user_mode.h b/include/linux/resume_user_mod=
e.h
index e0135e0..dd3bf7d 100644
--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -59,7 +59,7 @@ static inline void resume_user_mode_work(struct pt_regs *re=
gs)
 	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
=20
-	rseq_handle_notify_resume(NULL, regs);
+	rseq_handle_notify_resume(regs);
 }
=20
 #endif /* LINUX_RESUME_USER_MODE_H */
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 21f875a..d72ddf7 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -37,19 +37,20 @@ static inline void rseq_set_notify_resume(struct task_str=
uct *t)
=20
 void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
=20
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
+static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
 	if (current->rseq)
-		__rseq_handle_notify_resume(ksig, regs);
+		__rseq_handle_notify_resume(NULL, regs);
 }
=20
 static inline void rseq_signal_deliver(struct ksignal *ksig,
 				       struct pt_regs *regs)
 {
-	scoped_guard(RSEQ_EVENT_GUARD)
-		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
-	rseq_handle_notify_resume(ksig, regs);
+	if (current->rseq) {
+		scoped_guard(RSEQ_EVENT_GUARD)
+			__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
+		__rseq_handle_notify_resume(ksig, regs);
+	}
 }
=20
 /* rseq_preempt() requires preemption to be disabled. */
@@ -103,7 +104,7 @@ static inline void rseq_execve(struct task_struct *t)
=20
 #else /* CONFIG_RSEQ */
 static inline void rseq_set_notify_resume(struct task_struct *t) { }
-static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt=
_regs *regs) { }
+static inline void rseq_handle_notify_resume(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs) { }
 static inline void rseq_preempt(struct task_struct *t) { }
 static inline void rseq_migrate(struct task_struct *t) { }


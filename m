Return-Path: <linux-tip-commits+bounces-7082-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506AC19C32
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672891C27B5B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD0934A3CE;
	Wed, 29 Oct 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dEFiYKov";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hb6Vw2F+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F98347FF5;
	Wed, 29 Oct 2025 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733446; cv=none; b=HFyNbSx2lYEga9Kg5Upm74NzmAh1Pu7YzKMLpd/bJbOd9+Gw3Lg2IsH149OBz/H6MVAYCsmyca627W9RHbwws0lOKSVCcFIhG7a9Au2wnDDS4+8YMtIbafzYaXi4XiOEHdehcuSlXx7ItpN0JrRvk6mJm+oVcmoM3lIX5+5vGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733446; c=relaxed/simple;
	bh=+rRVromzDP369onlm0OYTjXiVsuEVwlsnZbwvQXw8t0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P73cgwEZcCsjD17SJyQvfUe++34wnC9pWWXgh8EYgWTZ6n23dZCmEY+f//7vxNXu3D/t6e0GtbZ1xmiH7+oNRCwAyONydfiP9pANgJDG3NrRpHuiTLGeic4VZyOjDdr+UF10iLpkFPMtJwiz1ZiRE3bR0Qev3SdSNnk+1WUsaL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dEFiYKov; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hb6Vw2F+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:24:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq+k3eI7NazxoTnXUazb806OspZTeQcMt4KKyk5Owzg=;
	b=dEFiYKovQzIyw1Lc8M+QV/c+lbjzcMHSQngtnfV6fR/n0n/jh2RVKO2+mof4BmzmsFl+IO
	zV4nrToRGbD5iVBc90hj7LgVSDFWrYBpueJzw+4IqrRK2SiL7NunVT7A0PtBBnVLDmWDBN
	XPRt2CYxDY+KfovZizVDzkUVR+4M4Pd0G9Pxa4WLBVQ6lcIpb6eGc9uOHqoShEqg3GNirI
	Dntg1QExmDUrK5wpom3vYtV3zN4JD+8LYA7myJia115AFWArwrGH96QuTFo20Zz66DMY4M
	VfoVZxysY1XkjyukVqSN+r62tthf9/a232KFiopMsOjWuycRMBvteWHKmzHJQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq+k3eI7NazxoTnXUazb806OspZTeQcMt4KKyk5Owzg=;
	b=hb6Vw2F+Evd83kxm+6y2mIwGYWcgFiL4ufJx6ulf3Rt/9I1kE7r9w91MCtcVfRdVk44yyu
	1k7t1s3PhafG26Bg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Condense the inline stubs
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.085971048@linutronix.de>
References: <20251027084306.085971048@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173344186.2601451.4068626607498819781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     1bf005a23953e6d0afd16a161041ca6fae753739
Gitweb:        https://git.kernel.org/tip/1bf005a23953e6d0afd16a161041ca6fae7=
53739
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:11 +01:00

rseq: Condense the inline stubs

Scrolling over tons of pointless

{
}

lines to find the actual code is annoying at best.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.085971048@linutronix.de
---
 include/linux/rseq.h | 47 ++++++++++---------------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 7622b73..21f875a 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -101,44 +101,21 @@ static inline void rseq_execve(struct task_struct *t)
 	t->rseq_event_mask =3D 0;
 }
=20
-#else
-
-static inline void rseq_set_notify_resume(struct task_struct *t)
-{
-}
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
-{
-}
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
-{
-}
-static inline void rseq_preempt(struct task_struct *t)
-{
-}
-static inline void rseq_migrate(struct task_struct *t)
-{
-}
-static inline void rseq_fork(struct task_struct *t, u64 clone_flags)
-{
-}
-static inline void rseq_execve(struct task_struct *t)
-{
-}
+#else /* CONFIG_RSEQ */
+static inline void rseq_set_notify_resume(struct task_struct *t) { }
+static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt=
_regs *regs) { }
+static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs) { }
+static inline void rseq_preempt(struct task_struct *t) { }
+static inline void rseq_migrate(struct task_struct *t) { }
+static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
+static inline void rseq_execve(struct task_struct *t) { }
 static inline void rseq_exit_to_user_mode(void) { }
-#endif
+#endif  /* !CONFIG_RSEQ */
=20
 #ifdef CONFIG_DEBUG_RSEQ
-
 void rseq_syscall(struct pt_regs *regs);
-
-#else
-
-static inline void rseq_syscall(struct pt_regs *regs)
-{
-}
-
-#endif
+#else /* CONFIG_DEBUG_RSEQ */
+static inline void rseq_syscall(struct pt_regs *regs) { }
+#endif /* !CONFIG_DEBUG_RSEQ */
=20
 #endif /* _LINUX_RSEQ_H */


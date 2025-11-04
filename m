Return-Path: <linux-tip-commits+bounces-7249-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6DBC2FD73
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FB93A57F6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB5321F39;
	Tue,  4 Nov 2025 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iOHF4yX9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fuJ7iMHt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE9320CAF;
	Tue,  4 Nov 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244264; cv=none; b=qrnhh6axZufAwgatH4YjJ9X+QfUeiSt1q9F3+u+u0axvv2xGswcdk71idaKCDJVkiZWWLcKgIlXXUbr/fqG3dM7A16pEtvzzjJm/jxAkm3hhM3XCYOvXPkbPWbw6iOVgtZEVLzwUWBTTSOClg9EHur1irH4J5tvRPa+RQXE3AnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244264; c=relaxed/simple;
	bh=ANhgdjZ9QWvbPKNhBY/3jGzDxKbCitudG6qu1y6y/y0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZxJtTPzYHRRcP7tI9krV3kE+HU/fb3nuPISapc+5d3P9qfTqKGAe8V49vlCO2Py+XLYOx5E/HK+GyObpCW66WxCIEFnxcNfy1l3yvFY/QW5T+H3MvKpEJSb4b+FZUd0zkGIWWxYfcoLVvYmHq8mhmRyrWALtiERcoXOVwnfcihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iOHF4yX9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fuJ7iMHt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAJviA8SZMA7iGIbookAxjENNfF9GaWY1TECqi54lAg=;
	b=iOHF4yX9iweQUHGACX7l05b5n3mvd/lhc0UU98Cvgo0De8ZR4nGBfrHed9qT2prdngzGOh
	M7khG9FbJO/1gLZJOzi6zmp9D7CKmkciLS0bguMk/hgD7WaJKWv0kOC6sTKBl642PxUpS4
	pyTSkPVWv3ufUQebaIdc6UUWPAM4vNMPp4UMonnln8mj78qzP1eSOztQALrHzhOUwik23K
	jKenIlbZZ6ZN+99CnSSs4+LftmlXrcoWivH02ZGJimnSkV72WTIhhaP2vKDGJCEC+9kX3S
	FOABAHIFeiBmta7BzicerclyGJmL0W04m08dFgAJao+ys/yGFJspaf2IDd6lOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAJviA8SZMA7iGIbookAxjENNfF9GaWY1TECqi54lAg=;
	b=fuJ7iMHtGgiMCvz3GzmWSKLjkq94f21duhH7OR5U9i1hVIh9eYsbY2KQekk2BOBFjTJJBu
	vnN6COdMqv+teGAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Remove the ksig argument from
 rseq_handle_notify_resume()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <176224425951.2601451.4929092559525843429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     41b43a6ba3848be8ceec77b8b2a56ddeca6167ed
Gitweb:        https://git.kernel.org/tip/41b43a6ba3848be8ceec77b8b2a56ddeca6=
167ed
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:30:01 +01:00

rseq: Remove the ksig argument from rseq_handle_notify_resume()

There is no point for this being visible in the resume_to_user_mode()
handling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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


Return-Path: <linux-tip-commits+bounces-7080-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EEBC19C0E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C25474EA9C8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E69347BB6;
	Wed, 29 Oct 2025 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xxoDhWHH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WtEVy7cd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327F2345753;
	Wed, 29 Oct 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733444; cv=none; b=o+i0kzSpg5i59OeDueROyQuk0we/ov4F2/1OACqP3DhX47DL28+JpUjJA+mKa9fxJEuKYg6Cd+n0ina21RpBDzh84iHNTQduFMvfR3ocpC6ckxcCrvT+sPmuq9g051PXpZdbCFd8BxAtEdIzuxXChVxbSPh7xZzALNMCFJwSOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733444; c=relaxed/simple;
	bh=ZUCh6RG8BEAIJUYwIvX4bTSVyyBbYcBrMXcnnafpfeA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b/V8Fm3xFRaGd7KPoV8Yxf8hCigWfjQWR9i31pa5ZHnJRLStsRUFNFSU/bvZDMTeau3qhU57WFX8Otqq3X5nSvAYU5wKJwoXOixAUeBK+jCw6v74GmzRm3Y4Fhk/1c0pPc7zIjnu3XFgLvG0UC1S56oPFlMG7Py+WeUHDw+5V/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xxoDhWHH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WtEVy7cd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8l5CMZTgbFpjP+N39/2E88BJhCF1EmbDnTbJeTrHOQ=;
	b=xxoDhWHHdQZb4G8IqfUunMdPgDg0KP9reNZtCMpQryuyDVTy3f5gFH5D9RjmI55pftq1kN
	GatcoPd7j43sTT+qIHWlys1mOGdb9O9nnHuEFZophmjQz1L13B5xzrVJIRDJ+eVni3GVgw
	zDxNNr18bTcFfmUxY/GNchyzupAHFs7bgn7Z+8ELB+uw9UiGPdBHVt7Iw47KSBhDf61YN5
	+V47DLWHIKhh+GLsOQBZu0p9VnMbQotKOJEt0kklLGN5G6vHWV1vv7qaVyQqdgh76UnQw/
	rFBYuJ7YYubxGbZcSQrIkaG0JBowYkCqnvG2AyWD2BN8b0+rnqEzVa4jV11ukg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8l5CMZTgbFpjP+N39/2E88BJhCF1EmbDnTbJeTrHOQ=;
	b=WtEVy7cd1Cyt4TIUVOExR00sq3eE73FX3/9mqFoj7rzj5lqJiVn1FJFLcZqX03aH5TEnp3
	Hiy6xvYXoTjxUJBA==
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
Message-ID: <176173343931.2601451.5057970472600914752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     dfd205204dd4c459d5911fd1cfb17f86cae80150
Gitweb:        https://git.kernel.org/tip/dfd205204dd4c459d5911fd1cfb17f86cae=
80150
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:12 +01:00

rseq: Remove the ksig argument from rseq_handle_notify_resume()

There is no point for this being visible in the resume_to_user_mode()
handling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.211520245@linutronix.de
---
 include/linux/resume_user_mode.h |  2 +-
 include/linux/rseq.h             | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

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
index 21f875a..c06a8e5 100644
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


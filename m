Return-Path: <linux-tip-commits+bounces-7194-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE101C2C8AD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCEC74F2A9C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0831A561;
	Mon,  3 Nov 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k8AhBikD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YExtsHEr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B431961F;
	Mon,  3 Nov 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181268; cv=none; b=B/a45Mb2q/WZUAG5WKBwbqg+nra+JX5hMAaufJikQY0rUQ63qHUXT0Xs3+94xKNP66dMe7M6ygqwCrElJn70mkfv0dNDyDkKGmu0H1kQK8tH3vFRWiXfQbh3jjsQJsMT2BC741/H9DRf9LYXY3yjo71KUvHHUp9GjgLk5PAz9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181268; c=relaxed/simple;
	bh=E2Fs9WzZbxNLSF4OzvMI1yUfbkSpqZ0EAt+KXIJyGBw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jK8r7H9ML8Furv6nosFt2t7th/CJhKqtS3W/OeiyxdyqkdD0Fzf5D+YzxSOVqkzB56Gq7FP2yUimYOC75OQn9KPDJdBIWy7u3DzQGNSpGK1OUy9conyQ9fPv1ER3mdLvcD2woJdi/DtZ1btJPDK3RGqt08jutITNI8PU49RL8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k8AhBikD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YExtsHEr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64oMkT6/lduUamuf4ju5G2WsFatpNUYxC09wQvnwbwY=;
	b=k8AhBikDLModIlNP9vvKhLROZzFLOi3R7iuj2U2P0xLrC1Gx2+7fyoq60HkMPANR5xfLAP
	csBRzon5wsHofaYIytqnFQinKUdYbBqVuWypQjnVRLy5QFRhWRMcY4TjoMruos2D/y0qam
	9IlHjRLE3aRj914OkQjcEg+mbPKjrOTNREiArnPuHP2jgn/AVoWKjGB9hrO4jKNuTv8+wJ
	2+ugrCZvCZ4ETeF6POko+gaVTIViWC+8vGa0Fb/IyHRm4djveQrWEfwu/Ar9GZBENk6CmA
	HQWHjHy0WhYgrmPF5J5/5Dyr6rR9H1iQys7b0jCDqxGUCl0fDAxNSj9bXFFTXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64oMkT6/lduUamuf4ju5G2WsFatpNUYxC09wQvnwbwY=;
	b=YExtsHEr0XJulji/rcNpJz0Zx6OZx4a9BrEKpQXTt+1o1xk6jDSaRf2IAD0Xo9yXEE9uAm
	lZ1FqsAzHlTd+fAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/rseq] entry: Inline irqentry_enter/exit_from/to_user_mode()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.715309918@linutronix.de>
References: <20251027084306.715309918@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218126384.2601451.15836613108825397702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     0df6b9bcdd0f3536b4bb7b2dc828e75f07fcface
Gitweb:        https://git.kernel.org/tip/0df6b9bcdd0f3536b4bb7b2dc828e75f07f=
cface
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:16 +01:00

entry: Inline irqentry_enter/exit_from/to_user_mode()

There is no point to have this as a function which just inlines
enter_from_user_mode(). The function call overhead is larger than the
function itself.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.715309918@linutronix.de
---
 include/linux/irq-entry-common.h | 13 +++++++++++--
 kernel/entry/common.c            | 13 -------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index 9b1f386..83c9d84 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -278,7 +278,10 @@ static __always_inline void exit_to_user_mode(void)
  *
  * The function establishes state (lockdep, RCU (context tracking), tracing)
  */
-void irqentry_enter_from_user_mode(struct pt_regs *regs);
+static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *re=
gs)
+{
+	enter_from_user_mode(regs);
+}
=20
 /**
  * irqentry_exit_to_user_mode - Interrupt exit work
@@ -293,7 +296,13 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
  * Interrupt exit is not invoking #1 which is the syscall specific one time
  * work.
  */
-void irqentry_exit_to_user_mode(struct pt_regs *regs);
+static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	exit_to_user_mode_prepare(regs);
+	instrumentation_end();
+	exit_to_user_mode();
+}
=20
 #ifndef irqentry_state
 /**
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index f62e1d1..70a16db 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -62,19 +62,6 @@ __always_inline unsigned long exit_to_user_mode_loop(struc=
t pt_regs *regs,
 	return ti_work;
 }
=20
-noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
-{
-	enter_from_user_mode(regs);
-}
-
-noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
-	instrumentation_end();
-	exit_to_user_mode();
-}
-
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 {
 	irqentry_state_t ret =3D {


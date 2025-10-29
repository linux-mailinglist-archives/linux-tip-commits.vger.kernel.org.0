Return-Path: <linux-tip-commits+bounces-7072-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9590AC19C38
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822F656480E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCD63375A4;
	Wed, 29 Oct 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4xKgBP1V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y5mPh50B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59754330B30;
	Wed, 29 Oct 2025 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733436; cv=none; b=jbKV6m21fbIlATEDhtUTmgGm9qdeLqpWbAPgvFaoq9Zkr6slLeXSuTaHBzf0X3DOn0ny+5ztqzOaLu3nqlZHVPQNeildsnw8v2gjuz8+WWAP8p9d4qOv9udUVTIuVzwUX/dn8SQg8pGq6nCp2AukcXonqQQJEBr+u/SuNNoBCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733436; c=relaxed/simple;
	bh=KH3rYBsxXf78Xd37aTwV08DoLK5SVh89lf/YTaCFhCQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gWSHqH7jqFWz/AqpRYbtOjz6rp4a7wvL8VdfRJO8ZqlQ/5halStJsghLcoKc7wsy+ghzVg7nGmP6wI4TAtfZAirqnMmPiS2voeBvzK8FPQrCYRLC18Kv10b7aeVga3RmMVQKuTDrbRNm4tcyOIWysJn/oKJPmczXoYhfDtlf9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4xKgBP1V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y5mPh50B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qC1cxvmnXYnwahrZSQzeVhMFQReLB65AWDROFMpvBEI=;
	b=4xKgBP1VEBwccxgXg9Cn6mD6UWpMw6rDsQNp6lnnaXimrHL7p/31rs6IYXbJuCZVtZtLr2
	9tLrsy0EiE9CA1VvVRkfrV6mk+UKfTkzTCJ/OqNuNleDsqGquN0ygZ1z2WFOyKrE3m5Lph
	1iyYbV0gI1IQm4aIsXQCE1VC6DMcTN+XXdaY1Kw4cqMop3YZDvNeE1bkq5vXsYsfSwdjCG
	TYnOc4O28GhyaUo19TrVL0DjsMxJt69ZRuKKOgq/kg2cjLjmu0QjMhqL/rCxpfGItenfFC
	Px8xVy/pQm5kgZXIz1666QoFSoEmdx/lSOC7EHhT8IPjA/7h0vItaSvZkc0BZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733431;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qC1cxvmnXYnwahrZSQzeVhMFQReLB65AWDROFMpvBEI=;
	b=y5mPh50B8Vx3tuFHKeipHke5TzFyfFlW0dDa3d2avXqRjBF74ATM7gVo/uDsD5mfd7/vT6
	6oiHJvc2z2IknvAw==
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
Message-ID: <176173343009.2601451.13107534170776790002.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     6a2d376e6e9bb4ac79ba1e72beaca5a74669aff6
Gitweb:        https://git.kernel.org/tip/6a2d376e6e9bb4ac79ba1e72beaca5a7466=
9aff6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:14 +01:00

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


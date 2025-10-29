Return-Path: <linux-tip-commits+bounces-7048-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 968D2C196FD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6C73566576
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A403328E6;
	Wed, 29 Oct 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bWo8Ue2t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PncW+wv6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BEB331A6C;
	Wed, 29 Oct 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730587; cv=none; b=rn9rCZFT2lsYkwbxjqEHGBIWj2/EnYzddlMh83ZzLMa6HVVtyjXFy8szeT8ocrSiQcQAFJOROlyCgMzjC7h7Ddm0mC3zwnNs2ufD0/0JHo9GMS7v9BTojOz9AOj9VVOELI46TBw9GkGAQgMCKCSfGfsc1e/fH2RGJNxUkFkFKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730587; c=relaxed/simple;
	bh=XhVem88l478GdRxb7j+8SnerV71a+Z1AfRDII0Oe7WE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pTpTwBFUQfBds8VNWERiQmqe3IDbmE8vJ7zEeCGndxritLf5bIpeoAeiqqptXSA2XppPccWAcUlnfYNpDEhjRUKbrldbCBDdYrLJlE4j+qy94N+CTzHdGHrJu9WmK47RFru61v++Q7FXM2LqOV7FXRQ1FlxqywgwcWAVneneT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bWo8Ue2t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PncW+wv6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UShH0mMuheIUNEhW0k0dnWffzVymluk/q0OptiNNYQ=;
	b=bWo8Ue2t7pPVqTpn+Ajf43lTZB0LT4jsdK6Y6Jw9rlVJO+L9wMKRBYTtCNrSew073DW4+W
	sf2uRyaMpB+tp7mBUVK/RXD2xcyzhrt2CqOF4UxA36kxWQI6hzQ7/Pt8wo4UPAwSWENuWa
	WCX23S/OE0Rfk6tvaQK1sOYodAbpd+Ym3Kdc7cwdVU+PaGuTAFrI2VaGDWeRCnD3hrdkvK
	b/c5aFiDBKUU/iTTz90kX5biHcgLzsuI/PxfOlNAwRI3+X3DnMxpEU1wUiREqDX8rTnrQ7
	GmNShs4FpqoRUz/jkza7ff9jKYs6eig5GQ7z/WO2YTMk5uqU4t7SgOBJLBBihQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UShH0mMuheIUNEhW0k0dnWffzVymluk/q0OptiNNYQ=;
	b=PncW+wv6p1m8Eo+VrJH2/HDE4iDh1OlQm5U3yKnUrsGNYr6/WsCFOYlNaTbixm09DiK+lD
	r13TOnnQaWyimMCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] task_work: Fix NMI race condition
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924080118.425949403@infradead.org>
References: <20250924080118.425949403@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173058280.2601451.12953853135833297927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ef1ea98c8fffe227e5319215d84a53fa2a4bcebc
Gitweb:        https://git.kernel.org/tip/ef1ea98c8fffe227e5319215d84a53fa2a4=
bcebc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Sep 2025 15:47:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:54 +01:00

task_work: Fix NMI race condition

  __schedule()
  // disable irqs
      <NMI>
	  task_work_add(current, work, TWA_NMI_CURRENT);
      </NMI>
  // current =3D next;
  // enable irqs
      <IRQ>
	  task_work_set_notify_irq()
	  test_and_set_tsk_thread_flag(current,
                                       TIF_NOTIFY_RESUME); // wrong task!
      </IRQ>
  // original task skips task work on its next return to user (or exit!)

Fixes: 466e4d801cd4 ("task_work: Add TWA_NMI_CURRENT as an additional notify =
mode.")
Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://patch.msgid.link/20250924080118.425949403@infradead.org
---
 kernel/task_work.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/task_work.c b/kernel/task_work.c
index d1efec5..0f7519f 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -9,7 +9,12 @@ static struct callback_head work_exited; /* all we need is -=
>next =3D=3D NULL */
 #ifdef CONFIG_IRQ_WORK
 static void task_work_set_notify_irq(struct irq_work *entry)
 {
-	test_and_set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+	/*
+	 * no-op IPI
+	 *
+	 * TWA_NMI_CURRENT will already have set the TIF flag, all
+	 * this interrupt does it tickle the return-to-user path.
+	 */
 }
 static DEFINE_PER_CPU(struct irq_work, irq_work_NMI_resume) =3D
 	IRQ_WORK_INIT_HARD(task_work_set_notify_irq);
@@ -86,6 +91,7 @@ int task_work_add(struct task_struct *task, struct callback=
_head *work,
 		break;
 #ifdef CONFIG_IRQ_WORK
 	case TWA_NMI_CURRENT:
+		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
 		irq_work_queue(this_cpu_ptr(&irq_work_NMI_resume));
 		break;
 #endif


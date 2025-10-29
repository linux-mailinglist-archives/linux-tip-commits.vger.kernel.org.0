Return-Path: <linux-tip-commits+bounces-7078-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7C7C19C02
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DA6056310B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0A1307ACB;
	Wed, 29 Oct 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/KBIrfB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VqtWKx79"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0839341AAF;
	Wed, 29 Oct 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733442; cv=none; b=lKsw4ZsapQ7wjFPF793kCcY2D/JCdLODK3oKYwL8QqwWFSMIMdVEeV2RBs9+DhGSL9WIdDqD1PiLeZjVAf0WH7Ldt704kZEAkSN5suht5PZ3J8PpZSvL+Zb8s0PDnDtlxhb+WJg2LBLQobQiqSlv/VeP8HnrS/8IZXi3RYuk+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733442; c=relaxed/simple;
	bh=KOqG5x+hq5z9fyOiI9YyHFN4tIOfkfXdgh7Z5dMHLkg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uosTfjZUnLIbyVOedghxzl9m7wGsNymItHcafycDqW+lxjlT59TnjdWN5/C0KoL2Ahgts7ecZSA7GNIcth43ATSk5EBGQeWh27WuYg4KLBSXBNYBS7MI83L/G0wYzpPnpp+8nls/QR6bm2H/hatlrKcmZujPZR/7OE0mSXeaPhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/KBIrfB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VqtWKx79; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzlsO+eAEXtEBtMXzRiVJiUIzVGVsXSqFO7z62Jk7Yg=;
	b=Y/KBIrfBIhDZW/VgpeFil9V4bpkuXilE83Z5vwQRmvf8FFzkzKOtwdF7mbaaEQyrXb9Jpx
	GvBgpEnThLY2nOPzFbgOlw6xeVNp5ebo9vl2+GxT7IncblNkUkhFhszxVcQ/eaJQYWtZ3J
	+FuHdypN75tQOgLEJTzKD1/fRamRgC6GqoLAqCx/X8HpVANyXNzvH7w8A//2kXeVb5h/eW
	Tvt5V97r2n6bsLdMh8ZPb3szP1g/vVI0REWSQX8RoDe3AYH5CAeRj4TVYcyQmmdCGoXmvL
	yQ9ClmgwpIbTsSvwsGKSnLo7HWR2uOaMZIH4r3JyQlRYv1ruP4KTVE9V/6bhxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzlsO+eAEXtEBtMXzRiVJiUIzVGVsXSqFO7z62Jk7Yg=;
	b=VqtWKx79hXOtbrc6AziRtQCp/YcHoeCK3XNOieDo7B3bsDESP1uaJwdncLDsnriCQb0G4p
	XXKZ043d3n0TsCDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Simplify registration
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.274661227@linutronix.de>
References: <20251027084306.274661227@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173343815.2601451.9368028900741069432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     bd88944825d9579d1240dcc55b5f57635298a121
Gitweb:        https://git.kernel.org/tip/bd88944825d9579d1240dcc55b5f5763529=
8a121
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:12 +01:00

rseq: Simplify registration

There is no point to read the critical section element in the newly
registered user space RSEQ struct first in order to clear it.

Just clear it and be done with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.274661227@linutronix.de
---
 kernel/rseq.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 51fafc4..80af48a 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -492,11 +492,9 @@ void rseq_syscall(struct pt_regs *regs)
 /*
  * sys_rseq - setup restartable sequences for caller thread.
  */
-SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
-		int, flags, u32, sig)
+SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags,=
 u32, sig)
 {
 	int ret;
-	u64 rseq_cs;
=20
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -557,11 +555,9 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, r=
seq_len,
 	 * avoid a potential segfault on return to user-space. The proper thing
 	 * to do would have been to fail the registration but this would break
 	 * older libcs that reuse the rseq area for new threads without
-	 * clearing the fields.
+	 * clearing the fields. Don't bother reading it, just reset it.
 	 */
-	if (rseq_get_rseq_cs_ptr_val(rseq, &rseq_cs))
-	        return -EFAULT;
-	if (rseq_cs && clear_rseq_cs(rseq))
+	if (put_user(0UL, &rseq->rseq_cs))
 		return -EFAULT;
=20
 #ifdef CONFIG_DEBUG_RSEQ


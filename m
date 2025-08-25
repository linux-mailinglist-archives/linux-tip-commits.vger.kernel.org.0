Return-Path: <linux-tip-commits+bounces-6370-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC0B33CCC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8289020572D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A262EC54B;
	Mon, 25 Aug 2025 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iNmdFuBD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w29xoO+F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5232EB5D1;
	Mon, 25 Aug 2025 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117511; cv=none; b=FPQqeplkKQZWg7gxFT9N6upApKgEv/7F7yYvWgnQbN2aX7q7odKfUlDXdIBEe2C4ab4udQVgE/+8ISVCgNPRjGhXJVBOjYM0sFAE1jIRQhbEwVkZPZjv65udBITkhYIcEbi40Ste8qQNwTCESaAR3dnMEYMqIT4eSoA2BbDJaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117511; c=relaxed/simple;
	bh=vkXa63lKleECxQKJ7RiuLYkbwITZboFB5n05etg+YAg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=svVoy/i0puTWo7qlgYbLUMTASbhOPWrrxmKt4ixyhctWwiqfBjaImjnoUlDqE0sK752yb+S3yCnhNxuCKc0A84TLt9Lm18z/mwBdpxBylzO0dhJzrwhkBoEHSBeF5N/Mlq8hz7pxNhCxg7B58czJfrSSSzc5NdeZ+DqqMbjBjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iNmdFuBD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w29xoO+F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:25:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t90XrF9hT6kbxk7o0FTqbifumSkGy5IPbnODiUcgT00=;
	b=iNmdFuBDHCHIBBC+Qy+jLT+RD4rn53ulvja3BD96sP4LxSV3C7t0uDtdcuQEmbwMyYmk75
	gAB9Z+4QJke83jD2ZJnyFrrKzAFfSalJNP341btIWSUNF7Hzh7NNxIGebhwcdz5sWVofmh
	nXz3XRQfWsEespCoklH6VTzUtI8srCfHrBPweWyTxma83+o1mHXgkfOy19wshN2YbQPiRd
	hNO+eesK0FgmKszv7wxk38TY9i8mXykP+JvI0IfMD1mv46mftIdyPTPGNLgVhhoojzv0Cs
	qS02qN/tCazXOSSyU68K8imGBt9a0eHiVQwKEEG35FP6d+G2hsVitjYMmHVT2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t90XrF9hT6kbxk7o0FTqbifumSkGy5IPbnODiUcgT00=;
	b=w29xoO+FP37jZis4l3TKNniO4ZXrDKauk9566sof9ySQszfEpQxR/s1KBnyAR3SS4iQJUf
	C/umZ1/MCPxa4dCA==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Make copy_from_page global
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-4-jolsa@kernel.org>
References: <20250720112133.244369-4-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611750635.1420.14044879004228451699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     82afdd05a16a424409682e06a53d6afcda038d30
Gitweb:        https://git.kernel.org/tip/82afdd05a16a424409682e06a53d6afcda0=
38d30
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:18 +02:00

uprobes: Make copy_from_page global

Making copy_from_page global and adding uprobe prefix.
Adding the uprobe prefix to copy_to_page as well for symmetry.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250720112133.244369-4-jolsa@kernel.org
---
 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 01112f2..7447e15 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -226,6 +226,7 @@ extern void arch_uprobe_copy_ixol(struct page *page, unsi=
gned long vaddr,
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
+extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, vo=
id *dst, int len);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index dd4dd15..f993a34 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -177,7 +177,7 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
 	return is_swbp_insn(insn);
 }
=20
-static void copy_from_page(struct page *page, unsigned long vaddr, void *dst=
, int len)
+void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst=
, int len)
 {
 	void *kaddr =3D kmap_atomic(page);
 	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
@@ -205,7 +205,7 @@ static int verify_opcode(struct page *page, unsigned long=
 vaddr, uprobe_opcode_t
 	 * is a trap variant; uprobes always wins over any other (gdb)
 	 * breakpoint.
 	 */
-	copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
 	is_swbp =3D is_swbp_insn(&old_opcode);
=20
 	if (is_swbp_insn(new_opcode)) {
@@ -1051,7 +1051,7 @@ static int __copy_insn(struct address_space *mapping, s=
truct file *filp,
 	if (IS_ERR(page))
 		return PTR_ERR(page);
=20
-	copy_from_page(page, offset, insn, nbytes);
+	uprobe_copy_from_page(page, offset, insn, nbytes);
 	put_page(page);
=20
 	return 0;
@@ -1397,7 +1397,7 @@ struct uprobe *uprobe_register(struct inode *inode,
 		return ERR_PTR(-EINVAL);
=20
 	/*
-	 * This ensures that copy_from_page(), copy_to_page() and
+	 * This ensures that uprobe_copy_from_page(), copy_to_page() and
 	 * __update_ref_ctr() can't cross page boundary.
 	 */
 	if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
@@ -2393,7 +2393,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsign=
ed long vaddr)
 	if (result < 0)
 		return result;
=20
-	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	uprobe_copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 	put_page(page);
  out:
 	/* This needs to return true for any variant of the trap insn */


Return-Path: <linux-tip-commits+bounces-3638-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DADA45C3B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E3A3AA205
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 10:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B426E63E;
	Wed, 26 Feb 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ieY3ClEQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="esxsCJgC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A926BDAF;
	Wed, 26 Feb 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567264; cv=none; b=ZZajziY66m3hH6T2IWi/UQ9sYw7C2kYVAY4hqMEmeQwc0o+MD5l8SM9EC/KH7RsOknCqEMZZTRzeS5riucGcxr0dAYVrPoyC+hZs95ViArsjfhmZDnonMM5Y3ho7SHLfD1RRw1T1MmOGVvjfSy/ZdTK+HBNAok1M7x2RwKejFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567264; c=relaxed/simple;
	bh=PpNoweM8dLdcj5dngpmWgSjuCz/0NU0LOEebq7eT69A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DQklRCpoy4w9oczYitE+mHn3zK3NgWM0lVbUNzfRX0Xxzx3kM0gECUlDY0ph6J6LxY5kHMowetfLLusCeAnz3mclcNHWmKN1U11vKGWgGN9NR/6uYqP2k+9UbZbEXn9xg4YuEdmZLCuHRLlpCfDO2HZvt2o7b0Z1l2F3CeMfZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ieY3ClEQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=esxsCJgC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 10:54:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567261;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwXUhvL8SZGG0noemZBs4/nhnu5gVDsQqcuU1ecAXBI=;
	b=ieY3ClEQVEWLVRuV60wXtkBhfNeEfZkbN8LrEe/zEHtL0usAtSB7i7wHB4ke3wIv4zFdaS
	xy0cPpM9XJN+pKGE7QZaAl1xpcxlm8rYNiaummQcwgmYrrBq9u4r/7sa7jQWbwvIi/qEmJ
	bjXnTLkQMGseZn7VV4jban/xzw7Bu9OunUP5Rl7B4zWSCurIsSsoitE1Jdzl/pn05DqiS0
	G9wEG4NHqfeSQDKmsruuoPRRxoPrDSB7HwYuqwqA2IGGzXMG/Hwo9TEkQXlvwctrf6njkV
	WoKe+1qCzXk6SXWvAt3YeoD/TxbINRF4mwjsAFwcXc39Bx4GZCFAIGH5aBMgFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567261;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BwXUhvL8SZGG0noemZBs4/nhnu5gVDsQqcuU1ecAXBI=;
	b=esxsCJgCF4LvB7tRxHq8/4IhePCoqANT0/ybmOtM0ZC/2wj4anMlx4sCf+kqmZwhI7MbWZ
	93z4LQMP5e8newCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Decode LOCK Jcc.d8 #UD
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.486463917@infradead.org>
References: <20250224124200.486463917@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056726072.10177.7047992228525592205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e874854d308841f2383ee3d04f0438f56ddddaaf
Gitweb:        https://git.kernel.org/tip/e874854d308841f2383ee3d04f0438f56ddddaaf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Feb 2025 11:41:55 +01:00

x86/traps: Decode LOCK Jcc.d8 #UD

Because overlapping code sequences are all the rage.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.486463917@infradead.org
---
 arch/x86/include/asm/bug.h |  2 ++
 arch/x86/kernel/traps.c    | 26 +++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index bc8a2ca..f0e9acf 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -17,6 +17,7 @@
  * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
  */
 #define INSN_ASOP		0x67
+#define INSN_LOCK		0xf0
 #define OPCODE_ESCAPE		0x0f
 #define SECOND_BYTE_OPCODE_UD1	0xb9
 #define SECOND_BYTE_OPCODE_UD2	0x0b
@@ -26,6 +27,7 @@
 #define BUG_UD1			0xfffd
 #define BUG_UD1_UBSAN		0xfffc
 #define BUG_EA			0xffea
+#define BUG_LOCK		0xfff0
 
 #ifdef CONFIG_GENERIC_BUG
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c169f3b..f4263cb 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -97,6 +97,7 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
  * If it's a UD1, further decode to determine its use:
  *
  * FineIBT:      ea                      (bad)
+ * FineIBT:      f0 75 f9                lock jne . - 6
  * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
  * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
  * static_call:  0f b9 cc                ud1    %esp,%ecx
@@ -106,6 +107,7 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
 __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 {
 	unsigned long start = addr;
+	bool lock = false;
 	u8 v;
 
 	if (addr < TASK_SIZE_MAX)
@@ -114,12 +116,29 @@ __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 	v = *(u8 *)(addr++);
 	if (v == INSN_ASOP)
 		v = *(u8 *)(addr++);
-	if (v == 0xea) {
+
+	if (v == INSN_LOCK) {
+		lock = true;
+		v = *(u8 *)(addr++);
+	}
+
+	switch (v) {
+	case 0x70 ... 0x7f: /* Jcc.d8 */
+		addr += 1; /* d8 */
+		*len = addr - start;
+		WARN_ON_ONCE(!lock);
+		return BUG_LOCK;
+
+	case 0xea:
 		*len = addr - start;
 		return BUG_EA;
-	}
-	if (v != OPCODE_ESCAPE)
+
+	case OPCODE_ESCAPE:
+		break;
+
+	default:
 		return BUG_NONE;
+	}
 
 	v = *(u8 *)(addr++);
 	if (v == SECOND_BYTE_OPCODE_UD2) {
@@ -322,6 +341,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 		fallthrough;
 
 	case BUG_EA:
+	case BUG_LOCK:
 		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
 			handled = true;
 			break;


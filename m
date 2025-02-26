Return-Path: <linux-tip-commits+bounces-3662-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B941AA45E57
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E833B6B04
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8810222575;
	Wed, 26 Feb 2025 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BkAB35Dh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tYHQW0v9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E02222C5;
	Wed, 26 Feb 2025 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571489; cv=none; b=gswJcHnMH5PqcRxmrV66mg6ew7C0ILKzXOWRkm723csCNl1K+Cn4aG7Jrhe+YSo+NxISgKk2jiylCcwruBgBwr9nfzYJ1nixf3f3yOxqS0QjfwTpzFZVQ+Gb+I008Ut73QFLfz7ouFEvJJqRmh9vtscEqpGyKxgNkePsyUAmiQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571489; c=relaxed/simple;
	bh=MTPni9emjG1JZjmM+0M3G2+32wEMIkHBf17OK+vzbUA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vsq9qkFXcbQJKKA4gvCT72ThZHwTr70bxIaX5KqhwpjdTSv5Uh+9osmaLeApaOydxvQ65emHocn6zsK0pRkOIgpt7M8GNPthyelYrNtt6KwxvseMQbwv5xUF2H21GFzLz+9uSmuvN113V9GGXieFotp7Hqw5i2q8ANCrEAqZHTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BkAB35Dh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tYHQW0v9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:04:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740571486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOAQXBawSgkq5LoEVvP8p3CLUKdfv5izFR7CdKn9UjA=;
	b=BkAB35DhVg1l8iVCzYmQuFEgjWa04sd6W+SucP03k0qBjWrgGSY7RVt0lvTpBWPzVDcTML
	loOJ/X0GP+Nejo7Eh2JR4XN9wG6rD3qpu354ZFDaf2krV8DSkMhQoaDpQiONuSrG8YMquX
	xtvS0nxpNlwPivq08EtBoXioSRpJEU8bRpVMhg6iHuT8rVrjUWtCUbGx4LggIaajWgI3oD
	HAxxDHVqxeJTacmxjwXs+6UsQBKS5FWV4DK8ONGQSBfFXrem1RBiUOrGm8Ta+dCH3AnDTD
	nzaIY4mm+LTwBtIdR8VNF+yBpf8O+pnhhAyGvrngEX5cRLfCFA83RzWA38maYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740571486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOAQXBawSgkq5LoEVvP8p3CLUKdfv5izFR7CdKn9UjA=;
	b=tYHQW0v9VeXSNct6SRt+TDuJXZ+1IF62Ye4PpAdDNlgWozBCy7guZV8xOlhLfqcrL+SYBN
	2Jg4d/VzdJSf0TCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Decode LOCK Jcc.d8 as #UD
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.486463917@infradead.org>
References: <20250224124200.486463917@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057148573.10177.3509877009426388684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     029f718fedd72872f7475604fe71b2a841108834
Gitweb:        https://git.kernel.org/tip/029f718fedd72872f7475604fe71b2a841108834
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 12:24:17 +01:00

x86/traps: Decode LOCK Jcc.d8 as #UD

Because overlapping code sequences are all the rage.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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


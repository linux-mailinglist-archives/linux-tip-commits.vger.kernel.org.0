Return-Path: <linux-tip-commits+bounces-4609-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD94A77624
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 10:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EE91888124
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3811DC9B0;
	Tue,  1 Apr 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WkROTV9K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eYKSIEQf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244619D8AC;
	Tue,  1 Apr 2025 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743495436; cv=none; b=s2ADnPIg5z65B9KBG6LVjTXUyEdH0LLhCFSDggo77yEoUakSGT705biJisVs78t4996thloojc5krV7D5z6t5g1CzUp6H8y4H0T9IX9sJ54mT4asM4GG66rNJ52plRxLuLKnxKKOcpoumb9BZhnVELlfcjt6L6VStu1rQ4elq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743495436; c=relaxed/simple;
	bh=T5GbqVyZWC7IL24uFzvj8hAEL+GTO0rSO2sLy2qsudg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eQwh0dnbPaCjf9f5qvL2Vtd4ix0N9hTC2sb/oeix3xutAy+8C0mHvQuPjhwRJMpP6li7TnbzFSa/H/8U7WAtg6a7z00zh4dylCa3NrfxhOLS6GzTD4etgSN1QnRknW0IY3Xo+dicpKFsdojV8fGf0jLmTStxl2knJ7BHAoeJxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WkROTV9K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eYKSIEQf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 08:17:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743495433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nz0PxVBRVLI4HeLZodBOM+7xTdYHJPIkiH8CFNMIFZM=;
	b=WkROTV9K1NVOJR5cOe0tqJgp115MTOYC/lleDlhtwVHRi5eUddDaW0CHeVwtCqlSwXbyrz
	Aioaq8nVqOPaTuOn7QWhIOS4dckWnrcvKaAQX8EDFkb28Pp2NXEL7d4XprIq8Lyz0FVnwr
	hBIZ33RBHCFsu2g/xad18Q8fOsKwurtj70A/PX6nhJjX0ta1MTpGFQmCusAN96HVZv1tLp
	bHE8iqC8WLsv0cq1CBOnaMKxO26kgGIwYHbHb8TAQX6vvyeg7vC/S6W+LWKNcmzUYmiKJg
	NBS3TG6oeY6fviuf4wbD3OhTSnAUvBBTwbNDDvYYiNX8ziPeF96iquhkBZhXsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743495433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nz0PxVBRVLI4HeLZodBOM+7xTdYHJPIkiH8CFNMIFZM=;
	b=eYKSIEQfz4gJcB0bs9PiJIRVCxVWzPm2tv2qdTyFcL8izw2T7QAYR/VFK26BhivwYBxQZZ
	RWMLeYXroepzvcDA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool/loongarch: Add unwind hints in
 prepare_frametrace()
Cc: kernel test robot <lkp@intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <270cadd8040dda74db2307f23497bb68e65db98d.1743481539.git.jpoimboe@kernel.org>
References:
 <270cadd8040dda74db2307f23497bb68e65db98d.1743481539.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174349542583.14745.6124193536449922861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     7c977393b8277ed319e92e4b598b26598c9d30c0
Gitweb:        https://git.kernel.org/tip/7c977393b8277ed319e92e4b598b26598c9d30c0
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 31 Mar 2025 21:26:43 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 10:10:10 +02:00

objtool/loongarch: Add unwind hints in prepare_frametrace()

If 'regs' points to a local stack variable, prepare_frametrace() stores
all registers to the stack.  This confuses objtool as it expects them to
be restored from the stack later.

The stores don't affect stack tracing, so use unwind hints to hide them
from objtool.

Fixes the following warnings:

  arch/loongarch/kernel/traps.o: warning: objtool: show_stack+0xe0: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-160
  arch/loongarch/kernel/traps.o: warning: objtool: show_stack+0xe0: stack state mismatch: reg1[23]=-1+0 reg2[23]=-2-152

Fixes: cb8a2ef0848c ("LoongArch: Add ORC stack unwinder support")
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/270cadd8040dda74db2307f23497bb68e65db98d.1743481539.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503280703.OARM8SrY-lkp@intel.com/
---
 arch/loongarch/include/asm/stacktrace.h   |  3 +++
 arch/loongarch/include/asm/unwind_hints.h | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/include/asm/stacktrace.h
index f23adb1..fc8b647 100644
--- a/arch/loongarch/include/asm/stacktrace.h
+++ b/arch/loongarch/include/asm/stacktrace.h
@@ -8,6 +8,7 @@
 #include <asm/asm.h>
 #include <asm/ptrace.h>
 #include <asm/loongarch.h>
+#include <asm/unwind_hints.h>
 #include <linux/stringify.h>
 
 enum stack_type {
@@ -43,6 +44,7 @@ int get_stack_info(unsigned long stack, struct task_struct *task, struct stack_i
 static __always_inline void prepare_frametrace(struct pt_regs *regs)
 {
 	__asm__ __volatile__(
+		UNWIND_HINT_SAVE
 		/* Save $ra */
 		STORE_ONE_REG(1)
 		/* Use $ra to save PC */
@@ -80,6 +82,7 @@ static __always_inline void prepare_frametrace(struct pt_regs *regs)
 		STORE_ONE_REG(29)
 		STORE_ONE_REG(30)
 		STORE_ONE_REG(31)
+		UNWIND_HINT_RESTORE
 		: "=m" (regs->csr_era)
 		: "r" (regs->regs)
 		: "memory");
diff --git a/arch/loongarch/include/asm/unwind_hints.h b/arch/loongarch/include/asm/unwind_hints.h
index a01086a..2c68bc7 100644
--- a/arch/loongarch/include/asm/unwind_hints.h
+++ b/arch/loongarch/include/asm/unwind_hints.h
@@ -23,6 +23,14 @@
 	UNWIND_HINT sp_reg=ORC_REG_SP type=UNWIND_HINT_TYPE_CALL
 .endm
 
-#endif /* __ASSEMBLY__ */
+#else /* !__ASSEMBLY__ */
+
+#define UNWIND_HINT_SAVE \
+	UNWIND_HINT(UNWIND_HINT_TYPE_SAVE, 0, 0, 0)
+
+#define UNWIND_HINT_RESTORE \
+	UNWIND_HINT(UNWIND_HINT_TYPE_RESTORE, 0, 0, 0)
+
+#endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_LOONGARCH_UNWIND_HINTS_H */


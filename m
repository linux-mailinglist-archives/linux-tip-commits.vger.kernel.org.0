Return-Path: <linux-tip-commits+bounces-4333-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50149A68A96
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D85171D3B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D2254AF5;
	Wed, 19 Mar 2025 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kWrpLe0j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OrKc7Ujm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E4254870;
	Wed, 19 Mar 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382210; cv=none; b=BUB+JtDpOWyN0atsZgvAqbdt8AvUSFTRHOJpXqCGs6MRLZUEpm7ES52RZCQNXmLIb17FC0oABYK21TQmYO/zjbvKPefYqdWcTDfeAJUs4p8TyPeh3O9Z0R3BgW1F+gTDtJyfcD1ChmnrWsKYgdjNmPh/CkRsKnmGVer5qty1POY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382210; c=relaxed/simple;
	bh=Gg/Jt7x541DQ3z4gEEX4+0C5SJJeIn5BGSN7rJ+5rPE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S5dY/Ig8tKkXk3QFyYAdvVkiaqx7DCn17ChFkViabtFSipBKUVajMcIrj/AJF7SzQAuiwnpUBzphU56rfYRR0a4/MrXjC3CiN+yqZuMjHRIM+ybH35WM6hsFgzhNETkoC2nw1NNk60nooU0T8TIWhiHEa1Y0AW1kw+Evo4cVgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kWrpLe0j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OrKc7Ujm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyO+C5kRtSW04JooA+XEjtvBM55apMPTQDbe7ZRyCS0=;
	b=kWrpLe0jnmPhzh+F9bvkHFMf9yYg8I/+8BsgAgnh6tRNoYmOlmBQ7ugOzycenmLvpEi3w+
	N8PTmGRSzYq2F1GAcqfHcqPsftF1pUfZhCyi0vLdZYRErPURkT76KufqeXW3RMCgamflLI
	8cBTQxzcaEEAy0+jJkDo+owcIggjMHiDGv34efbc2+iKmndkKw55UXVzWuFoBFUmNItNDb
	sRPb2IFbi9vfw7EO3SaR1AUf0Ujackkns7ss+h+pXE8VAdTUAT9lqm08WruoDraDNALlwn
	autgXvnq7oS1ID0E/TLJMMHXOqyrnyvkKNAf4jo6LH+StKgu7AiGh6D/i0kvlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YyO+C5kRtSW04JooA+XEjtvBM55apMPTQDbe7ZRyCS0=;
	b=OrKc7Ujm++Nv2zHfcHYAwhudDorOSgrRuxI9Ir72eL7zpO0juM41U6L3JtaQLsNp0z/lHh
	4KCoCLAC1r/5o0BA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/asm: Use CLFLUSHOPT and CLWB mnemonics in
 <asm/special_insns.h>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313102715.333142-1-ubizjak@gmail.com>
References: <20250313102715.333142-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238220692.14745.17959838732333963549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     53286632450835c49b5c177f97e4899645f15730
Gitweb:        https://git.kernel.org/tip/53286632450835c49b5c177f97e4899645f15730
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 13 Mar 2025 11:26:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:26:58 +01:00

x86/asm: Use CLFLUSHOPT and CLWB mnemonics in <asm/special_insns.h>

Current minimum required version of binutils is 2.25,
which supports CLFLUSHOPT and CLWB instruction mnemonics.

Replace the byte-wise specification of CLFLUSHOPT and
CLWB with these proper mnemonics.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250313102715.333142-1-ubizjak@gmail.com
---
 arch/x86/include/asm/special_insns.h | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 21ce480..9b10bd1 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -176,9 +176,8 @@ static __always_inline void clflush(volatile void *__p)
 
 static inline void clflushopt(volatile void *__p)
 {
-	alternative_io(".byte 0x3e; clflush %0",
-		       ".byte 0x66; clflush %0",
-		       X86_FEATURE_CLFLUSHOPT,
+	alternative_io("ds clflush %0",
+		       "clflushopt %0", X86_FEATURE_CLFLUSHOPT,
 		       "+m" (*(volatile char __force *)__p));
 }
 
@@ -187,13 +186,10 @@ static inline void clwb(volatile void *__p)
 	volatile struct { char x[64]; } *p = __p;
 
 	asm volatile(ALTERNATIVE_2(
-		".byte 0x3e; clflush (%[pax])",
-		".byte 0x66; clflush (%[pax])", /* clflushopt (%%rax) */
-		X86_FEATURE_CLFLUSHOPT,
-		".byte 0x66, 0x0f, 0xae, 0x30",  /* clwb (%%rax) */
-		X86_FEATURE_CLWB)
-		: [p] "+m" (*p)
-		: [pax] "a" (p));
+		"ds clflush %0",
+		"clflushopt %0", X86_FEATURE_CLFLUSHOPT,
+		"clwb %0", X86_FEATURE_CLWB)
+		: "+m" (*p));
 }
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK


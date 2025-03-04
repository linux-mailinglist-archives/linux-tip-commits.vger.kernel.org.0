Return-Path: <linux-tip-commits+bounces-3843-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141B9A4D643
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3D51894061
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 08:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC7C1FBC89;
	Tue,  4 Mar 2025 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SqyRqXkC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IMSsfE/P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F81F940A;
	Tue,  4 Mar 2025 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076869; cv=none; b=nrhYjp9dTKhLZyTq/Cq7FSWk1ovle3J9zB5gbBqD/0zUd4ZvzrzWSQFFko2/2IOuZvtp8znEgiuQ8KOJfAlR3AAKVwC8EXUIl2Il4jvxwHPP5qJkf3jwYTR/9+NTKxt6aDA0m/uVk6zOh7qrEBIt5G7gxFlSiXgIExGnW2dk9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076869; c=relaxed/simple;
	bh=drHyst/nPYYsNLUbpwA1Tmqwh+lO4Vv+KCfAluJFnKw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oq1CJ/dJIx+NAYA/JdsJ2OpORgGhL6sMkTkjOdZ9xzqhGXmbA0GTiLycDNTGdBOkcQKJ98L5QQi2iBTrxxfccVhordr6G1xV7QD16LnQ0kUdLE7o9ALoCBFPTRLZIiQX1Zt1n++DoWW4on5M3zRcxvOzt03SRN/OiIDowqqR9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SqyRqXkC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IMSsfE/P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:27:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741076865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6ieIhtv7bFx+0JGFNWIw6iKTTVbcLVbb/L92MJjB9o=;
	b=SqyRqXkC28qfLko7Djmkbr10U69ffqsMZPTUWnroV75Vu2jsg5F8sK2pCUQXiS1T7ASUjC
	Vw6BolTPgP/fJurQKCdWNhXzRq1TyMq4iatfxg0+1/xCFbEXME3SfOvleROnO8RX4ZMMha
	iHkw8hLst1O7pANlMZo5qKPCn+4XZ90Kle2281as0tAK4zNiHnvXpfAa6eMPs+TAAf0Dq2
	j30yl7xtDIVw5U5m+JwNtOsLeYTmQhZf6+Flg60p/zUEvSKeWbxqvyJeEXOa926YSI0Z0g
	FzIBdSQfrGJI80soTIo7DL8lRdYKMSogE34Ir5DzIPGfttrCWhE0dEsG24JBTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741076865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6ieIhtv7bFx+0JGFNWIw6iKTTVbcLVbb/L92MJjB9o=;
	b=IMSsfE/P8oSIOSM0vqYoPpER1zl5vxVdB7YHVKiQMIB73E7QC9RLxo4YVISLtB891jnms3
	qzTpL0R8wGik6fDg==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/stackprotector: Move __stack_chk_guard to percpu
 hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-11-brgerst@gmail.com>
References: <20250303165246.2175811-11-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107686495.14745.13008967273841312300.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0d3cd124b77ab546ba4284587fb6a72322a89daf
Gitweb:        https://git.kernel.org/tip/0d3cd124b77ab546ba4284587fb6a72322a89daf
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:45 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 21:37:41 +01:00

x86/stackprotector: Move __stack_chk_guard to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-11-brgerst@gmail.com
---
 arch/x86/include/asm/stackprotector.h | 2 +-
 arch/x86/kernel/cpu/common.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index d43fb58..cd761b1 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -20,7 +20,7 @@
 
 #include <linux/sched.h>
 
-DECLARE_PER_CPU(unsigned long, __stack_chk_guard);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 
 /*
  * Initialize the stackprotector canary value.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 39782a2..a1c0efc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2130,7 +2130,7 @@ void syscall_init(void)
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_STACKPROTECTOR
-DEFINE_PER_CPU(unsigned long, __stack_chk_guard);
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, __stack_chk_guard);
 #ifndef CONFIG_SMP
 EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 #endif


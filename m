Return-Path: <linux-tip-commits+bounces-4925-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C235A87334
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0274E16ECBE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36061EE02F;
	Sun, 13 Apr 2025 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ew2akoqp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZhjrIbJn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE8847B;
	Sun, 13 Apr 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570571; cv=none; b=ZR49ZWKfm1JcaWkfbkKPMnbNlmRdQ2E8NDiQSLU2MOpoypqf5j9G66ioK4ydazwWLUYIVaAvw2c6kObe6dlIKNOx1v4FHF6+dIaYumERmyltDrK2RS67m1QLaEe1/IoN0hHfVwXiWi9033HRz9daoIyw+Yt9ycCUlrEberPO9Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570571; c=relaxed/simple;
	bh=G4aenEcQaLbNhj97ILYKHoURcrEI8+1ueDqIf5g4Yr0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=b/kwy4Aw+l4LY1VHNgnuV2x4T7XOR5JqBpdo0MTgO3neeIhkEzrHNyOMH9vZSTqnQDyVUAZV9ASdrw45RI4cLNHo9j3mbnFILDtiPJtAvpK1Qqv2G0ENoFUqrYU/8M/yY3h/jeUQY1lBtmb81C8zZ7oWQWQ91N2wW/lbd/aiGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ew2akoqp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZhjrIbJn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ja6cczd5nR/F49JgzCuNCL82ipUsrJZ0md/xZqmTTEE=;
	b=ew2akoqpbaVyfdG9tPi4DOCQOVZgv9n/lrRy3u94fdtFR3UipVBhHU/6wUHaxMaGEChOuc
	Q9AtaHngaWBGrv69SCQil0NBh16GtiXO6vPRZbJJSFSEmUO9ioFlVO6yU5dBjnSB/8fJFb
	D/KbBVemdedX5RvNbzpVJZVjXBNqP/oo/TP/Et1KFotApcp8NsCj6YBdiD1RMQPSyVbIy1
	I3bXwTrzjVwEjmUKgC8QSPHPM4VsBvK6r9sGFwCice3kT+x0mI3TQ0ID/iHjsN14FyI8eN
	NMH0d91qXtt4d+bSswX9IF4iblOSl6tpbOkqqCEb7SFGM/vSR4exqgGopK0IFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570567;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ja6cczd5nR/F49JgzCuNCL82ipUsrJZ0md/xZqmTTEE=;
	b=ZhjrIbJnK7aZmKtwZsADvlU5O+JzMBGT53FS7izvfdLfFAdDy1B0pFhhD9qiApA+sP4o93
	YxMcpnm98hAQhJDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/msr] x86/msr: Add compatibility wrappers for rdmsrl()/wrmsrl()
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, Dave Hansen <dave.hansen@intel.com>,
 Xin Li <xin@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457056267.31282.9550644254346313322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     a5447e92e169dafaf02fd653500105c7186d7128
Gitweb:        https://git.kernel.org/tip/a5447e92e169dafaf02fd653500105c7186d7128
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 13 Apr 2025 20:43:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 13 Apr 2025 20:50:38 +02:00

x86/msr: Add compatibility wrappers for rdmsrl()/wrmsrl()

To reduce the impact of the API renames in -next, add compatibility
wrappers for the two most popular MSR access APIs: rdmsrl() and wrmsrl().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/msr.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 20deb58..2ccc78e 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -396,5 +396,10 @@ static inline int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 	return wrmsr_safe_regs(regs);
 }
 #endif  /* CONFIG_SMP */
+
+/* Compatibility wrappers: */
+#define rdmsrl(msr, val) rdmsrq(msr, val)
+#define wrmsrl(msr, val) wrmsrq(msr, val)
+
 #endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_MSR_H */


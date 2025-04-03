Return-Path: <linux-tip-commits+bounces-4651-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA964A7A566
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 16:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AC6165D11
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480C524EA96;
	Thu,  3 Apr 2025 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V0RWSGDF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qz8WtDZK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF62E3386;
	Thu,  3 Apr 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691064; cv=none; b=QzK+1VLRUgiqJ0in7Yh1lab9U1WOztOqzQD4N2Yp1bofkurZMi6d3zRVfaCwf/NY2p5QCv6Hcp/hZNaA/+wCNJiqWgIj6ASJVVZEio1PE7RNIfUqKpUUEkYutPrAQQFyZPua2KfcgLryCjcBnPZsPT/62paOstCUMalX0Lr+kzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691064; c=relaxed/simple;
	bh=5fX/888S1gFD/JlM4lX3pgKNr7kh3kTzxsJIlceexLo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bgJD9SkZ4pU+ESP0BZrgjqA5CZ+2G1aifqG0TPo1AOn/5XTv8dGfa2sXVGqOnNbXGjfDczWcJOkONFOrZtYSriWHgAYAnDF7v7hLlL0U3XqLvpgpdwmjOAUFFvk4cGNccW8Kbw/Wxlo5YIiR0sS9rDgdhqB1kcSZ7xO0vqXBAgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V0RWSGDF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qz8WtDZK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 14:37:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743691060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJeXxVtTiBmq+wIFSuA1D6F7MGhoLP9p1B+aLoiNQTg=;
	b=V0RWSGDFuq+NhW8/JkN0Ggk9hN0gNVOHuDCUcaRMjM8/hq62nhaWvHX0qUCTMVh1+eol+k
	qR0jQgZXx0PK7s0/6lPzsnV7rnXU4Be3y7fkd0SidqXIz22vk/fsln3XPo6fpnQxGXznXO
	2h/4HXTUox9hKYeR9XKuqDJGdo2BO67HXtDYGU+LYhgpThMV7C1gelYmoatEd1tL1Jw8tR
	gPEgxZi2rwi5FB3i6gNOBTZSdWWcQrYYPafrcNi9bZHraNzxyBTW8x9WpTOxwkHN90brLq
	mlrBf9W48zL1HzYTiYk1M9AMYODFuKqoA4TpqcfRrxVSDvlOorqLkudrbcjs1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743691060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJeXxVtTiBmq+wIFSuA1D6F7MGhoLP9p1B+aLoiNQTg=;
	b=qz8WtDZK26QudMnBE/PAl7cLkoW6EQPZkc73iCX6mms/pC/iGaObTZEbK6sFdMQzZqB22f
	jDdWT6Zu4EoqzDBA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/idle: Use MONITOR and MWAIT mnemonics in <asm/mwait.h>
Cc: kernel test robot <lkp@intel.com>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250403125111.429805-1-ubizjak@gmail.com>
References: <20250403125111.429805-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174369105677.31282.6911743949151587283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     fc1cd60042b3df1d162278461c7a87f0362502b8
Gitweb:        https://git.kernel.org/tip/fc1cd60042b3df1d162278461c7a87f0362502b8
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 03 Apr 2025 14:50:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Apr 2025 16:28:38 +02:00

x86/idle: Use MONITOR and MWAIT mnemonics in <asm/mwait.h>

Current minimum required version of binutils is 2.25,
which supports MONITOR and MWAIT instruction mnemonics.

Replace the byte-wise specification of MONITOR and
MWAIT with these proper mnemonics.

No functional change intended.

Note: LLVM assembler is not able to assemble correct forms of MONITOR
and MWAIT instructions with explicit operands and reports:

  error: invalid operand for instruction
          monitor %rax,%ecx,%edx
                       ^~~~
  # https://lore.kernel.org/oe-kbuild-all/202504030802.2lEVBSpN-lkp@intel.com/

Use instruction mnemonics with implicit operands to
work around this issue.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250403125111.429805-1-ubizjak@gmail.com
---
 arch/x86/include/asm/mwait.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 44d3bb2..dd2b129 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -27,9 +27,11 @@
 
 static __always_inline void __monitor(const void *eax, u32 ecx, u32 edx)
 {
-	/* "monitor %eax, %ecx, %edx;" */
-	asm volatile(".byte 0x0f, 0x01, 0xc8;"
-		     :: "a" (eax), "c" (ecx), "d"(edx));
+	/*
+	 * Use the instruction mnemonic with implicit operands, as the LLVM
+	 * assembler fails to assemble the mnemonic with explicit operands:
+	 */
+	asm volatile("monitor" :: "a" (eax), "c" (ecx), "d" (edx));
 }
 
 static __always_inline void __monitorx(const void *eax, u32 ecx, u32 edx)
@@ -43,9 +45,11 @@ static __always_inline void __mwait(u32 eax, u32 ecx)
 {
 	mds_idle_clear_cpu_buffers();
 
-	/* "mwait %eax, %ecx;" */
-	asm volatile(".byte 0x0f, 0x01, 0xc9;"
-		     :: "a" (eax), "c" (ecx));
+	/*
+	 * Use the instruction mnemonic with implicit operands, as the LLVM
+	 * assembler fails to assemble the mnemonic with explicit operands:
+	 */
+	asm volatile("mwait" :: "a" (eax), "c" (ecx));
 }
 
 /*
@@ -95,9 +99,8 @@ static __always_inline void __mwaitx(u32 eax, u32 ebx, u32 ecx)
 static __always_inline void __sti_mwait(u32 eax, u32 ecx)
 {
 	mds_idle_clear_cpu_buffers();
-	/* "mwait %eax, %ecx;" */
-	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
-		     :: "a" (eax), "c" (ecx));
+
+	asm volatile("sti; mwait" :: "a" (eax), "c" (ecx));
 }
 
 /*


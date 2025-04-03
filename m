Return-Path: <linux-tip-commits+bounces-4649-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10240A7A469
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306B116996C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAC529408;
	Thu,  3 Apr 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TYZnvs7d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BatiqPzR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259524DFF6;
	Thu,  3 Apr 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688602; cv=none; b=cE6qfKnFFts7MabNgNvF53yBYRKN/ZixqmUaK0Q8ZUQI25wt1Mg+GVyhKBPQtctydXER8VK5QK1sz5LJJ50PBNDTViUD3HJMOCadehIbO70TzUh6UF4n2KVoMi7a7pCBHt6108Dy9wfRKrZsPGvCbx/QQC1aGmsAS2vdcPaZG74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688602; c=relaxed/simple;
	bh=suss+3KdxNtwu7lv5hZut4gmYE4qbfjUSZJJMIK0QII=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aE13YDP+DPpMSnQKPE4x5zXlU7MfWWJ27+bOj8kQVyF6bb0khUqrVBgvhNh5Ex16KS8onQpvfLclXj33qYWvZFR2W1h7xzvkLN/gPh9s3jIGLQ2Fb7vB8iShdQ2JdFygxNnqvTnSO6NVKFxVUKkspREHniPOLISzRDOujwXX/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TYZnvs7d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BatiqPzR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:56:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743688599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ycr9ur7Hw0si9YtJh0DzdUVV52Tx48gowXs9ced/4E8=;
	b=TYZnvs7dvXG9uh4hTcV6J0HwgjlDcWCIUOJEWuMdt7rf1LT8KvQJoQpmzGNwRadF2FlF6S
	bWVYtM6cVCnBpjGKTx1vqXl38T+jcywMM2xToG92sJCpSKbZC6I5fA4dzUq79yGGkXayXx
	CVNNQ/fHr2DhwMPY4y2fiHUhdODuLMtEc7i2opa/8ORMkIoNGWe1eLd3wBykfyVcn0mcnS
	4EbF+GIWiV9s8DAMHtgnBPovQ8c6r43SXMLWf4lhcaQwpbZLgB+WZB1HOWsJ1fYM4HqpaH
	QPVAmDyboeefXNY20JXhDlURd4UnzEOEPGjmcTQOBo9KqPZLOB0sLnK02JPLLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743688599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ycr9ur7Hw0si9YtJh0DzdUVV52Tx48gowXs9ced/4E8=;
	b=BatiqPzRAq58I9nfXgS4vPUKVyH+F79VPdE/xHr9ku1aFblF+LFxI6aI7Gst+bjwxYUm5t
	Lxy9zyZ0n4P0ViBg==
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
Message-ID: <174368859629.31282.7883834096892979215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     defea9e60d3f440ca8da070a478f668fec0ba659
Gitweb:        https://git.kernel.org/tip/defea9e60d3f440ca8da070a478f668fec0ba659
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 03 Apr 2025 14:50:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Apr 2025 15:27:50 +02:00

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
 arch/x86/include/asm/mwait.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 6a2ec20..26b68ee 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -27,9 +27,9 @@
 
 static __always_inline void __monitor(const void *eax, u32 ecx, u32 edx)
 {
-	/* "monitor %eax, %ecx, %edx;" */
-	asm volatile(".byte 0x0f, 0x01, 0xc8;"
-		     :: "a" (eax), "c" (ecx), "d"(edx));
+	/* Use the instruction mnemonic with implicit operands, as the LLVM
+	   assembler fails to assemble the mnemonic with explicit operands. */
+	asm volatile("monitor" :: "a" (eax), "c" (ecx), "d" (edx));
 }
 
 static __always_inline void __monitorx(const void *eax, u32 ecx, u32 edx)
@@ -43,9 +43,9 @@ static __always_inline void __mwait(u32 eax, u32 ecx)
 {
 	mds_idle_clear_cpu_buffers();
 
-	/* "mwait %eax, %ecx;" */
-	asm volatile(".byte 0x0f, 0x01, 0xc9;"
-		     :: "a" (eax), "c" (ecx));
+	/* Use the instruction mnemonic with implicit operands, as the LLVM
+	   assembler fails to assemble the mnemonic with explicit operands. */
+	asm volatile("mwait" :: "a" (eax), "c" (ecx));
 }
 
 /*
@@ -95,9 +95,8 @@ static __always_inline void __mwaitx(u32 eax, u32 ebx, u32 ecx)
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


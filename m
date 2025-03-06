Return-Path: <linux-tip-commits+bounces-4036-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F0A558DB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 22:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EC23AD87E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98FC1F63F0;
	Thu,  6 Mar 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hp+iYqzP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQKPu7FB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CA7272930;
	Thu,  6 Mar 2025 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296827; cv=none; b=TFMzK2raEWtJ+Wzp9fV8f2MlcSk8KdCVlU2SyBGVRcb3dHfKc3Lf9DZ1l8/hSvRc2obWS69PQlKj6a/o2m5iQITwvvM68T9KK4IIFTGtBDDwm/9MJ+bLxRmyxMdMjkp/fBytJDGWaw7ngZOrNbg73GwZDlFX0rd8paq8n32VlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296827; c=relaxed/simple;
	bh=DiCVkRi8eOxfDTbQlgJmcqpBP+VOm5MTu7mlHUCyhYc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bDVoONb2Xs2IHbi04Qzh+vbEcXUVCWG5BrpsUG5ccSPgC8xNgzRpqLGwB9GMuY1xIiXadeO8V39a2elBFS3fVJMLRiK3/IZr7k96us8rOxlQUMDj5VeY2G7ptVb4LIPPa7qk+laHLYfQ5B+SFrhhX1VglYr33QFYEYymBRd/UeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hp+iYqzP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQKPu7FB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 21:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741296824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lmgoj7dNRI17qsZ1C2345KjtGQbGK15vU+CAU4AjVvY=;
	b=hp+iYqzPgZIAFWBiIpHYzIUqmg7cODmlIFQ5ReYv1vwkDTgCDXfmaW6Fb1+LV72I6f0+yq
	7KEgwZjepy6RvDrS1RXYKFlD/wQGE1A++fCt8vPCJ7fhbVbxReAvZ0lTz3V6IUYys38Fcy
	tZn7jnhhDFhw0Ldr9YZrDPUYiIeECOlkw5CHaS/hlroxoOhjP0mHiTh5VmefjXZNfM/aKF
	tmoAA4x2LZjiqHNOOBXQr1oEl7xuQD1qpuBjTZCV+Nu6871ffKWrl0EMWVXHJL9L1mbB4r
	gfdNtDSiOLXVh62NWAoBOgqBRUyBddgbEGt3xMEQiOYtt3nhettA9sydn9CoiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741296824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lmgoj7dNRI17qsZ1C2345KjtGQbGK15vU+CAU4AjVvY=;
	b=sQKPu7FBIgbHAFBfC9SE3+h4I1adCBxUwPsY6NWXTZd7el+QlvApNUZ6nDoi1wcGbxYqbe
	HeTndrrqA2o+C+Cg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/kexec: Merge x86_32 and x86_64 code using macros
 from <asm/asm.h>
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250306145227.55819-1-ubizjak@gmail.com>
References: <20250306145227.55819-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174129682336.14745.3287112422322924162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     aa3942d4d12ef57f031faa2772fe410c24191e36
Gitweb:        https://git.kernel.org/tip/aa3942d4d12ef57f031faa2772fe410c24191e36
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 06 Mar 2025 15:52:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 22:04:48 +01:00

x86/kexec: Merge x86_32 and x86_64 code using macros from <asm/asm.h>

Merge common x86_32 and x86_64 code in crash_setup_regs()
using macros from <asm/asm.h>.

The compiled object files before and after the patch are unchanged.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250306145227.55819-1-ubizjak@gmail.com
---
 arch/x86/include/asm/kexec.h | 58 +++++++++++++++--------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 8ad1874..e3589d6 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 
+#include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
 
@@ -71,41 +72,32 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	if (oldregs) {
 		memcpy(newregs, oldregs, sizeof(*newregs));
 	} else {
+		asm volatile("mov %%" _ASM_BX ",%0" : "=m"(newregs->bx));
+		asm volatile("mov %%" _ASM_CX ",%0" : "=m"(newregs->cx));
+		asm volatile("mov %%" _ASM_DX ",%0" : "=m"(newregs->dx));
+		asm volatile("mov %%" _ASM_SI ",%0" : "=m"(newregs->si));
+		asm volatile("mov %%" _ASM_DI ",%0" : "=m"(newregs->di));
+		asm volatile("mov %%" _ASM_BP ",%0" : "=m"(newregs->bp));
+		asm volatile("mov %%" _ASM_AX ",%0" : "=m"(newregs->ax));
+		asm volatile("mov %%" _ASM_SP ",%0" : "=m"(newregs->sp));
+#ifdef CONFIG_X86_64
+		asm volatile("mov %%r8,%0" : "=m"(newregs->r8));
+		asm volatile("mov %%r9,%0" : "=m"(newregs->r9));
+		asm volatile("mov %%r10,%0" : "=m"(newregs->r10));
+		asm volatile("mov %%r11,%0" : "=m"(newregs->r11));
+		asm volatile("mov %%r12,%0" : "=m"(newregs->r12));
+		asm volatile("mov %%r13,%0" : "=m"(newregs->r13));
+		asm volatile("mov %%r14,%0" : "=m"(newregs->r14));
+		asm volatile("mov %%r15,%0" : "=m"(newregs->r15));
+#endif
+		asm volatile("mov %%ss,%k0" : "=a"(newregs->ss));
+		asm volatile("mov %%cs,%k0" : "=a"(newregs->cs));
 #ifdef CONFIG_X86_32
-		asm volatile("movl %%ebx,%0" : "=m"(newregs->bx));
-		asm volatile("movl %%ecx,%0" : "=m"(newregs->cx));
-		asm volatile("movl %%edx,%0" : "=m"(newregs->dx));
-		asm volatile("movl %%esi,%0" : "=m"(newregs->si));
-		asm volatile("movl %%edi,%0" : "=m"(newregs->di));
-		asm volatile("movl %%ebp,%0" : "=m"(newregs->bp));
-		asm volatile("movl %%eax,%0" : "=m"(newregs->ax));
-		asm volatile("movl %%esp,%0" : "=m"(newregs->sp));
-		asm volatile("movl %%ss, %%eax;" :"=a"(newregs->ss));
-		asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
-		asm volatile("movl %%ds, %%eax;" :"=a"(newregs->ds));
-		asm volatile("movl %%es, %%eax;" :"=a"(newregs->es));
-		asm volatile("pushfl; popl %0" :"=m"(newregs->flags));
-#else
-		asm volatile("movq %%rbx,%0" : "=m"(newregs->bx));
-		asm volatile("movq %%rcx,%0" : "=m"(newregs->cx));
-		asm volatile("movq %%rdx,%0" : "=m"(newregs->dx));
-		asm volatile("movq %%rsi,%0" : "=m"(newregs->si));
-		asm volatile("movq %%rdi,%0" : "=m"(newregs->di));
-		asm volatile("movq %%rbp,%0" : "=m"(newregs->bp));
-		asm volatile("movq %%rax,%0" : "=m"(newregs->ax));
-		asm volatile("movq %%rsp,%0" : "=m"(newregs->sp));
-		asm volatile("movq %%r8,%0" : "=m"(newregs->r8));
-		asm volatile("movq %%r9,%0" : "=m"(newregs->r9));
-		asm volatile("movq %%r10,%0" : "=m"(newregs->r10));
-		asm volatile("movq %%r11,%0" : "=m"(newregs->r11));
-		asm volatile("movq %%r12,%0" : "=m"(newregs->r12));
-		asm volatile("movq %%r13,%0" : "=m"(newregs->r13));
-		asm volatile("movq %%r14,%0" : "=m"(newregs->r14));
-		asm volatile("movq %%r15,%0" : "=m"(newregs->r15));
-		asm volatile("movl %%ss, %%eax;" :"=a"(newregs->ss));
-		asm volatile("movl %%cs, %%eax;" :"=a"(newregs->cs));
-		asm volatile("pushfq; popq %0" :"=m"(newregs->flags));
+		asm volatile("mov %%ds,%k0" : "=a"(newregs->ds));
+		asm volatile("mov %%es,%k0" : "=a"(newregs->es));
 #endif
+		asm volatile("pushf\n\t"
+			     "pop %0" : "=m"(newregs->flags));
 		newregs->ip = _THIS_IP_;
 	}
 }


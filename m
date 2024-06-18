Return-Path: <linux-tip-commits+bounces-1460-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B450590D5B7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10955B2262E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D7B1A4F21;
	Tue, 18 Jun 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vw3tLHpJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F4Qyyukc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB51A38DD;
	Tue, 18 Jun 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719316; cv=none; b=ZNgFem/JjFujJzXWO4FX9rNeCT4WIg9ygP1sxCOidi7LMKJLOMWyYwQ26G43jHTIk0iuqA3eV07R9cj3mCLtApJbqbeG/WqruyMmCZe9Ai0gHLtcNNkYEqzMJYZ7cwOMt6oiVgzHLiwR5ReM9KAyJIjf4VBfCOKoEgSRhqKjwJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719316; c=relaxed/simple;
	bh=4RITwq3jPH+WS6JbaAu0AQc8yque7vL91F7u6+iHzfg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S50D03WHHC9WDHn8IZ7QGib2vRYEZab9Xn/cBulLgYN3nPnK8beNL8lOztv7llkP2cld8ravrYdDEHtOHT9tvEUsiEgm/+f58xMm791sTUL1Q37OsoBNzygNDyWYs/Y++YWlCm8DlQEYTo6PRveS10RzBXtfklbmVB3zG7Bbuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vw3tLHpJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F4Qyyukc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LrHv+LJ86wfWiQQT26EizEdhbveSa55rCKnbGFGXHc=;
	b=vw3tLHpJGvza1QkIteN8JM/hGcvWKLERXqxr7pBdZDskdP9zk7M+lCWs42hBGj5uFDziVw
	QrwVavoBUvIvPtggrTA+0FDp5Egy/Vv22kXRs6GUbHYrGycajd7HcLtCNT0T4AvWzYfa2H
	dVJjvitiaWhQC8QIx9UsiNEKVi22NupkdHFCmJQPppcFhr97iezhVPiii2crCYUE4AIwOd
	jPpL/pF8CvGgeynb43fGwT2RNvHvPiM3N5K0YquTQJyaETW6kwvAb1z/p4f+YZyKtnwCU/
	fFn3onlV1vDjIfH6/0Xxr1cE+v91pmhxpPvebYH8iJWfRiW+tlPnWZXXk8VtSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9LrHv+LJ86wfWiQQT26EizEdhbveSa55rCKnbGFGXHc=;
	b=F4QyyukcKwyxSka0q+RHzkaVurnKFf4lQ28lhNX5elapBO0J1Uq3sVaxUKMAnGRZfpA8y1
	QZo7HT1682DyrlDw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/kexec: Keep CR4.MCE set during kexec for TDX guest
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-7-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-7-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871930225.10875.13385118574589510822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     de60613173dfd75a10f6aa8e001bbcafa242e623
Gitweb:        https://git.kernel.org/tip/de60613173dfd75a10f6aa8e001bbcafa242e623
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:58:51 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:45:50 +02:00

x86/kexec: Keep CR4.MCE set during kexec for TDX guest

TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
that bit is cleared during CR4 register reprogramming during boot or kexec
flows, a #VE exception will be raised which the guest kernel cannot handle.

Therefore, make sure the CR4.MCE setting is preserved over kexec too and avoid
raising any #VEs.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240614095904.1345461-7-kirill.shutemov@linux.intel.com
---
 arch/x86/kernel/relocate_kernel_64.S | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 8b8922d..042c9a0 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,8 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/stringify.h>
+#include <asm/alternative.h>
 #include <asm/page_types.h>
 #include <asm/kexec.h>
 #include <asm/processor-flags.h>
@@ -145,14 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
 	 *  - 5-level paging, if it was enabled before
+	 *  - Machine check exception on TDX guest, if it was enabled before.
+	 *    Clearing MCE might not be allowed in TDX guests, depending on setup.
+	 *
+	 * Use R13 that contains the original CR4 value, read in relocate_kernel().
+	 * PAE is always set in the original CR4.
 	 */
-	movl	$X86_CR4_PAE, %eax
-	testq	$X86_CR4_LA57, %r13
-	jz	.Lno_la57
-	orl	$X86_CR4_LA57, %eax
-.Lno_la57:
-
-	movq	%rax, %cr4
+	andl	$(X86_CR4_PAE | X86_CR4_LA57), %r13d
+	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %r13d), X86_FEATURE_TDX_GUEST
+	movq	%r13, %cr4
 
 	/* Flush the TLB (needed?) */
 	movq	%r9, %cr3


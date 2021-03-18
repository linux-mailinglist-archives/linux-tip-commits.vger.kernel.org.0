Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52321341036
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 23:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhCRWK4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhCRWKX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 18:10:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE00C06174A;
        Thu, 18 Mar 2021 15:10:22 -0700 (PDT)
Date:   Thu, 18 Mar 2021 22:10:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616105418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jgNtZWeGwueLERTsKATVIBy9Nm3AcaKIkHK06mcZO7I=;
        b=lhYF8D43BdxDAf+WBMMCRNjkM6m8G1ww9CM0BRDpFTR290P6Mm9vT8bZvjAEd6JuVVk2Id
        HC4Jhj4S50sQtP9itBa5uXAo1W/vlll+CNHi+1vciNN6Iq/c6VCoR75EsOJRY5KDPuyZIm
        uADGOVMssx7C2xzqWDsbxe+i8GBsuGiOZkgGGvR2AFvVKNZbMyjwCXrHu0UJeQIthIsgni
        Fk/sQMz9CIdH9G/J7p4X+eNSptb99KVmx8MaUmJ2hXQYbUFiY3E63Ju1D9+yiZLhykMy2l
        V8f3ZonY3Mg5fxwkuGZdlYWqcCQuQ5yuFO8ZL6+54kQ6HG3IRCTN63rpO8uPLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616105418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jgNtZWeGwueLERTsKATVIBy9Nm3AcaKIkHK06mcZO7I=;
        b=FNazLY2/zxs2Q6tiT/CSPguVn9JsNdWAkou/EdxMBPPsobnkydiYnh6FSF9vTgPg3/2fx0
        BmsiFesmiv2Ks+Dw==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Add CPUID sanity check to
 32-bit boot-path
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210312123824.306-7-joro@8bytes.org>
References: <20210312123824.306-7-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <161610541745.398.5004496051877898127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     e927e62d8e370ebfc0d702fec22bc752249ebcef
Gitweb:        https://git.kernel.org/tip/e927e62d8e370ebfc0d702fec22bc752249ebcef
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Fri, 12 Mar 2021 13:38:22 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 23:04:12 +01:00

x86/boot/compressed/64: Add CPUID sanity check to 32-bit boot-path

The 32-bit #VC handler has no GHCB and can only handle CPUID exit codes.
It is needed by the early boot code to handle #VC exceptions raised in
verify_cpu() and to get the position of the C-bit.

But the CPUID information comes from the hypervisor which is untrusted
and might return results which trick the guest into the no-SEV boot path
with no C-bit set in the page-tables. All data written to memory would
then be unencrypted and could leak sensitive data to the hypervisor.

Add sanity checks to the 32-bit boot #VC handler to make sure the
hypervisor does not pretend that SEV is not enabled.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210312123824.306-7-joro@8bytes.org
---
 arch/x86/boot/compressed/mem_encrypt.S | 28 +++++++++++++++++++++++++-
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index ebc4a29..c1e81a8 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -139,6 +139,26 @@ SYM_CODE_START(startup32_vc_handler)
 	jnz	.Lfail
 	movl	%edx, 0(%esp)		# Store result
 
+	/*
+	 * Sanity check CPUID results from the Hypervisor. See comment in
+	 * do_vc_no_ghcb() for more details on why this is necessary.
+	 */
+
+	/* Fail if SEV leaf not available in CPUID[0x80000000].EAX */
+	cmpl    $0x80000000, %ebx
+	jne     .Lcheck_sev
+	cmpl    $0x8000001f, 12(%esp)
+	jb      .Lfail
+	jmp     .Ldone
+
+.Lcheck_sev:
+	/* Fail if SEV bit not set in CPUID[0x8000001f].EAX[1] */
+	cmpl    $0x8000001f, %ebx
+	jne     .Ldone
+	btl     $1, 12(%esp)
+	jnc     .Lfail
+
+.Ldone:
 	popl	%edx
 	popl	%ecx
 	popl	%ebx
@@ -152,6 +172,14 @@ SYM_CODE_START(startup32_vc_handler)
 
 	iret
 .Lfail:
+	/* Send terminate request to Hypervisor */
+	movl    $0x100, %eax
+	xorl    %edx, %edx
+	movl    $MSR_AMD64_SEV_ES_GHCB, %ecx
+	wrmsr
+	rep; vmmcall
+
+	/* If request fails, go to hlt loop */
 	hlt
 	jmp .Lfail
 SYM_CODE_END(startup32_vc_handler)

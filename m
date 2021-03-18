Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA1B340E55
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 20:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhCRTet (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 15:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhCRTeg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 15:34:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E35C06174A;
        Thu, 18 Mar 2021 12:34:35 -0700 (PDT)
Date:   Thu, 18 Mar 2021 19:34:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616096074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awafObqMmu9TEgjWJRx63fNsn5EVs9IjSpBzGKXfSk4=;
        b=ED50zyFMjhZqBobhciS2h6ZdUEoL9k5vTi8SbO5gF012uA5t30L1vT324s6+0gLEx6ICSw
        852P5r2+RDkngg/blRXCCNDGuYfumls1YUm+q6gMoPnxqsw7MPFZfKtjFDJ2JPbK+G54/G
        8ePJP9J6uG2XU7gp2Lo6mt9Igtgh1Q4PnjrfvCQpt1HNzxrFk75Qg5BcvqDT1AObfLPZzW
        Xv4EwEnlwsCZCzPB2pjHW7OP3RdpuBLoWuWGZGhEM2ilSRcs+NJwTwM5M4NV1bIYLdvBci
        +qF7vY+7QvvQ4TBBCQVCLJZ9kabSvJf48Byt1kUNGddqcmGqcEOy9SH1oO9f3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616096074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=awafObqMmu9TEgjWJRx63fNsn5EVs9IjSpBzGKXfSk4=;
        b=JbTS7kWOI+TFL2rWiOVVNXYXEmPmMOWBGbn4/5YLPJ7vOEtMuZURX4JA2RA6mK14N3JTLs
        C5m80PVW5AEJRJBg==
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
Message-ID: <161609607385.398.11055784824810862658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     0dd986f3a1e31bd827d2f1f52f07c8a82cd83143
Gitweb:        https://git.kernel.org/tip/0dd986f3a1e31bd827d2f1f52f07c8a82cd83143
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Fri, 12 Mar 2021 13:38:22 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 16:44:52 +01:00

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

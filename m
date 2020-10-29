Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A96A29F4BC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 20:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgJ2TSb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 15:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgJ2TRo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 15:17:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CFFC0613CF;
        Thu, 29 Oct 2020 12:17:44 -0700 (PDT)
Date:   Thu, 29 Oct 2020 19:17:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603999063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7+dGBqc2f5XoJ4SOWY6qsm+q+4HuAyLb5Pp0X1TMoM=;
        b=IGFvAgHE4DOkxvXmUQz/lSNYe8PAlWmBlWNwYvdrgxZTKxYAlyXV098Df5VSNIOIgXNuwZ
        hUpO93h3X2lMB0mStHdJJjb4QfJBYy8KAXvt6TqMWox+G8RclNe7aBve/ZXXAd6hSSPUsv
        UzYHv5WLcWWuq9mFvXzEcTKkVEWuPpXXWz8dxoBEZKaqOIuwUlHDNIpvls+8u2bEDR8PXh
        wDWHZoexgIi1AMsrpux/B9ugp/WJHcinKj2WKoJ49NvTTmz/+hrum8aNykrcfLv/WxFcFF
        iZrrk3QEZaUNAnVLPy0TK/GtwyTCOdFaYOKnfSFM6g8kIHlW5AwN2+e2NXJp+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603999063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7+dGBqc2f5XoJ4SOWY6qsm+q+4HuAyLb5Pp0X1TMoM=;
        b=3O//TZeM1OiO4AKIX024mIS03kOlDzBmLxSNU/H5MD4CHWOKs8nCMOdBh+CcTFqgzHy1HC
        32goRrYs+7QhzVDQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Introduce sev_status
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201028164659.27002-2-joro@8bytes.org>
References: <20201028164659.27002-2-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <160399906249.397.15926591077255529069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     3ad84246a4097010f3ae3d6944120c0be00e9e7a
Gitweb:        https://git.kernel.org/tip/3ad84246a4097010f3ae3d6944120c0be00e9e7a
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 28 Oct 2020 17:46:55 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 29 Oct 2020 10:54:36 +01:00

x86/boot/compressed/64: Introduce sev_status

Introduce sev_status and initialize it together with sme_me_mask to have
an indicator which SEV features are enabled.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20201028164659.27002-2-joro@8bytes.org
---
 arch/x86/boot/compressed/mem_encrypt.S | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index dd07e7b..3092ae1 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -81,6 +81,19 @@ SYM_FUNC_START(set_sev_encryption_mask)
 
 	bts	%rax, sme_me_mask(%rip)	/* Create the encryption mask */
 
+	/*
+	 * Read MSR_AMD64_SEV again and store it to sev_status. Can't do this in
+	 * get_sev_encryption_bit() because this function is 32-bit code and
+	 * shared between 64-bit and 32-bit boot path.
+	 */
+	movl	$MSR_AMD64_SEV, %ecx	/* Read the SEV MSR */
+	rdmsr
+
+	/* Store MSR value in sev_status */
+	shlq	$32, %rdx
+	orq	%rdx, %rax
+	movq	%rax, sev_status(%rip)
+
 .Lno_sev_mask:
 	movq	%rbp, %rsp		/* Restore original stack pointer */
 
@@ -96,5 +109,6 @@ SYM_FUNC_END(set_sev_encryption_mask)
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.balign	8
-SYM_DATA(sme_me_mask, .quad 0)
+SYM_DATA(sme_me_mask,		.quad 0)
+SYM_DATA(sev_status,		.quad 0)
 #endif

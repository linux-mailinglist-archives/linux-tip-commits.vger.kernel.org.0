Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0687B29F4C2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 20:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgJ2TSc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 15:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgJ2TRo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 15:17:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35698C0613CF;
        Thu, 29 Oct 2020 12:17:44 -0700 (PDT)
Date:   Thu, 29 Oct 2020 19:17:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603999062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlWtMMkpruve3YAQ6Lkk3FveNKTzsoC/56ay9Ftkrb8=;
        b=wJ5nD3inaHnapF7kxWu9z2AojMSXv7HAEhA853V9/R4Rbp06M7NKQIrLvl3uv9QJT1ojUI
        o8HnuAx8VLUkvha5+7buA4VDVW6EjqtYveSB+wZo6oy87aKlpvI3SZPcQKQotHjdcXdScL
        whxLXDPuK+QCczyDLlGZczY/Cc8VV4DoouffPch2qNnjBMFhBjp9WvJtI2Zu2RJIZkYpCZ
        duzRDoqltTXV1tmhGhur/Swcn1sj10FznIAczcFVtS5sl5X1MK+cTKsuyIFIfCx3ELjKVg
        2ANjfNsUcakRw5jIvlViXISa0GkOKXZe4zbhcH9buxHcHZJKyXUw88HMokQgHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603999062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlWtMMkpruve3YAQ6Lkk3FveNKTzsoC/56ay9Ftkrb8=;
        b=l6idq2h65kZh6Bn9fpYGmQ2BtvJjNHdec/wLrY+5GhYczXQwNnNVzOnjj7b3jsFY3E/wEo
        5eDSNNMPYfRoQXDQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Sanity-check CPUID results
 in the early #VC handler
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201028164659.27002-3-joro@8bytes.org>
References: <20201028164659.27002-3-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <160399906180.397.10854980565108573862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     ed7b895f3efb5df184722f5a30f8164fcaffceb1
Gitweb:        https://git.kernel.org/tip/ed7b895f3efb5df184722f5a30f8164fcaffceb1
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 28 Oct 2020 17:46:56 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 29 Oct 2020 13:48:49 +01:00

x86/boot/compressed/64: Sanity-check CPUID results in the early #VC handler

The early #VC handler which doesn't have a GHCB can only handle CPUID
exit codes. It is needed by the early boot code to handle #VC exceptions
raised in verify_cpu() and to get the position of the C-bit.

But the CPUID information comes from the hypervisor which is untrusted
and might return results which trick the guest into the no-SEV boot path
with no C-bit set in the page-tables. All data written to memory would
then be unencrypted and could leak sensitive data to the hypervisor.

Add sanity checks to the early #VC handler to make sure the hypervisor
can not pretend that SEV is disabled.

 [ bp: Massage a bit. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20201028164659.27002-3-joro@8bytes.org
---
 arch/x86/kernel/sev-es-shared.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 5f83cca..7d04b35 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -178,6 +178,32 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 		goto fail;
 	regs->dx = val >> 32;
 
+	/*
+	 * This is a VC handler and the #VC is only raised when SEV-ES is
+	 * active, which means SEV must be active too. Do sanity checks on the
+	 * CPUID results to make sure the hypervisor does not trick the kernel
+	 * into the no-sev path. This could map sensitive data unencrypted and
+	 * make it accessible to the hypervisor.
+	 *
+	 * In particular, check for:
+	 *	- Hypervisor CPUID bit
+	 *	- Availability of CPUID leaf 0x8000001f
+	 *	- SEV CPUID bit.
+	 *
+	 * The hypervisor might still report the wrong C-bit position, but this
+	 * can't be checked here.
+	 */
+
+	if ((fn == 1 && !(regs->cx & BIT(31))))
+		/* Hypervisor bit */
+		goto fail;
+	else if (fn == 0x80000000 && (regs->ax < 0x8000001f))
+		/* SEV leaf check */
+		goto fail;
+	else if ((fn == 0x8000001f && !(regs->ax & BIT(1))))
+		/* SEV bit */
+		goto fail;
+
 	/* Skip over the CPUID two-byte opcode */
 	regs->ip += 2;
 

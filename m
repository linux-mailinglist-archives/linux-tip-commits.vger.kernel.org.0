Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A48E409D41
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Sep 2021 21:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbhIMTkl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 13 Sep 2021 15:40:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbhIMTkh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 13 Sep 2021 15:40:37 -0400
Date:   Mon, 13 Sep 2021 19:39:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631561956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvh2aNpgEjB+qu7KHhTSh9RhV+DtQghdR7Dqdgn8iro=;
        b=Wb4pCdaXnoVFQJmX6yFFyGFj0zfx/pPVX5I0WXPQKm9YMz6K0YLirTgSaKFh9bbZWUvbIZ
        9kp64vETORNl5TyIHrhZwRaNgp0l//Qu5F3DfBiFlMrsSLj3xWOUNVP5IEOL4BByH0fBsS
        nP3FAky3MHeQ1Ma/3BYvFkFMX4aIMAD6zuLsC4XcASPFFpH18ZqP7fO/NtgnmiyTN8ccg6
        ISx0Vn1zxJkkooCfEUKZLkSM4ka9aGzUvmrFZdTcHUi1DSBYAqH7LMoz51mDEZP7KgQYuY
        uoiWkrcLgNJWHshOgIyx6RYiGROv3i+ioH7C/oYv2W9EF5wHQFsblBNGKEUmJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631561956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvh2aNpgEjB+qu7KHhTSh9RhV+DtQghdR7Dqdgn8iro=;
        b=Pmjfga+ORFACfiuF44o4SvFBmUCIua6xtt3qQLvurCyeevswa1AbdplYw+VfudbGlV+RDO
        OIYJwHhiYVVbeTBw==
From:   "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/asm: Avoid adding register pressure for the init
 case in static_cpu_has()
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210910195910.2542662-4-hpa@zytor.com>
References: <20210910195910.2542662-4-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <163156195512.25758.5915554914005716758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0507503671f9b1c867e889cbec0f43abf904f23c
Gitweb:        https://git.kernel.org/tip/0507503671f9b1c867e889cbec0f43abf904f23c
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Fri, 10 Sep 2021 12:59:10 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Sep 2021 19:48:21 +02:00

x86/asm: Avoid adding register pressure for the init case in static_cpu_has()

gcc will sometimes manifest the address of boot_cpu_data in a register
as part of constant propagation. When multiple static_cpu_has() are used
this may foul the mainline code with a register load which will only be
used on the fallback path, which is unused after initialization.

Explicitly force gcc to use immediate (rip-relative) addressing for
the fallback path, thus removing any possible register use from
static_cpu_has().

While making changes, modernize the code to use
.pushsection...popsection instead of .section...previous.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210910195910.2542662-4-hpa@zytor.com
---
 arch/x86/include/asm/cpufeature.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 16a51e7..1261842 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -173,20 +173,25 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
  * means that the boot_cpu_has() variant is already fast enough for the
  * majority of cases and you should stick to using it as it is generally
  * only two instructions: a RIP-relative MOV and a TEST.
+ *
+ * Do not use an "m" constraint for [cap_byte] here: gcc doesn't know
+ * that this is only used on a fallback path and will sometimes cause
+ * it to manifest the address of boot_cpu_data in a register, fouling
+ * the mainline (post-initialization) code.
  */
 static __always_inline bool _static_cpu_has(u16 bit)
 {
 	asm_volatile_goto(
 		ALTERNATIVE_TERNARY("jmp 6f", %P[feature], "", "jmp %l[t_no]")
-		".section .altinstr_aux,\"ax\"\n"
+		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
-		" testb %[bitnum],%[cap_byte]\n"
+		" testb %[bitnum]," _ASM_RIP(%P[cap_byte]) "\n"
 		" jnz %l[t_yes]\n"
 		" jmp %l[t_no]\n"
-		".previous\n"
+		".popsection\n"
 		 : : [feature]  "i" (bit),
 		     [bitnum]   "i" (1 << (bit & 7)),
-		     [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
+		     [cap_byte] "i" (&((const char *)boot_cpu_data.x86_capability)[bit >> 3])
 		 : : t_yes, t_no);
 t_yes:
 	return true;

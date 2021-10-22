Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3758437EE5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhJVT6x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 15:58:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbhJVT6u (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 15:58:50 -0400
Date:   Fri, 22 Oct 2021 19:56:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634932591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTor6TVHpKjixbtYZRLE7C1RWvrGzehOm+tc4i27YPI=;
        b=k348aGgfjLBY1CMtF6pRM2jwnyEgzrhOfGrB6tUj2/sbVu1MsVnYjbHDUIIwhMnurRfqRf
        vhRQrAi6njESFgE9Hcjirm/yYELz3jf+DEPUotHF+FTVjCJAfihjs33Ltedmgg7YydWnvh
        SQlw/Cvwloc3SH/RSpCmLXxGlHI8+8cTyHOfs7I+uHH94q5YxlfRzmbfKkqXo4wMP8I2+B
        ERnL8nlgcPru4MOjGxkhOo0blkDj2db5SoZaLeqP0VvcOCMBtLOthxUMPaOx7FF9lcq1RF
        o9Wvh37oAoVZazF/usqdapAEaIhizk1aHNTiOHMq8/JBcogv1AKuLbTzQqOE4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634932591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTor6TVHpKjixbtYZRLE7C1RWvrGzehOm+tc4i27YPI=;
        b=GHqP8bUNqiKrUMeI8Ig6Yer0DsSqwvvArV6G2De1jZqo3qw1B//qoe+1CJntJyOyY+aQhj
        C4rVoZNcHBFW1vCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Cleanup fpu__init_system_xstate_size_legacy()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211014230739.184014242@linutronix.de>
References: <20211014230739.184014242@linutronix.de>
MIME-Version: 1.0
Message-ID: <163493259093.626.13694318187887947288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     617473acdfe45aa9aa2be23cd5b02da7cd2717f8
Gitweb:        https://git.kernel.org/tip/617473acdfe45aa9aa2be23cd5b02da7cd2717f8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 01:09:31 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 19:18:43 +02:00

x86/fpu: Cleanup fpu__init_system_xstate_size_legacy()

Clean the function up before making changes.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211014230739.184014242@linutronix.de
---
 arch/x86/kernel/fpu/init.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 65d763f..c9293ad 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -199,17 +199,12 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	 * Note that xstate sizes might be overwritten later during
 	 * fpu__init_system_xstate().
 	 */
-
-	if (!boot_cpu_has(X86_FEATURE_FPU)) {
+	if (!cpu_feature_enabled(X86_FEATURE_FPU))
 		fpu_kernel_xstate_size = sizeof(struct swregs_state);
-	} else {
-		if (boot_cpu_has(X86_FEATURE_FXSR))
-			fpu_kernel_xstate_size =
-				sizeof(struct fxregs_state);
-		else
-			fpu_kernel_xstate_size =
-				sizeof(struct fregs_state);
-	}
+	else if (cpu_feature_enabled(X86_FEATURE_FXSR))
+		fpu_kernel_xstate_size = sizeof(struct fxregs_state);
+	else
+		fpu_kernel_xstate_size = sizeof(struct fregs_state);
 
 	fpu_user_xstate_size = fpu_kernel_xstate_size;
 	fpstate_reset(&current->thread.fpu);

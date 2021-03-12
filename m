Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E98338C03
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Mar 2021 12:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCLLyv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Mar 2021 06:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhCLLyl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Mar 2021 06:54:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2006C061574;
        Fri, 12 Mar 2021 03:54:41 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:54:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615550080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9i9nvZeGdocKJIrh0IyO/YALe0CC2/tUujiQjojuN/U=;
        b=Py55ETuWwBzWS0biHFuskSLLXXbuClG7ww+GYsNyM1LlvG5p+LoPIYj3oPJ/S5qW3KNLZz
        NSvvwMdq8JndVswGPcCI75OTDq3mauwFD9wEWG/hIfm4QBAA6sNooXj9sHH0wQVl8v6feD
        k41SnbrgDTWm8Tps+GwDeCAZmzE99ZWNy2831zjMuFd486quefhnLG08OgnAnzqYezSQaE
        GQ2yBwgMB/5dqVVy8wi0Juv5wtS++WJQgJ3/mZERW/XW1+0oVWU/kCGRJAr3OEQgtcxxSq
        CbYOfh5l/FlRh13iQ8qV0tq619IZUcMYCCOwh748VI0t4ZWEedzyW0QIZHg5hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615550080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9i9nvZeGdocKJIrh0IyO/YALe0CC2/tUujiQjojuN/U=;
        b=Kr+JFRf0Lv1l4dEnawX6Q77BhIaLddTIuzwzbNdJ80IleyeVs5pVJ1UNi82cZ5DVb9KIvm
        oWMOFfVE+ziMcWCw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Support not-feature
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210311142319.4723-6-jgross@suse.com>
References: <20210311142319.4723-6-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161555007985.398.7479645295029513973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     dda7bb76484978316bb412a353789ebc5901de36
Gitweb:        https://git.kernel.org/tip/dda7bb76484978316bb412a353789ebc5901de36
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 11 Mar 2021 15:23:10 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 11 Mar 2021 16:44:01 +01:00

x86/alternative: Support not-feature

Add support for alternative patching for the case a feature is not
present on the current CPU. For users of ALTERNATIVE() and friends, an
inverted feature is specified by applying the ALT_NOT() macro to it,
e.g.:

  ALTERNATIVE(old, new, ALT_NOT(feature));

Committer note:

The decision to encode the NOT-bit in the feature bit itself is because
a future change which would make objtool generate such alternative
calls, would keep the code in objtool itself fairly simple.

Also, this allows for the alternative macros to support the NOT feature
without having to change them.

Finally, the u16 cpuid member encoding the X86_FEATURE_ flags is not an
ABI so if more bits are needed, cpuid itself can be enlarged or a flags
field can be added to struct alt_instr after having considered the size
growth in either cases.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210311142319.4723-6-jgross@suse.com
---
 arch/x86/include/asm/alternative.h |  3 +++
 arch/x86/kernel/alternative.c      | 20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 53f295f..649e56f 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -6,6 +6,9 @@
 #include <linux/stringify.h>
 #include <asm/asm.h>
 
+#define ALTINSTR_FLAG_INV	(1 << 15)
+#define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/stddef.h>
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8d778e4..133b549 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -388,21 +388,31 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	 */
 	for (a = start; a < end; a++) {
 		int insn_buff_sz = 0;
+		/* Mask away "NOT" flag bit for feature to test. */
+		u16 feature = a->cpuid & ~ALTINSTR_FLAG_INV;
 
 		instr = (u8 *)&a->instr_offset + a->instr_offset;
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insn_buff));
-		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
-		if (!boot_cpu_has(a->cpuid)) {
+		BUG_ON(feature >= (NCAPINTS + NBUGINTS) * 32);
+
+		/*
+		 * Patch if either:
+		 * - feature is present
+		 * - feature not present but ALTINSTR_FLAG_INV is set to mean,
+		 *   patch if feature is *NOT* present.
+		 */
+		if (!boot_cpu_has(feature) == !(a->cpuid & ALTINSTR_FLAG_INV)) {
 			if (a->padlen > 1)
 				optimize_nops(a, instr);
 
 			continue;
 		}
 
-		DPRINTK("feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d), pad: %d",
-			a->cpuid >> 5,
-			a->cpuid & 0x1f,
+		DPRINTK("feat: %s%d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d), pad: %d",
+			(a->cpuid & ALTINSTR_FLAG_INV) ? "!" : "",
+			feature >> 5,
+			feature & 0x1f,
 			instr, instr, a->instrlen,
 			replacement, a->replacementlen, a->padlen);
 

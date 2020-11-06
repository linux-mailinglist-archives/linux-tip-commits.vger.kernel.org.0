Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5044F2AA11A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgKFX1c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38548 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgKFX13 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:29 -0500
Date:   Fri, 06 Nov 2020 23:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MIGdJo+a1mhpcsGUyQVDq5wNtn8Sp8hjlep86+l4aao=;
        b=fojbAvUIWCjMtot+9S2EiNrHr+mjYZ6/D8xs7LGfI9e3Qh0DvnzjGzMnqvPCbuPM50doRw
        btHSCax6TFDwyKO30JRioicbvrFePtwF6SGSQiW3uUKL3mFX/x5g39qnnKIBpYHhY3PAk3
        S2HwGUkaqtObmiZC9SYrFG6x6IUt14w34YgZzEf2LqDqNiINggul6jDNMTd4azNI75WpXI
        p5x6pjvy5Gl1b0H8rHzf5N5mq3dUuROb5a59v+KFabINDjwU8beTJa9PiuIFjDHnnIYVV2
        3BaOnM6Jpwh9Gs4Kzn+EuiVcmJ+EwJXLilEpzl+jsZTLDi3WVUFTPrPzq4Dthw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705247;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MIGdJo+a1mhpcsGUyQVDq5wNtn8Sp8hjlep86+l4aao=;
        b=PXQYvL2yeJC9idi4W2Bas27Jl512cfoGcI03ebPfZ7wfxK1ebjRaz2biywTo/2jy3vL8O8
        RSU/tIgy5xCXNoDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] asm-generic: Provide kmap_size.h
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095857.078043987@linutronix.de>
References: <20201103095857.078043987@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470524624.397.7764720699234410327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     4f8b96cd47b06f1e3ec71c1a3216113efe8dbfb5
Gitweb:        https://git.kernel.org/tip/4f8b96cd47b06f1e3ec71c1a3216113efe8dbfb5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:54 +01:00

asm-generic: Provide kmap_size.h

kmap_types.h is a misnomer because the old atomic MAP based array does not
exist anymore and the whole indirection of architectures including
kmap_types.h is inconinstent and does not allow to provide guard page
debugging for this misfeature.

Add a common header file which defines the mapping stack size for all
architectures. Will be used when converting architectures over to a
generic kmap_local/atomic implementation.

The array size is chosen with the following constraints in mind:

    - The deepest nest level in one context is 3 according to code
      inspection.

    - The worst case nesting for the upcoming reemptible version would be:

      2 maps in task context and a fault inside
      2 maps in the fault handler
      3 maps in softirq
      2 maps in interrupt

So a total of 16 is sufficient and probably overestimated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20201103095857.078043987@linutronix.de

---
 include/asm-generic/Kbuild      |  1 +
 include/asm-generic/kmap_size.h | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 include/asm-generic/kmap_size.h

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index e78bbb9..ed62d38 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -31,6 +31,7 @@ mandatory-y += irq_regs.h
 mandatory-y += irq_work.h
 mandatory-y += kdebug.h
 mandatory-y += kmap_types.h
+mandatory-y += kmap_size.h
 mandatory-y += kprobes.h
 mandatory-y += linkage.h
 mandatory-y += local.h
diff --git a/include/asm-generic/kmap_size.h b/include/asm-generic/kmap_size.h
new file mode 100644
index 0000000..9d6c778
--- /dev/null
+++ b/include/asm-generic/kmap_size.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_KMAP_SIZE_H
+#define _ASM_GENERIC_KMAP_SIZE_H
+
+/* For debug this provides guard pages between the maps */
+#ifdef CONFIG_DEBUG_HIGHMEM
+# define KM_MAX_IDX	33
+#else
+# define KM_MAX_IDX	16
+#endif
+
+#endif

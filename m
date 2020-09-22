Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E851B273EB6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Sep 2020 11:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgIVJl6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Sep 2020 05:41:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57530 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgIVJl6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Sep 2020 05:41:58 -0400
Date:   Tue, 22 Sep 2020 09:41:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600767715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28OF8xyUuF3xth7yE+5wXNZgEp58b87Vdy2+zVFqVAY=;
        b=iIAHq6lHY/nXhOjxqRreRHNAunAjeW37wBupcNej/UzBqfHInbbXo6xo0zdAG4BeGxKBvm
        M5srlFDjlCn2r+DpHpoI+YeBKk4rlXABhMq5/bPEgwpe+/2kfOd+UPYmKVA+z6R+HRHFJf
        LdH3G2nC7W+/6ZPd4KfXrx7QCpBXtTubgBg8n1dEfHyOWZeKo/m/7LpDoDQZxOHAN1fpQO
        hjnpg8bd22L3W5y56aB+002V5CC5aTNdIrqDzDWdDJ53OORdhd+rFy5JowvM1EVziW1fNk
        juCYYhGMMI8M0qR8G08BM3RFoVf5eYhYRpbvd9Pl+cIDFAID3zLuUsmmPgjPzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600767715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28OF8xyUuF3xth7yE+5wXNZgEp58b87Vdy2+zVFqVAY=;
        b=kl/KJbNbjo7+3v2LwryseS7+f6jPjrn/S08adXHeqylJ+usNElU3qjChPZctsvJV+mLG6G
        +TigRqrWcSE51xAw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pti] arch/um: Add a dummy <asm/cacheflush.h> header
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200922074951.2192-1-bp@alien8.de>
References: <20200922074951.2192-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160076771494.15536.16617325903250425535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pti branch of tip:

Commit-ID:     e9c142f6f54db85c212ca64aefd4f2c232dac4ae
Gitweb:        https://git.kernel.org/tip/e9c142f6f54db85c212ca64aefd4f2c232d=
ac4ae
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 22 Sep 2020 09:49:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Sep 2020 11:35:47 +02:00

arch/um: Add a dummy <asm/cacheflush.h> header

... in order to fix the defconfig build:

  ./arch/x86/include/asm/cacheflush.h: In function =E2=80=98l1d_flush_hw=E2=
=80=99:
  ./arch/x86/include/asm/cacheflush.h:15:6: error: implicit declaration of \
	  function =E2=80=98static_cpu_has=E2=80=99; did you mean =E2=80=98static_ke=
y_false=E2=80=99? [-Werror=3Dimplicit-function-declaration]

[ mingo: Changed the header guard to the existing nomenclature. ]

Fixes: a9210620ec36 ("x86/mm: Optionally flush L1D on context switch")
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200922074951.2192-1-bp@alien8.de
---
 arch/um/include/asm/cacheflush.h |  9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 arch/um/include/asm/cacheflush.h

diff --git a/arch/um/include/asm/cacheflush.h b/arch/um/include/asm/cacheflus=
h.h
new file mode 100644
index 0000000..f693cb9
--- /dev/null
+++ b/arch/um/include/asm/cacheflush.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UM_CACHEFLUSH_H
+#define _ASM_UM_CACHEFLUSH_H
+
+#undef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
+#include <asm-generic/cacheflush.h>
+
+static inline int l1d_flush_hw(void) { return -EOPNOTSUPP; }
+#endif /* _ASM_UM_CACHEFLUSH_H */

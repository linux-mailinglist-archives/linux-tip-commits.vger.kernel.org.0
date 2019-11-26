Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5186C1099D8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Nov 2019 09:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfKZIAm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Nov 2019 03:00:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41051 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfKZIAl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Nov 2019 03:00:41 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZVld-00034m-DF; Tue, 26 Nov 2019 09:00:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B25FF1C1D97;
        Tue, 26 Nov 2019 09:00:11 +0100 (CET)
Date:   Tue, 26 Nov 2019 08:00:11 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/headers] x86/kprobes: Explicitly include vmalloc.h for
 set_vm_flush_reset_perms()
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191119002121.4107-5-sean.j.christopherson@intel.com>
References: <20191119002121.4107-5-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157475521159.21853.4832305114102183027.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/headers branch of tip:

Commit-ID:     d5d411f81e552a67f2aa7cc39bba0c1d7d3db09a
Gitweb:        https://git.kernel.org/tip/d5d411f81e552a67f2aa7cc39bba0c1d7d3db09a
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Mon, 18 Nov 2019 16:21:13 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2019 17:50:26 +01:00

x86/kprobes: Explicitly include vmalloc.h for set_vm_flush_reset_perms()

The inclusion of linux/vmalloc.h, which is required for its definition
of set_vm_flush_reset_perms(), is somehow dependent on asm/realmode.h
being included by asm/acpi.h.  Explicitly include linux/vmalloc.h so
that a future patch can drop the realmode.h include from asm/acpi.h
without breaking the build.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191119002121.4107-5-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 43fc13c..e7d4c89 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -40,6 +40,7 @@
 #include <linux/frame.h>
 #include <linux/kasan.h>
 #include <linux/moduleloader.h>
+#include <linux/vmalloc.h>
 
 #include <asm/text-patching.h>
 #include <asm/cacheflush.h>

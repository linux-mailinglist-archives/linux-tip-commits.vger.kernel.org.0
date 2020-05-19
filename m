Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531011DA18F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 May 2020 21:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgEST63 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 May 2020 15:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgEST63 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 May 2020 15:58:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC40C08C5C0;
        Tue, 19 May 2020 12:58:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Nc-0008CN-IQ; Tue, 19 May 2020 21:58:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1D2E81C04D1;
        Tue, 19 May 2020 21:58:23 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:23 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/mce: Use untraced rd/wrmsr in the MCE
 offline/crash check
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505135314.426347351@linutronix.de>
References: <20200505135314.426347351@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991830302.17951.9379512980023231811.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     89cee5d63761ee0e9ca00631793eb16c8931421b
Gitweb:        https://git.kernel.org/tip/89cee5d63761ee0e9ca00631793eb16c8931421b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 04 Apr 2020 15:39:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:04:08 +02:00

x86/mce: Use untraced rd/wrmsr in the MCE offline/crash check

mce_check_crashing_cpu() is called right at the entry of the MCE
handler. It uses mce_rdmsr() and mce_wrmsr() which are wrappers around
rdmsr() and wrmsr() to handle the MCE error injection mechanism, which is
pointless in this context, i.e. when the MCE hits an offline CPU or the
system is already marked crashing.

The MSR access can also be traced, so use the untraceable variants. This
is also safe vs. XEN paravirt as these MSRs are not affected by XEN PV
modifications.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20200505135314.426347351@linutronix.de


---
 arch/x86/kernel/cpu/mce/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 842dd03..3177652 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1108,7 +1108,7 @@ static noinstr bool mce_check_crashing_cpu(void)
 	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
 
-		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
+		mcgstatus = __rdmsr(MSR_IA32_MCG_STATUS);
 
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
 			if (mcgstatus & MCG_STATUS_LMCES)
@@ -1116,7 +1116,7 @@ static noinstr bool mce_check_crashing_cpu(void)
 		}
 
 		if (mcgstatus & MCG_STATUS_RIPV) {
-			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
+			__wrmsr(MSR_IA32_MCG_STATUS, 0, 0);
 			return true;
 		}
 	}

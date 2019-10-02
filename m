Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D01C9191
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2019 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfJBTJ4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Oct 2019 15:09:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60726 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbfJBTJz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Oct 2019 15:09:55 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFk0L-0000qJ-HV; Wed, 02 Oct 2019 21:09:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E26151C03A9;
        Wed,  2 Oct 2019 21:09:40 +0200 (CEST)
Date:   Wed, 02 Oct 2019 19:09:40 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/rdrand: Sanity-check RDRAND output
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Pu Wen <puwen@hygon.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
References: <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <157004338078.9978.6255400681793760670.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7879fc4bdc7506d37bd67b6fc29442c53c06dfda
Gitweb:        https://git.kernel.org/tip/7879fc4bdc7506d37bd67b6fc29442c53c06dfda
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sun, 25 Aug 2019 22:50:18 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 19:55:32 +02:00

x86/rdrand: Sanity-check RDRAND output

It turned out recently that on certain AMD F15h and F16h machines, due
to the BIOS dropping the ball after resume, yet again, RDRAND would not
function anymore:

  c49a0a80137c ("x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h")

Add a silly test to the CPU bringup path, to sanity-check the random
data RDRAND returns and scream as loudly as possible if that returned
random data doesn't change.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com
---
 arch/x86/kernel/cpu/rdrand.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
index 5c900f9..c4be620 100644
--- a/arch/x86/kernel/cpu/rdrand.c
+++ b/arch/x86/kernel/cpu/rdrand.c
@@ -29,7 +29,8 @@ __setup("nordrand", x86_rdrand_setup);
 #ifdef CONFIG_ARCH_RANDOM
 void x86_init_rdrand(struct cpuinfo_x86 *c)
 {
-	unsigned long tmp;
+	unsigned int changed = 0;
+	unsigned long tmp, prev;
 	int i;
 
 	if (!cpu_has(c, X86_FEATURE_RDRAND))
@@ -42,5 +43,24 @@ void x86_init_rdrand(struct cpuinfo_x86 *c)
 			return;
 		}
 	}
+
+	/*
+	 * Stupid sanity-check whether RDRAND does *actually* generate
+	 * some at least random-looking data.
+	 */
+	prev = tmp;
+	for (i = 0; i < SANITY_CHECK_LOOPS; i++) {
+		if (rdrand_long(&tmp)) {
+			if (prev != tmp)
+				changed++;
+
+			prev = tmp;
+		}
+	}
+
+	if (WARN_ON_ONCE(!changed))
+		pr_emerg(
+"RDRAND gives funky smelling output, might consider not using it by booting with \"nordrand\"");
+
 }
 #endif

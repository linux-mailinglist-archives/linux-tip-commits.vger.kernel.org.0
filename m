Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FECFECB5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 16 Nov 2019 15:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfKPOjJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 16 Nov 2019 09:39:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45563 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfKPOjJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 16 Nov 2019 09:39:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVzDv-0003sV-Vl; Sat, 16 Nov 2019 15:38:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0FA201C1929;
        Sat, 16 Nov 2019 15:38:50 +0100 (CET)
Date:   Sat, 16 Nov 2019 14:38:49 -0000
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pti] x86/speculation: Fix redundant MDS mitigation message
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Waiman Long <longman@redhat.com>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>, "x86-ml" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191115161445.30809-3-longman@redhat.com>
References: <20191115161445.30809-3-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <157391512993.12247.8302437536557183530.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/pti branch of tip:

Commit-ID:     cd5a2aa89e847bdda7b62029d94e95488d73f6b2
Gitweb:        https://git.kernel.org/tip/cd5a2aa89e847bdda7b62029d94e95488d73f6b2
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 15 Nov 2019 11:14:45 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 16 Nov 2019 15:24:56 +01:00

x86/speculation: Fix redundant MDS mitigation message

Since MDS and TAA mitigations are inter-related for processors that are
affected by both vulnerabilities, the followiing confusing messages can
be printed in the kernel log:

  MDS: Vulnerable
  MDS: Mitigation: Clear CPU buffers

To avoid the first incorrect message, defer the printing of MDS
mitigation after the TAA mitigation selection has been done. However,
that has the side effect of printing TAA mitigation first before MDS
mitigation.

 [ bp: Check box is affected/mitigations are disabled first before
   printing and massage. ]

Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Mark Gross <mgross@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191115161445.30809-3-longman@redhat.com
---
 arch/x86/kernel/cpu/bugs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cb513ea..8bf6489 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -39,6 +39,7 @@ static void __init spectre_v2_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
+static void __init mds_print_mitigation(void);
 static void __init taa_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR that always has to be preserved. */
@@ -108,6 +109,12 @@ void __init check_bugs(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 
+	/*
+	 * As MDS and TAA mitigations are inter-related, print MDS
+	 * mitigation until after TAA mitigation selection is done.
+	 */
+	mds_print_mitigation();
+
 	arch_smt_update();
 
 #ifdef CONFIG_X86_32
@@ -245,6 +252,12 @@ static void __init mds_select_mitigation(void)
 		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
 			cpu_smt_disable(false);
 	}
+}
+
+static void __init mds_print_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
+		return;
 
 	pr_info("%s\n", mds_strings[mds_mitigation]);
 }

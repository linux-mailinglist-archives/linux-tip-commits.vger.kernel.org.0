Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D3F2C0B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2019 11:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbfKGKVH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 7 Nov 2019 05:21:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47090 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387779AbfKGKVG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 7 Nov 2019 05:21:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iSeuM-00034l-GI; Thu, 07 Nov 2019 11:20:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 466191C010B;
        Thu,  7 Nov 2019 11:20:53 +0100 (CET)
Date:   Thu, 07 Nov 2019 10:20:52 -0000
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/umip: Make the comments vendor-agnostic
Cc:     Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <157298913784.17462.12654728938970637305.stgit@naples-babu.amd.com>
References: <157298913784.17462.12654728938970637305.stgit@naples-babu.amd.com>
MIME-Version: 1.0
Message-ID: <157312205287.29376.490924999918229502.tip-bot2@tip-bot2>
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

Commit-ID:     9774a96f785bf0fa6d956ce33300463f1704dbeb
Gitweb:        https://git.kernel.org/tip/9774a96f785bf0fa6d956ce33300463f1704dbeb
Author:        Babu Moger <Babu.Moger@amd.com>
AuthorDate:    Tue, 05 Nov 2019 21:25:40 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Nov 2019 11:16:44 +01:00

x86/umip: Make the comments vendor-agnostic

AMD 2nd generation EPYC processors also support the UMIP feature. Make
the comments vendor-agnostic.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>
Link: https://lkml.kernel.org/r/157298913784.17462.12654728938970637305.stgit@naples-babu.amd.com
---
 arch/x86/kernel/umip.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 548fefe..8ccef6c 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -1,6 +1,6 @@
 /*
- * umip.c Emulation for instruction protected by the Intel User-Mode
- * Instruction Prevention feature
+ * umip.c Emulation for instruction protected by the User-Mode Instruction
+ * Prevention feature
  *
  * Copyright (c) 2017, Intel Corporation.
  * Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
@@ -18,10 +18,10 @@
 
 /** DOC: Emulation for User-Mode Instruction Prevention (UMIP)
  *
- * The feature User-Mode Instruction Prevention present in recent Intel
- * processor prevents a group of instructions (SGDT, SIDT, SLDT, SMSW and STR)
- * from being executed with CPL > 0. Otherwise, a general protection fault is
- * issued.
+ * User-Mode Instruction Prevention is a security feature present in recent
+ * x86 processors that, when enabled, prevents a group of instructions (SGDT,
+ * SIDT, SLDT, SMSW and STR) from being run in user mode by issuing a general
+ * protection fault if the instruction is executed with CPL > 0.
  *
  * Rather than relaying to the user space the general protection fault caused by
  * the UMIP-protected instructions (in the form of a SIGSEGV signal), it can be

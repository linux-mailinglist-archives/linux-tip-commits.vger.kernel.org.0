Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5736413A715
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Jan 2020 11:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgANKRw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Jan 2020 05:17:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731705AbgANKRA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Jan 2020 05:17:00 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFo-0007hZ-H7; Tue, 14 Jan 2020 11:16:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A20731C192D;
        Tue, 14 Jan 2020 11:16:54 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:54 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/centaur: Use common IA32_FEAT_CTL MSR initialization
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-7-sean.j.christopherson@intel.com>
References: <20191221044513.21680-7-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701451.1022.3088748665494770643.tip-bot2@tip-bot2>
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

Commit-ID:     501444905fcb4166589fda99497c273ac5efc65e
Gitweb:        https://git.kernel.org/tip/501444905fcb4166589fda99497c273ac5efc65e
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:00 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 17:48:36 +01:00

x86/centaur: Use common IA32_FEAT_CTL MSR initialization

Use the recently added IA32_FEAT_CTL MSR initialization sequence to
opportunistically enable VMX support when running on a Centaur CPU.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-7-sean.j.christopherson@intel.com
---
 arch/x86/Kconfig.cpu          | 2 +-
 arch/x86/kernel/cpu/centaur.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 98be76f..cba5b64 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -389,7 +389,7 @@ config X86_DEBUGCTLMSR
 
 config IA32_FEAT_CTL
 	def_bool y
-	depends on CPU_SUP_INTEL
+	depends on CPU_SUP_INTEL || CPU_SUP_CENTAUR
 
 menuconfig PROCESSOR_SELECT
 	bool "Supported processor vendors" if EXPERT
diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 14433ff..084f604 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -250,6 +250,8 @@ static void init_centaur(struct cpuinfo_x86 *c)
 	set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
 #endif
 
+	init_ia32_feat_ctl(c);
+
 	if (cpu_has(c, X86_FEATURE_VMX))
 		centaur_detect_vmx_virtcap(c);
 }

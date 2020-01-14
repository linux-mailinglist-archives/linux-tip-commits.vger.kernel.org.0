Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5F13A712
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Jan 2020 11:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgANKRs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Jan 2020 05:17:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732190AbgANKRB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Jan 2020 05:17:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFq-0007hu-4I; Tue, 14 Jan 2020 11:16:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 025C01C1928;
        Tue, 14 Jan 2020 11:16:55 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:54 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mce: WARN once if IA32_FEAT_CTL MSR is left unlocked
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-6-sean.j.christopherson@intel.com>
References: <20191221044513.21680-6-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701473.1022.7710565151243359704.tip-bot2@tip-bot2>
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

Commit-ID:     6d527cebfa04ba4792be9e79e0d7cab22ab6c377
Gitweb:        https://git.kernel.org/tip/6d527cebfa04ba4792be9e79e0d7cab22ab6c377
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:44:59 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 17:47:18 +01:00

x86/mce: WARN once if IA32_FEAT_CTL MSR is left unlocked

WARN if the IA32_FEAT_CTL MSR is somehow left unlocked now that CPU
initialization unconditionally locks the MSR.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-6-sean.j.christopherson@intel.com
---
 arch/x86/kernel/cpu/mce/intel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index c238518..5627b10 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -116,14 +116,15 @@ static bool lmce_supported(void)
 	/*
 	 * BIOS should indicate support for LMCE by setting bit 20 in
 	 * IA32_FEAT_CTL without which touching MCG_EXT_CTL will generate a #GP
-	 * fault.
+	 * fault.  The MSR must also be locked for LMCE_ENABLED to take effect.
+	 * WARN if the MSR isn't locked as init_ia32_feat_ctl() unconditionally
+	 * locks the MSR in the event that it wasn't already locked by BIOS.
 	 */
 	rdmsrl(MSR_IA32_FEAT_CTL, tmp);
-	if ((tmp & (FEAT_CTL_LOCKED | FEAT_CTL_LMCE_ENABLED)) ==
-		   (FEAT_CTL_LOCKED | FEAT_CTL_LMCE_ENABLED))
-		return true;
+	if (WARN_ON_ONCE(!(tmp & FEAT_CTL_LOCKED)))
+		return false;
 
-	return false;
+	return tmp & FEAT_CTL_LMCE_ENABLED;
 }
 
 bool mce_intel_cmci_poll(void)

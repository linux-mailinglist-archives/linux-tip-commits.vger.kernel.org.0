Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA5FC30A5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Oct 2019 11:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfJAJw3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Oct 2019 05:52:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54712 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJAJw3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Oct 2019 05:52:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFEpV-0007B9-NL; Tue, 01 Oct 2019 11:52:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4B6D81C03AB;
        Tue,  1 Oct 2019 11:52:25 +0200 (CEST)
Date:   Tue, 01 Oct 2019 09:52:25 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Make disable_err_thresholding() static
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190928170539.2729-1-bp@alien8.de>
References: <20190928170539.2729-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <156992354518.9978.16819187666387348387.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     47cd84e98f512eac5aad988f08baff432aea35ba
Gitweb:        https://git.kernel.org/tip/47cd84e98f512eac5aad988f08baff432aea35ba
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sat, 28 Sep 2019 19:02:29 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 11:42:59 +02:00

x86/mce/amd: Make disable_err_thresholding() static

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190928170539.2729-1-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6ea7fdc..5167bd2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -583,7 +583,7 @@ bool amd_filter_mce(struct mce *m)
  * - Prevent possible spurious interrupts from the IF bank on Family 0x17
  *   Models 0x10-0x2F due to Erratum #1114.
  */
-void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
+static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 {
 	int i, num_msrs;
 	u64 hwcr;

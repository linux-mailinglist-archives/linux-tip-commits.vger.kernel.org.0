Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1FDEC301A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Oct 2019 11:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfJAJXx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Oct 2019 05:23:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54630 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfJAJXx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Oct 2019 05:23:53 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFENn-0006fc-IQ; Tue, 01 Oct 2019 11:23:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 28EAD1C03AB;
        Tue,  1 Oct 2019 11:23:47 +0200 (CEST)
Date:   Tue, 01 Oct 2019 09:23:46 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/nmi: Remove stale EDAC include leftover
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190923193807.30896-1-bp@alien8.de>
References: <20190923193807.30896-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <156992182699.9978.3620777237467343344.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     abaebe11dd07adf51b53bb7c56ba35eab267654d
Gitweb:        https://git.kernel.org/tip/abaebe11dd07adf51b53bb7c56ba35eab267654d
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 16 Aug 2018 09:14:04 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 11:11:11 +02:00

x86/nmi: Remove stale EDAC include leftover

db47d5f85646 ("x86/nmi, EDAC: Get rid of DRAM error reporting thru PCI SERR NMI")

forgot to remove it. Drop it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190923193807.30896-1-bp@alien8.de
---
 arch/x86/kernel/traps.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4bb0f84..c903121 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -37,11 +37,6 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/io.h>
-
-#if defined(CONFIG_EDAC)
-#include <linux/edac.h>
-#endif
-
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
 #include <asm/debugreg.h>

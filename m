Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5B1D5EF6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 16 May 2020 07:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgEPFzl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 16 May 2020 01:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725803AbgEPFzl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 16 May 2020 01:55:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649FC061A0C;
        Fri, 15 May 2020 22:55:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jZpnO-0005op-Kn; Sat, 16 May 2020 07:55:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E9AB41C01BB;
        Sat, 16 May 2020 07:55:37 +0200 (CEST)
Date:   Sat, 16 May 2020 05:55:37 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/nmi: Remove edac.h include leftover
Cc:     Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200515182246.3553-1-bp@alien8.de>
References: <20200515182246.3553-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158960853783.17951.15482412371733766732.tip-bot2@tip-bot2>
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

Commit-ID:     6255c161a08564e4f3995db31f3d64a5fd24738b
Gitweb:        https://git.kernel.org/tip/6255c161a08564e4f3995db31f3d64a5fd24738b
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 15 May 2020 20:21:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 16 May 2020 07:47:57 +02:00

x86/nmi: Remove edac.h include leftover

... which

  db47d5f85646 ("x86/nmi, EDAC: Get rid of DRAM error reporting thru PCI SERR NMI")

forgot to remove.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200515182246.3553-1-bp@alien8.de
---
 arch/x86/kernel/nmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 6407ea2..bdcc514 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -25,10 +25,6 @@
 #include <linux/atomic.h>
 #include <linux/sched/clock.h>
 
-#if defined(CONFIG_EDAC)
-#include <linux/edac.h>
-#endif
-
 #include <asm/cpu_entry_area.h>
 #include <asm/traps.h>
 #include <asm/mach_traps.h>

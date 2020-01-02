Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD76E12E4CB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  2 Jan 2020 11:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgABKHX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 2 Jan 2020 05:07:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55351 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgABKHX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 2 Jan 2020 05:07:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1imxNp-0007Sk-0f; Thu, 02 Jan 2020 11:07:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4A5CD1C2BEB;
        Thu,  2 Jan 2020 11:07:12 +0100 (CET)
Date:   Thu, 02 Jan 2020 10:07:12 -0000
From:   "tip-bot2 for Anthony Steinhauser" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/nospec: Remove unused RSB_FILL_LOOPS
Cc:     Anthony Steinhauser <asteinhauser@google.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191226204512.24524-1-asteinhauser@google.com>
References: <20191226204512.24524-1-asteinhauser@google.com>
MIME-Version: 1.0
Message-ID: <157795963208.30329.11151985298082895162.tip-bot2@tip-bot2>
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

Commit-ID:     fae7bfcc78146057ac2730719de8d5e41de19540
Gitweb:        https://git.kernel.org/tip/fae7bfcc78146057ac2730719de8d5e41de19540
Author:        Anthony Steinhauser <asteinhauser@google.com>
AuthorDate:    Thu, 26 Dec 2019 12:45:12 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 02 Jan 2020 10:54:53 +01:00

x86/nospec: Remove unused RSB_FILL_LOOPS

It was never really used, see

  117cc7a908c8 ("x86/retpoline: Fill return stack buffer on vmexit")

  [ bp: Massage. ]

Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191226204512.24524-1-asteinhauser@google.com
---
 arch/x86/include/asm/nospec-branch.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 5c24a7b..07e95dc 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -37,7 +37,6 @@
  */
 
 #define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
-#define RSB_FILL_LOOPS		16	/* To avoid underflow */
 
 /*
  * Google experimented with loop-unrolling and this turned out to be

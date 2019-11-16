Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90D49FEC0C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 16 Nov 2019 12:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfKPLv6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 16 Nov 2019 06:51:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45292 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfKPLvf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 16 Nov 2019 06:51:35 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwc0-0002AM-RX; Sat, 16 Nov 2019 12:51:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B1CDE1C1901;
        Sat, 16 Nov 2019 12:51:23 +0100 (CET)
Date:   Sat, 16 Nov 2019 11:51:23 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/ioperm: Avoid bitmap allocation if no permissions are set
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157390508369.12247.423990236164065074.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     32f3bf67ee78332f2caec0984cb9d412cd0a3c23
Gitweb:        https://git.kernel.org/tip/32f3bf67ee78332f2caec0984cb9d412cd0a3c23
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 12 Nov 2019 19:56:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 11:24:01 +01:00

x86/ioperm: Avoid bitmap allocation if no permissions are set

If ioperm() is invoked the first time and the @turn_on argument is 0, then
there is no point to allocate a bitmap just to clear permissions which are
not set.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/ioport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index ca6aa1e..80fa36b 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -36,6 +36,9 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	 */
 	bitmap = t->io_bitmap_ptr;
 	if (!bitmap) {
+		/* No point to allocate a bitmap just to clear permissions */
+		if (!turn_on)
+			return 0;
 		bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!bitmap)
 			return -ENOMEM;

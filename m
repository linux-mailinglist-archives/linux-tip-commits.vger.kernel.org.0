Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2224113581E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2020 12:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgAILh1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Jan 2020 06:37:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53970 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgAILh1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Jan 2020 06:37:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipW7s-00087p-M5; Thu, 09 Jan 2020 12:37:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EA3FD1C2C9C;
        Thu,  9 Jan 2020 12:37:19 +0100 (CET)
Date:   Thu, 09 Jan 2020 11:37:19 -0000
From:   "tip-bot2 for Jan Beulich" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry/64: Add instruction suffix to SYSRET
Cc:     Jan Beulich <jbeulich@suse.com>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <038a7c35-062b-a285-c6d2-653b56585844@suse.com>
References: <038a7c35-062b-a285-c6d2-653b56585844@suse.com>
MIME-Version: 1.0
Message-ID: <157856983975.30329.1296701997365239549.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     b2b1d94cdfd4e906d3936dab2850096a4a0c2017
Gitweb:        https://git.kernel.org/tip/b2b1d94cdfd4e906d3936dab2850096a4a0c2017
Author:        Jan Beulich <jbeulich@suse.com>
AuthorDate:    Mon, 16 Dec 2019 11:40:03 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 09 Jan 2020 12:33:43 +01:00

x86/entry/64: Add instruction suffix to SYSRET

ignore_sysret() contains an unsuffixed SYSRET instruction. gas correctly
interprets this as SYSRETL, but leaving it up to gas to guess when there
is no register operand that implies a size is bad practice, and upstream
gas is likely to warn about this in the future. Use SYSRETL explicitly.
This does not change the assembled output.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/038a7c35-062b-a285-c6d2-653b56585844@suse.com
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 76942cb..f2bb91e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1728,7 +1728,7 @@ SYM_CODE_END(nmi)
 SYM_CODE_START(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	mov	$-ENOSYS, %eax
-	sysret
+	sysretl
 SYM_CODE_END(ignore_sysret)
 #endif
 

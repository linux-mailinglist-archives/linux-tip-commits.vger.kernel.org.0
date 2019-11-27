Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB71010AD8B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Nov 2019 11:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfK0K2O (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Nov 2019 05:28:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44266 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfK0K2O (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Nov 2019 05:28:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZuYM-0004KS-Tg; Wed, 27 Nov 2019 11:28:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B6481C1E75;
        Wed, 27 Nov 2019 11:28:10 +0100 (CET)
Date:   Wed, 27 Nov 2019 10:28:10 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/32: Remove unused 'restore_all_notrace'
 local label
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
MIME-Version: 1.0
Message-ID: <157485049034.21853.7019749519013705012.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3e1b43586eae232157ca70e905cece0297f17bfd
Gitweb:        https://git.kernel.org/tip/3e1b43586eae232157ca70e905cece0297f17bfd
Author:        Borislav Petkov <bp@alien8.de>
AuthorDate:    Sun, 24 Nov 2019 17:12:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 10:38:16 +01:00

x86/entry/32: Remove unused 'restore_all_notrace' local label

Signed-off-by: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_32.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 632432b..7e05604 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1090,7 +1090,6 @@ SYM_FUNC_START(entry_INT80_32)
 restore_all:
 	TRACE_IRQS_IRET
 	SWITCH_TO_ENTRY_STACK
-.Lrestore_all_notrace:
 	CHECK_AND_APPLY_ESPFIX
 .Lrestore_nocheck:
 	/* Switch back to user CR3 */

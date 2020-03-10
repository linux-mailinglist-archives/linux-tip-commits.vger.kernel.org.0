Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43B17FA0F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Mar 2020 14:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgCJNC0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Mar 2020 09:02:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33608 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgCJNCW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Mar 2020 09:02:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jBeWZ-0000JH-71; Tue, 10 Mar 2020 14:02:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BECAE1C2234;
        Tue, 10 Mar 2020 14:02:17 +0100 (CET)
Date:   Tue, 10 Mar 2020 13:02:17 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Remove unused label restore_nocheck
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200308222609.219366430@linutronix.de>
References: <20200308222609.219366430@linutronix.de>
MIME-Version: 1.0
Message-ID: <158384533739.28353.17262412984967882832.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     74a4882d723a76cb3c72caf440ca5ef3f2bca6ab
Gitweb:        https://git.kernel.org/tip/74a4882d723a76cb3c72caf440ca5ef3f2bca6ab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 08 Mar 2020 23:24:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Mar 2020 13:56:32 +01:00

x86/entry/32: Remove unused label restore_nocheck

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200308222609.219366430@linutronix.de
---
 arch/x86/entry/entry_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index ddc87f2..80df781 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1091,7 +1091,7 @@ restore_all:
 	TRACE_IRQS_IRET
 	SWITCH_TO_ENTRY_STACK
 	CHECK_AND_APPLY_ESPFIX
-.Lrestore_nocheck:
+
 	/* Switch back to user CR3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
 

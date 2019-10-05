Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62774CC94B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  5 Oct 2019 12:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfJEKPK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 5 Oct 2019 06:15:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39717 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfJEKPK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 5 Oct 2019 06:15:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iGh5W-0001FB-Ea; Sat, 05 Oct 2019 12:14:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 94F1C1C0334;
        Sat,  5 Oct 2019 12:14:57 +0200 (CEST)
Date:   Sat, 05 Oct 2019 10:14:57 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Make boot_gdt_descr local
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191003095238.29831-2-jslaby@suse.cz>
References: <20191003095238.29831-2-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157027049748.9978.13067332350014336578.tip-bot2@tip-bot2>
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

Commit-ID:     5aa5cbd2e95e0079b2cc6b4b66f0d0de5e0fbbfd
Gitweb:        https://git.kernel.org/tip/5aa5cbd2e95e0079b2cc6b4b66f0d0de5e0fbbfd
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Thu, 03 Oct 2019 11:52:38 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 05 Oct 2019 12:11:05 +02:00

x86/asm: Make boot_gdt_descr local

As far as I can see, it was never used outside of head_32.S. Not even
when added in 2004. So make it local.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191003095238.29831-2-jslaby@suse.cz
---
 arch/x86/kernel/head_32.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 30f9cb2..7feb953 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -597,8 +597,6 @@ int_msg:
  */
 
 	.data
-.globl boot_gdt_descr
-
 	ALIGN
 # early boot GDT descriptor (must use 1:1 address mapping)
 	.word 0				# 32 bit align gdt_desc.address

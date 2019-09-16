Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70549B3CF4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Sep 2019 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfIPOzG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Sep 2019 10:55:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39494 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbfIPOzG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Sep 2019 10:55:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i9sP0-0001d7-M3; Mon, 16 Sep 2019 16:54:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2CE4F1C06CD;
        Mon, 16 Sep 2019 16:54:54 +0200 (CEST)
Date:   Mon, 16 Sep 2019 14:54:54 -0000
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Enable 5-level paging support by default
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190913095452.40592-1-kirill.shutemov@linux.intel.com>
References: <20190913095452.40592-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156864569401.24167.16824438993576938124.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     18ec1eaf58fbf2d9009a752a102a3d8e0d905a0f
Gitweb:        https://git.kernel.org/tip/18ec1eaf58fbf2d9009a752a102a3d8e0d905a0f
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 13 Sep 2019 12:54:52 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 16 Sep 2019 16:51:20 +02:00

x86/mm: Enable 5-level paging support by default

Support of boot-time switching between 4- and 5-level paging mode is
upstream since 4.17.

We run internal testing with 5-level paging support enabled for a while
and it doesn't not cause any functional or performance regression on
4-level paging hardware.

The only 5-level paging related regressions I saw were in early boot
code that runs independently from CONFIG_X86_5LEVEL.

The next major release of distributions expected to have
CONFIG_X86_5LEVEL=y.

Enable the option by default. It may help to catch obscure bugs early.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: https://lkml.kernel.org/r/20190913095452.40592-1-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58eae28..d4bbebe 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1483,6 +1483,7 @@ config X86_PAE
 
 config X86_5LEVEL
 	bool "Enable 5-level page tables support"
+	default y
 	select DYNAMIC_MEMORY_LAYOUT
 	select SPARSEMEM_VMEMMAP
 	depends on X86_64

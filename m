Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C711FA38C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Jun 2020 00:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgFOWbv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Jun 2020 18:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFOWbu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Jun 2020 18:31:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FD8C061A0E;
        Mon, 15 Jun 2020 15:31:50 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jkxdn-0006xU-Qh; Tue, 16 Jun 2020 00:31:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C4A161C0085;
        Tue, 16 Jun 2020 00:31:42 +0200 (CEST)
Date:   Mon, 15 Jun 2020 22:31:42 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry, bug: Comment the instrumentation_begin()
 usage for WARN()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159226030243.16989.1181108519578141239.tip-bot2@tip-bot2>
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

Commit-ID:     8e8bb06d199a5aa7a534aa3b3fc0abbbc11ca438
Gitweb:        https://git.kernel.org/tip/8e8bb06d199a5aa7a534aa3b3fc0abbbc11ca438
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 04 Jun 2020 11:17:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:10 +02:00

x86/entry, bug: Comment the instrumentation_begin() usage for WARN()

Explain the rationale for annotating WARN(), even though, strictly
speaking printk() and friends are very much not safe in many of the
places we put them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index fb34ff6..0281895 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -75,6 +75,12 @@ do {								\
 	unreachable();						\
 } while (0)
 
+/*
+ * This instrumentation_begin() is strictly speaking incorrect; but it
+ * suppresses the complaints from WARN()s in noinstr code. If such a WARN()
+ * were to trigger, we'd rather wreck the machine in an attempt to get the
+ * message out than not know about it.
+ */
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\

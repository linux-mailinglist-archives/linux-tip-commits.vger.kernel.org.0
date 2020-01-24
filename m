Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C22147A29
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jan 2020 10:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgAXJNi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Jan 2020 04:13:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41856 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730135AbgAXJNi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Jan 2020 04:13:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iuv1v-0007dp-4K; Fri, 24 Jan 2020 10:13:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B2DF51C1A4E;
        Fri, 24 Jan 2020 10:13:30 +0100 (CET)
Date:   Fri, 24 Jan 2020 09:13:30 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan, ubsan: Make KCSAN+UBSAN work together
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157985721055.396.8618031890943312175.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     d47715f50e833f12c5e829ce9dcc4a65104fa74f
Gitweb:        https://git.kernel.org/tip/d47715f50e833f12c5e829ce9dcc4a65104fa74f
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 19 Nov 2019 19:57:42 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 07 Jan 2020 07:47:23 -08:00

kcsan, ubsan: Make KCSAN+UBSAN work together

Context:
http://lkml.kernel.org/r/fb7e25d8-aba4-3dcf-7761-cb7ecb3ebb71@infradead.org

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/Makefile | 1 +
 lib/Makefile          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index dd15b62..df6b779 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 KCSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
+UBSAN_SANITIZE := n
 
 CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
 
diff --git a/lib/Makefile b/lib/Makefile
index 778ab70..9d5bda9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -279,6 +279,7 @@ obj-$(CONFIG_UBSAN) += ubsan.o
 
 UBSAN_SANITIZE_ubsan.o := n
 KASAN_SANITIZE_ubsan.o := n
+KCSAN_SANITIZE_ubsan.o := n
 CFLAGS_ubsan.o := $(call cc-option, -fno-stack-protector) $(DISABLE_STACKLEAK_PLUGIN)
 
 obj-$(CONFIG_SBITMAP) += sbitmap.o

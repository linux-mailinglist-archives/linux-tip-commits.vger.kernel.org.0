Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208281FA396
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Jun 2020 00:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgFOWcC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Jun 2020 18:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgFOWcB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Jun 2020 18:32:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DA5C061A0E;
        Mon, 15 Jun 2020 15:32:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jkxdq-0006xl-EZ; Tue, 16 Jun 2020 00:31:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DE4561C06DA;
        Tue, 16 Jun 2020 00:31:44 +0200 (CEST)
Date:   Mon, 15 Jun 2020 22:31:44 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] kasan: Bump required compiler version
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrey Konovalov <andreyknvl@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200602175859.GC2604@hirez.programming.kicks-ass.net>
References: <20200602175859.GC2604@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159226030455.16989.7282639700613712324.tip-bot2@tip-bot2>
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

Commit-ID:     7b861a53e46b6b42ab8560b105af308cb72d7285
Gitweb:        https://git.kernel.org/tip/7b861a53e46b6b42ab8560b105af308cb72d7285
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 04 Jun 2020 07:58:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:09 +02:00

kasan: Bump required compiler version

Adds config variable CC_HAS_WORKING_NOSANITIZE_ADDRESS, which will be
true if we have a compiler that does not fail builds due to
no_sanitize_address functions. This does not yet mean they work as
intended, but for automated build-tests, this is the minimum
requirement.

For example, we require that __always_inline functions used from
no_sanitize_address functions do not generate instrumentation. On GCC <=
7 this fails to build entirely, therefore we make the minimum version
GCC 8.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://lkml.kernel.org/r/20200602175859.GC2604@hirez.programming.kicks-ass.net
---
 lib/Kconfig.kasan | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 81f5464..af0dd09 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -15,11 +15,15 @@ config CC_HAS_KASAN_GENERIC
 config CC_HAS_KASAN_SW_TAGS
 	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
 
+config CC_HAS_WORKING_NOSANITIZE_ADDRESS
+	def_bool !CC_IS_GCC || GCC_VERSION >= 80000
+
 config KASAN
 	bool "KASAN: runtime memory debugger"
 	depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
+	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.

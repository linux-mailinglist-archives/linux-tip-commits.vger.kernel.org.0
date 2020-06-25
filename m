Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65954209DC8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Jun 2020 13:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404378AbgFYLxo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Jun 2020 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404436AbgFYLxn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1D8C061573;
        Thu, 25 Jun 2020 04:53:43 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1joQRi-0005t6-4n; Thu, 25 Jun 2020 13:53:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BDBFC1C0470;
        Thu, 25 Jun 2020 13:53:33 +0200 (CEST)
Date:   Thu, 25 Jun 2020 11:53:33 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] kasan: Fix required compiler version
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200623112448.GA208112@elver.google.com>
References: <20200623112448.GA208112@elver.google.com>
MIME-Version: 1.0
Message-ID: <159308601356.16989.12751818428543798162.tip-bot2@tip-bot2>
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

Commit-ID:     acf7b0bf7dcf5a96d9b44a0997227c7210d995c1
Gitweb:        https://git.kernel.org/tip/acf7b0bf7dcf5a96d9b44a0997227c7210d995c1
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 23 Jun 2020 13:24:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Jun 2020 13:45:39 +02:00

kasan: Fix required compiler version

The first working GCC version to satisfy
CC_HAS_WORKING_NOSANITIZE_ADDRESS is GCC 8.3.0.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89124
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200623112448.GA208112@elver.google.com
---
 lib/Kconfig.kasan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index af0dd09..34b84bc 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -16,7 +16,7 @@ config CC_HAS_KASAN_SW_TAGS
 	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
 
 config CC_HAS_WORKING_NOSANITIZE_ADDRESS
-	def_bool !CC_IS_GCC || GCC_VERSION >= 80000
+	def_bool !CC_IS_GCC || GCC_VERSION >= 80300
 
 config KASAN
 	bool "KASAN: runtime memory debugger"

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149BB1B9310
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Apr 2020 20:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDZSmv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 26 Apr 2020 14:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgDZSmv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 26 Apr 2020 14:42:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A971C061A0F;
        Sun, 26 Apr 2020 11:42:51 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEp-00078x-JW; Sun, 26 Apr 2020 20:42:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D6F511C0178;
        Sun, 26 Apr 2020 20:42:46 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:46 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/cpu: Export native_write_cr4() only when CONFIG_LKTDM=m
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092558.939985695@linutronix.de>
References: <20200421092558.939985695@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792656642.28353.3424858438279806300.tip-bot2@tip-bot2>
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

Commit-ID:     21953ee5013d6632bee90ec89f2df59c69050db0
Gitweb:        https://git.kernel.org/tip/21953ee5013d6632bee90ec89f2df59c69050db0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 26 Apr 2020 18:55:15 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 20:16:46 +02:00

x86/cpu: Export native_write_cr4() only when CONFIG_LKTDM=m

Modules have no business poking into this but fixing this is for later.

 [ bp: Carve out from an earlier patch. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200421092558.939985695@linutronix.de
---
 arch/x86/kernel/cpu/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 82042f4..eab3ebd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -387,7 +387,9 @@ set_register:
 			  bits_missing);
 	}
 }
+#if IS_MODULE(CONFIG_LKDTM)
 EXPORT_SYMBOL_GPL(native_write_cr4);
+#endif
 
 void cr4_update_irqsoff(unsigned long set, unsigned long clear)
 {

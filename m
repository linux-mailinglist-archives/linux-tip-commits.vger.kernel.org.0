Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9CE1B9313
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Apr 2020 20:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDZSm5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 26 Apr 2020 14:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgDZSm4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 26 Apr 2020 14:42:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0763C061A0F;
        Sun, 26 Apr 2020 11:42:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEq-000792-7e; Sun, 26 Apr 2020 20:42:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E396A1C0178;
        Sun, 26 Apr 2020 20:42:47 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:47 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] xen/privcmd: Remove unneeded asm/tlb.h include
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092600.236617960@linutronix.de>
References: <20200421092600.236617960@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792656747.28353.1809641816673273005.tip-bot2@tip-bot2>
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

Commit-ID:     8a29204f3e97d626b3b3c4589d00fbee1c95444c
Gitweb:        https://git.kernel.org/tip/8a29204f3e97d626b3b3c4589d00fbee1c95444c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:42 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 18:51:19 +02:00

xen/privcmd: Remove unneeded asm/tlb.h include

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092600.236617960@linutronix.de
---
 drivers/xen/privcmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index c6070e7..b8ccb89 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -27,7 +27,6 @@
 
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
-#include <asm/tlb.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 

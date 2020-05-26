Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B89B1C8DA0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 May 2020 16:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEGOHz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 7 May 2020 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgEGOH1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 7 May 2020 10:07:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44220C05BD0A;
        Thu,  7 May 2020 07:07:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWhBL-00027e-3J; Thu, 07 May 2020 16:07:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BE6381C03AB;
        Thu,  7 May 2020 16:07:22 +0200 (CEST)
Date:   Thu, 07 May 2020 14:07:22 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Mark is_uv_hubless() static
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russ Anderson <rja@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200504171527.2845224-7-hch@lst.de>
References: <20200504171527.2845224-7-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158886044274.8414.7034570181169059963.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     e4dd8b8351264fb5bef30c0a77e4d171e0603d63
Gitweb:        https://git.kernel.org/tip/e4dd8b8351264fb5bef30c0a77e4d171e0603d63
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Mon, 04 May 2020 19:15:22 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 15:32:21 +02:00

x86/platform/uv: Mark is_uv_hubless() static

is_uv_hubless() is only used in x2apic_uv_x.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Not-acked-by:  Dimitri Sivanich <sivanich@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Link: https://lkml.kernel.org/r/20200504171527.2845224-7-hch@lst.de

---
 arch/x86/include/asm/uv/uv.h       | 2 --
 arch/x86/kernel/apic/x2apic_uv_x.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 45ea95c..ae587ce 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -31,7 +31,6 @@ static inline bool is_early_uv_system(void)
 }
 extern int is_uv_system(void);
 extern int is_uv_hubbed(int uvtype);
-extern int is_uv_hubless(int uvtype);
 extern void uv_cpu_init(void);
 extern void uv_nmi_init(void);
 extern void uv_system_init(void);
@@ -44,7 +43,6 @@ static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
 static inline bool is_early_uv_system(void)	{ return 0; }
 static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubbed(int uv)	{ return 0; }
-static inline int is_uv_hubless(int uv) { return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
 static inline const struct cpumask *
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index ad53b2a..cb07a98 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -385,11 +385,10 @@ int is_uv_hubbed(int uvtype)
 }
 EXPORT_SYMBOL_GPL(is_uv_hubbed);
 
-int is_uv_hubless(int uvtype)
+static int is_uv_hubless(int uvtype)
 {
 	return (uv_hubless_system & uvtype);
 }
-EXPORT_SYMBOL_GPL(is_uv_hubless);
 
 void **__uv_hub_info_list;
 EXPORT_SYMBOL_GPL(__uv_hub_info_list);

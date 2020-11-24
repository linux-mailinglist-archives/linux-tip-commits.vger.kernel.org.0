Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B532C294E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 15:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbgKXOU7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 09:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388716AbgKXOU6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 09:20:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFCDC0613D6;
        Tue, 24 Nov 2020 06:20:58 -0800 (PST)
Date:   Tue, 24 Nov 2020 14:20:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606227656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FgiPDPn5/dN5tzZ7TgXaESQTtLVV0v9UZSKhS8Qgyac=;
        b=N9XZNg4Ihi2pngfWg/vtN+kt/6GOX8BI/QHWE9TJfQpWc1+1Ebt/0I4B9ZRXA9TFc80cAa
        HwnRKoe0+TiYtyaAI2j5E1ULMfjW8HQPXxUsQgQUSUIWOdoUDv96Az0Ae8HRcvCee+vojw
        4DXz+z4MO1GUE1oCm2OFZFLKCJxdWSHopORTIfdlPVxS2hVBwAnlo2cFTO+M58QmOveoim
        Jx+6hHGEk+gJpM5cO5uYS0yqvnohKGnG8zD+nx+nytaJXSUj4Tl4zfctvWSdpMLR/Q13g9
        1/RwG1BuxaZNu4T1jy6TtYtc8TcprOsjXZRScR1ntPUi1QTJ6oRKO9pPf065PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606227656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FgiPDPn5/dN5tzZ7TgXaESQTtLVV0v9UZSKhS8Qgyac=;
        b=W6+XTMS3GvdFx4x+OFHPWIGYf237abLrEHq5vG6f+DmXwCDkVVEa/NzsZg1s4O7LDn9+Ti
        UsvbpnrcHxzicrDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] mm/highmem: Provide and use CONFIG_DEBUG_KMAP_LOCAL
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201118204006.869487226@linutronix.de>
References: <20201118204006.869487226@linutronix.de>
MIME-Version: 1.0
Message-ID: <160622765587.11115.373556851099869437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     6e799cb69a70eedbb41561b750f7180c12cff280
Gitweb:        https://git.kernel.org/tip/6e799cb69a70eedbb41561b750f7180c12cff280
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 18 Nov 2020 20:48:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Nov 2020 14:42:08 +01:00

mm/highmem: Provide and use CONFIG_DEBUG_KMAP_LOCAL

CONFIG_KMAP_LOCAL can be enabled by x86/32bit even if CONFIG_HIGHMEM is not
enabled for temporary MMIO space mappings.

Provide it as a seperate config option which depends on CONFIG_KMAP_LOCAL
and let CONFIG_DEBUG_HIGHMEM select it.

This won't increase the debug coverage of this significantly but it paves
the way to do so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201118204006.869487226@linutronix.de

---
 include/asm-generic/kmap_size.h | 2 +-
 lib/Kconfig.debug               | 8 ++++++++
 mm/highmem.c                    | 4 ++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/kmap_size.h b/include/asm-generic/kmap_size.h
index 9d6c778..6e36b24 100644
--- a/include/asm-generic/kmap_size.h
+++ b/include/asm-generic/kmap_size.h
@@ -3,7 +3,7 @@
 #define _ASM_GENERIC_KMAP_SIZE_H
 
 /* For debug this provides guard pages between the maps */
-#ifdef CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_KMAP_LOCAL
 # define KM_MAX_IDX	33
 #else
 # define KM_MAX_IDX	16
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c789b39..f24fa15 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -849,9 +849,17 @@ config DEBUG_PER_CPU_MAPS
 
 	  Say N if unsure.
 
+config DEBUG_KMAP_LOCAL
+	bool "Debug kmap_local temporary mappings"
+	depends on DEBUG_KERNEL && KMAP_LOCAL
+	help
+	  This option enables additional error checking for the kmap_local
+	  infrastructure.  Disable for production use.
+
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
+	select DEBUG_KMAP_LOCAL
 	help
 	  This option enables additional error checking for high memory
 	  systems.  Disable for production systems.
diff --git a/mm/highmem.c b/mm/highmem.c
index 78c481a..fab128d 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -368,10 +368,10 @@ EXPORT_SYMBOL(kunmap_high);
 static DEFINE_PER_CPU(int, __kmap_local_idx);
 
 /*
- * With DEBUG_HIGHMEM the stack depth is doubled and every second
+ * With DEBUG_KMAP_LOCAL the stack depth is doubled and every second
  * slot is unused which acts as a guard page
  */
-#ifdef CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_KMAP_LOCAL
 # define KM_INCR	2
 #else
 # define KM_INCR	1

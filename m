Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048502CF6F3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 23:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgLDWih (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 4 Dec 2020 17:38:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50420 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgLDWih (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 4 Dec 2020 17:38:37 -0500
Date:   Fri, 04 Dec 2020 22:37:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607121475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zeLJjnfiyGrS+TOiPdWO/gfwmOF8tgr2Ln30KOU+WXA=;
        b=Y066rbS90Q2BENcJIdbCExldS+hKevPkQXTql3ndQ5dBVemNl0JyI1mCLDO7HemMfNYZDX
        qL7FomDQtphPMjWoyUSnLN9Qq1xz2avBUNhFJIiLGPzToYs1yrgvG81qKRY4pRwqA5sFgn
        TenL3mZlgLlfVj/gjHaUJNkW7hYNAkAmBVbQqUIL9STcVz1/fGfBxpw+YEQlXDi+9YgeiB
        SDWZqqxupTP13G8ugFQOM4ZRhjNBZ80uxK9aoBkU6vQjJyU9Hj/wTxMvzuD+B3GGLbpBLR
        jgCisbEUNpH54lW4DJBwadI+y9bKWbOk77AV/r4XnkU4wwdNiV6fFhlFiuC3cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607121475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zeLJjnfiyGrS+TOiPdWO/gfwmOF8tgr2Ln30KOU+WXA=;
        b=OgqlYP6gKynQ0ibyaxZ6WFsEd7cRD63GFSwCTQrReyw+7Xngovu9avMVR25L0hL+P1Zc8d
        JtTSJA2d4Hu5TzDg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] ARM: highmem: Fix cache_is_vivt() reference
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201204165930.3877571-1-arnd@kernel.org>
References: <20201204165930.3877571-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <160712147309.3364.569335054792245058.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     68061c02bb295da4955f0d309b9459f0a7ba83dd
Gitweb:        https://git.kernel.org/tip/68061c02bb295da4955f0d309b9459f0a7ba83dd
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 04 Dec 2020 17:59:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Dec 2020 23:35:34 +01:00

ARM: highmem: Fix cache_is_vivt() reference

The reference to cache_is_vivt() was moved into a header file,
which now causes a build failure in rare randconfig builds:

arch/arm/include/asm/highmem.h:52:43: error: implicit declaration of function 'cache_is_vivt' [-Werror,-Wimplicit-function-declaration]

Add an explicit include to make it build reliably.

Fixes: 2a15ba82fa6c ("ARM: highmem: Switch to generic kmap atomic")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/20201204165930.3877571-1-arnd@kernel.org

---
 arch/arm/include/asm/highmem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index a41de52..b4b6622 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_HIGHMEM_H
 #define _ASM_HIGHMEM_H
 
+#include <asm/cachetype.h>
 #include <asm/fixmap.h>
 
 #define PKMAP_BASE		(PAGE_OFFSET - PMD_SIZE)

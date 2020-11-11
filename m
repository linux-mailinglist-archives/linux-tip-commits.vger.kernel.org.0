Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9065E2AF071
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 13:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKKMXE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 07:23:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37978 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgKKMXD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 07:23:03 -0500
Date:   Wed, 11 Nov 2020 12:22:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605097380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIqPjYYJfAb0E1+y40ZmCG9ZGL7udxK14w1qon3YJ8U=;
        b=c2qKni+eNIqXJgpzUny0BzLi3ChItBQelhUy2J1cIkfzEuK3nPNweh9YnfPhs8yS5Wxgha
        pxh6UJGzDksUgDrUh5SVYu/pK9aX7EBnaJUdM2cNGv0otGSVdmPcpsjFGZyozKp9MgDF+g
        iPUVUMgwgAtvHZrZoTKb7Tx+fQ8XbGomu/G7YgA5XFWFQYr+HTFoPUFrf8Ck2mppWYz4aU
        Fj6+6KaXfpnjiOBNppKZiYL5ozs/If9epu6LyNEci6bnbzW2mIghu/ptyZRm5Zcc2Yi87O
        e3IpmdI23UcRc9Jv4SaO+WltAzn/n+M75dv67UuJxA0Iw7MYNwyvFVvoT9hFkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605097380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIqPjYYJfAb0E1+y40ZmCG9ZGL7udxK14w1qon3YJ8U=;
        b=SxVQf1Vy2eUisW+uM3AHtoveupmK31subp23h2KsswpT4UER63wCo0MfA/TlzoBarzIF0S
        8/QIsYmuVXbm0QCA==
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform/uv: Drop last traces of uv_flush_tlb_others
Cc:     Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Mike Travis <mike.travis@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201109093653.2042-1-jslaby@suse.cz>
References: <20201109093653.2042-1-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <160509737932.11244.2434801428950537873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b2896458b850ec7cb69b054b195b4b399f7e1f22
Gitweb:        https://git.kernel.org/tip/b2896458b850ec7cb69b054b195b4b399f7e1f22
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Mon, 09 Nov 2020 10:36:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Nov 2020 13:16:51 +01:00

x86/platform/uv: Drop last traces of uv_flush_tlb_others

Commit 39297dde7390 ("x86/platform/uv: Remove UV BAU TLB Shootdown
Handler") removed uv_flush_tlb_others. Its declaration was removed also
from asm/uv/uv.h. But only for the CONFIG_X86_UV=y case. The inline
definition (!X86_UV case) is still in place.

So remove this implementation with everything what was added to support
uv_flush_tlb_others:
* include of asm/tlbflush.h
* forward declarations of struct cpumask, mm_struct, and flush_tlb_info

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mike Travis <mike.travis@hpe.com>
Acked-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20201109093653.2042-1-jslaby@suse.cz

---
 arch/x86/include/asm/uv/uv.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 172d3e4..648eb23 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -2,14 +2,8 @@
 #ifndef _ASM_X86_UV_UV_H
 #define _ASM_X86_UV_UV_H
 
-#include <asm/tlbflush.h>
-
 enum uv_system_type {UV_NONE, UV_LEGACY_APIC, UV_X2APIC};
 
-struct cpumask;
-struct mm_struct;
-struct flush_tlb_info;
-
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
 
@@ -44,10 +38,6 @@ static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubbed(int uv)	{ return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
-static inline const struct cpumask *
-uv_flush_tlb_others(const struct cpumask *cpumask,
-		    const struct flush_tlb_info *info)
-{ return cpumask; }
 
 #endif	/* X86_UV */
 

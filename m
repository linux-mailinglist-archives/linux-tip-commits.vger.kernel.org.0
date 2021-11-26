Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E2345F61B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Nov 2021 21:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhKZVBM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Nov 2021 16:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhKZU7L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Nov 2021 15:59:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33742C06174A;
        Fri, 26 Nov 2021 12:55:58 -0800 (PST)
Date:   Fri, 26 Nov 2021 20:55:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637960156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWG8u+VOdeVWUeJIxU7klJtFOqo3OGvVQ4jHKlMKvEo=;
        b=KQLcCkI9NwZjs4jwF8HX8SqS8EF70vPdu1V1s2W7arcVOwy8+mHtPaGFTX2b886PVOiGaU
        v4TSabE/A7b2gH+c1+QWbY2/FnN8V4/gmyYSloNdzF1BxCT0bvA5UXu8ujKhDMJ+7ljMaK
        dVPAX1bzB4Pd6mRaVhZ72dnQH9Mo6fxqVX9NZzYyG8dvWKY8trk9f3rdaMeQUXNbV6dYbC
        8PkN4d1UINcmtwARd2GTbnY1O3ZQ+iEXR2uhQvkq52E1L4wEJ8r/YkU7mELfxUilivhViy
        00l3Z/rEF1dfdS9xb44IaM/RxPAzgR1jHwRI+quSekTiOMFQmysT/CiWdPWs3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637960156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWG8u+VOdeVWUeJIxU7klJtFOqo3OGvVQ4jHKlMKvEo=;
        b=yR2wbB7QazzBhkiOhT6EE8eYzGB5jLhN+GeKjLEx/OGRV9N2eEi/ac9TR8gxCGqGiLgV/6
        TBRlXqaFgzVYK+DA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Fix sparc32/m68k/nds32 build regression
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211126095852.455492-1-arnd@kernel.org>
References: <20211126095852.455492-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <163796015486.11128.17847641744551445643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4e0d84634445ed550498d613a49ea8f6cfa5e66c
Gitweb:        https://git.kernel.org/tip/4e0d84634445ed550498d613a49ea8f6cfa5e66c
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 26 Nov 2021 10:58:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Nov 2021 21:50:36 +01:00

futex: Fix sparc32/m68k/nds32 build regression

The recent futex cleanup series, botched up a rename of some function
names, breaking sparc32, m68k and nds32:

include/asm-generic/futex.h:17:2: error: implicit declaration of function 'futex_atomic_cmpxchg_inatomic_local_generic'; did you mean 'futex_atomic_cmpxchg_inatomic_local'? [-Werror=implicit-function-declaration]

Fix the macros to point to the correct functions.

Fixes: 3f2bedabb62c ("futex: Ensure futex_atomic_cmpxchg_inatomic() is present")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20211126095852.455492-1-arnd@kernel.org

---
 include/asm-generic/futex.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 30e7fa6..66d6843 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -14,9 +14,9 @@
  *
  */
 #define futex_atomic_cmpxchg_inatomic(uval, uaddr, oldval, newval) \
-	futex_atomic_cmpxchg_inatomic_local_generic(uval, uaddr, oldval, newval)
+	futex_atomic_cmpxchg_inatomic_local(uval, uaddr, oldval, newval)
 #define arch_futex_atomic_op_inuser(op, oparg, oval, uaddr) \
-	arch_futex_atomic_op_inuser_local_generic(op, oparg, oval, uaddr)
+	futex_atomic_op_inuser_local(op, oparg, oval, uaddr)
 #endif /* CONFIG_SMP */
 #endif
 

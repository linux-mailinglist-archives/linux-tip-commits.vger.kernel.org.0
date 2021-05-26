Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AB43915FB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhEZL0i (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhEZL0O (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:14 -0400
Date:   Wed, 26 May 2021 11:24:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jDsdJmEDldDE8cVh+tv8BAnWDn/8Xs9dBcF9JNqWkgY=;
        b=V6eSuNyQ5mC39zznEVUJLJ9GekXHU4WiCMHz4vs6tAohW8l+rIB2d9O8wvMKV3DAI6sdDh
        0mW6RODrYONTTZAZY7LX84s/4rFUZeJJR3CCKeUiEtMeJTkgJsw37snlHpdoc014LWHEyF
        tJEcu3QCAdyIfYY1bE1iR2cB6b5D32nSIQkfTNO1oFuamDy8YdVSsoq+ZdujwEOf3h55b+
        oYJ4uqAivZs9RHAYrzuuwv3sxU8ZEwmKj6kGt6UttY7xJuS92+wApSxiATXDSp0ULXx64Y
        zs+eF4MO6KrFq8/uHPthYerlcv1iE7+EsWbLEWDuN5fFwO183AATq/GeGZSaIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jDsdJmEDldDE8cVh+tv8BAnWDn/8Xs9dBcF9JNqWkgY=;
        b=/CcCKw5Wzxchcjy3tPQKOiV+b3SIAQrUi6GQ8a6P79gpTUvQRgVHS59NfjtLcabNkFnhX/
        JzljtDDRoMfrJHAw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: openrisc: avoid asm-generic/atomic.h
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Stafford Horne <shorne@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-6-mark.rutland@arm.com>
References: <20210525140232.53872-6-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202828129.29796.17306997675358457890.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f0c7bf1b77c65c9a273207d228df27009f09ec0b
Gitweb:        https://git.kernel.org/tip/f0c7bf1b77c65c9a273207d228df27009f09ec0b
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:49 +02:00

locking/atomic: openrisc: avoid asm-generic/atomic.h

OpenRISC is the only architecture which uses asm-generic/atomic.h and
also provides its own implementation of some functions, requiring
ifdeferry in the asm-generic header. As OpenRISC provides the vast
majority of functions itself, it would be simpler overall if it also
provided the few functions it cribs from asm-generic.

This patch decouples OpenRISC from asm-generic/atomic.h. Subsequent
patches will simplify the asm-generic implementation and remove the now
unnecessary ifdeferry.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Stafford Horne <shorne@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-6-mark.rutland@arm.com
---
 arch/openrisc/include/asm/atomic.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/atomic.h b/arch/openrisc/include/asm/atomic.h
index b589fac..cb86970 100644
--- a/arch/openrisc/include/asm/atomic.h
+++ b/arch/openrisc/include/asm/atomic.h
@@ -121,6 +121,12 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 }
 #define atomic_fetch_add_unless	atomic_fetch_add_unless
 
-#include <asm-generic/atomic.h>
+#define atomic_read(v)			READ_ONCE((v)->counter)
+#define atomic_set(v,i)			WRITE_ONCE((v)->counter, (i))
+
+#include <asm/cmpxchg.h>
+
+#define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
+#define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
 
 #endif /* __ASM_OPENRISC_ATOMIC_H */

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE04395910
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 12:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhEaKmT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhEaKmS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 06:42:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA95CC061574;
        Mon, 31 May 2021 03:40:38 -0700 (PDT)
Date:   Mon, 31 May 2021 10:40:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622457637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3jwnFjWYCljd6HTUUvpzV3abLsxrSVkJDR93pm4ptvc=;
        b=dxKfmfYmfEc/Rq9Yzc6ppLQSXd323RKRvps3NNr0nD8/arcCTx0a0C199BVIhHZrTTw+bg
        Mva8hqvXbQ+nlvoY5jaGU9zvGzp0AyZbPieznJFlthYOYUHv52/mRbvzimUBDDLd2Iakfr
        uqeJWjy/9UyzibYkQwPzgXAqyhRQlz5/yDg9qScEVj1iMVarbc/CK9KAwORG4AEiGkmATa
        VevMzg31itLD8+jtrZWoVcAU/hInYPbw0F3vDy9Ub1WBr5y389C1yzako2NyrZbSRyaFA6
        dDQrNngkcZfoFIM+AbV8feHf72d+qPx8MJwV0IbLiOxx+g0qA8aDgczwRBnZXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622457637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3jwnFjWYCljd6HTUUvpzV3abLsxrSVkJDR93pm4ptvc=;
        b=yOHQVrItkP3H2P5SMYZpjWd3N/+feR3+exN+AFcvPMGgR4sDFB28vmKRu9TM447F6SnFXv
        J/IIf8MOo3MnicDg==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Reduce LOCKDEP dependency list
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210524224150.8009-1-rdunlap@infradead.org>
References: <20210524224150.8009-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <162245763616.29796.10655943833524944582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b8e00abe7d9fe21dd13609e2e3a707e38902b105
Gitweb:        https://git.kernel.org/tip/b8e00abe7d9fe21dd13609e2e3a707e38902b105
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Mon, 24 May 2021 15:41:50 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 31 May 2021 10:14:54 +02:00

locking/lockdep: Reduce LOCKDEP dependency list

Some arches (um, sparc64, riscv, xtensa) cause a Kconfig warning for
LOCKDEP.
These arch-es select LOCKDEP_SUPPORT but they are not listed as one
of the arch-es that LOCKDEP depends on.

Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
intend to have LOCKDEP support, replace the awkward list of
arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.

But wait. LOCKDEP_SUPPORT is included in LOCK_DEBUGGING_SUPPORT,
which is already a dependency here, so LOCKDEP_SUPPORT is redundant
and not needed.
That leaves the FRAME_POINTER dependency, but it is part of an
expression like this:
	depends on (A && B) && (FRAME_POINTER || B')
where B' is a dependency of B so if B is true then B' is true
and the value of FRAME_POINTER does not matter.
Thus we can also delete the FRAME_POINTER dependency.

Fixes this kconfig warning: (for um, sparc64, riscv, xtensa)

WARNING: unmet direct dependencies detected for LOCKDEP
  Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
  Selected by [y]:
  - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
  - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
  - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]

Fixes: 7d37cb2c912d ("lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/20210524224150.8009-1-rdunlap@infradead.org
---
 lib/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 678c139..1e1bd6f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1372,7 +1372,6 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select STACKTRACE
-	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1532232092
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Jul 2020 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgG2OeR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 29 Jul 2020 10:34:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgG2Odp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:45 -0400
Date:   Wed, 29 Jul 2020 14:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aV8nx+th7NLuR2IfErTA8iG2mepOL6W6/6gMb6gXMug=;
        b=2Hvze26dTucDYEKI+GlLF1kSsgNmXPh6N1v6E3NDMfrnOghq07DJC2CS8TtocaInFVIolO
        kLsIqLWuKslzkA8McCwlYRd1bWiAYikS8wqT3ddYwU/3VNr9U7Zi1uaf8s1P8QxFH8xww2
        IGXvBKuYRYhVCaWjfKHJV8FkTs3LT1JUSYFtAym0B0DLpV1OBUKSNDQmvLf9U1/fzxSXSv
        nfewvxqeZbmMm5wnwK9wyNlblplKASGYAXxhGJST/mlCPVhbbk+8dn8gTw5542OO+RDQWX
        RkNMiaFEkuNmIj9PMpHvL1/FyK0ud3ZaatGXv/fWk9Y6PcpwiYgHsh9YKN1w9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aV8nx+th7NLuR2IfErTA8iG2mepOL6W6/6gMb6gXMug=;
        b=g8HtMLht0KYHD8tA07DWn/2dp4jRJQyVweWJhEJ5uKRdvUDPDT/YeYah+bLlTk6psMvLdy
        T6MhYT/HOZ3CdcAA==
From:   "tip-bot2 for Herbert Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/qspinlock: Do not include atomic.h from
 qspinlock_types.h
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729123316.GC7047@gondor.apana.org.au>
References: <20200729123316.GC7047@gondor.apana.org.au>
MIME-Version: 1.0
Message-ID: <159603322338.4006.7046916264654721739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     459e39538e612b8dd130d34b93c9bfc89ecc836c
Gitweb:        https://git.kernel.org/tip/459e39538e612b8dd130d34b93c9bfc89ecc836c
Author:        Herbert Xu <herbert@gondor.apana.org.au>
AuthorDate:    Wed, 29 Jul 2020 22:33:16 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:19 +02:00

locking/qspinlock: Do not include atomic.h from qspinlock_types.h

This patch breaks a header loop involving qspinlock_types.h.
The issue is that qspinlock_types.h includes atomic.h, which then
eventually includes kernel.h which could lead back to the original
file via spinlock_types.h.

As ATOMIC_INIT is now defined by linux/types.h, there is no longer
any need to include atomic.h from qspinlock_types.h.  This also
allows the CONFIG_PARAVIRT hack to be removed since it was trying
to prevent exactly this loop.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/20200729123316.GC7047@gondor.apana.org.au
---
 include/asm-generic/qspinlock.h       | 1 +
 include/asm-generic/qspinlock_types.h | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index fde943d..2b26cd7 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -11,6 +11,7 @@
 #define __ASM_GENERIC_QSPINLOCK_H
 
 #include <asm-generic/qspinlock_types.h>
+#include <linux/atomic.h>
 
 /**
  * queued_spin_is_locked - is the spinlock locked?
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 56d1309..2fd1fb8 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -9,15 +9,7 @@
 #ifndef __ASM_GENERIC_QSPINLOCK_TYPES_H
 #define __ASM_GENERIC_QSPINLOCK_TYPES_H
 
-/*
- * Including atomic.h with PARAVIRT on will cause compilation errors because
- * of recursive header file incluson via paravirt_types.h. So don't include
- * it if PARAVIRT is on.
- */
-#ifndef CONFIG_PARAVIRT
 #include <linux/types.h>
-#include <linux/atomic.h>
-#endif
 
 typedef struct qspinlock {
 	union {

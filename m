Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47C43915F8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhEZL0h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54830 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbhEZL0N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:13 -0400
Date:   Wed, 26 May 2021 11:24:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028281;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbiKnn+SGtcVMX2rvQDz1xcrCbq8nTC6mKG3ufXSPMk=;
        b=s8DawyD2xxt8zGT5Zn287hJtWyTOPtzjT/ZyPKYiPUfc0u6Og8zQWdxf/PWLsYcV3XdOvf
        tPGUv478y+Qpgn2R86aRwIyAtOLYGYPzypA8K2y4NTGqb7Nl/PAC+8IwcLn6elK2ul2hnh
        dDwMDvAG4fpBrrM0cEXVKH2WvZy7XG6rl1Myx1Q3SvA+FNohkKtdfVTetcl/GK4CLZK85M
        9kb9MZWMtCTDJDx3wDl40ESQJL/gHc9jf7lhAGshbszndn48ryDA/z3N6Yr8gtM7JviPbf
        3Z71hqNxglXzLvL5Mh7GuGYF+jbWmc8BgVRUZnoETMSO2scAakp0muy2MJESBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028281;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbiKnn+SGtcVMX2rvQDz1xcrCbq8nTC6mKG3ufXSPMk=;
        b=4/o7tY1iCIqTSjSs14P2VrynZ2JYj5KoQFreJGThIRVv+hNLS38xw6P8EfOwQFCHdDi32P
        V1aeWsqigEkedlCQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: atomic: remove redundant include
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-8-mark.rutland@arm.com>
References: <20210525140232.53872-8-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202828040.29796.18228050500392173094.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     89eb78d542394a8461164009272ea654357795ad
Gitweb:        https://git.kernel.org/tip/89eb78d542394a8461164009272ea654357795ad
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:50 +02:00

locking/atomic: atomic: remove redundant include

Since commit:

  560cb12a4080a48b ("locking,arch: Rewrite generic atomic support")

... we conditionally include <linux/irqflags.h> before defining atomics
using locking, and hence do not need to do so unconditionally later in
the header.

This patch removes the redundant include.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-8-mark.rutland@arm.com
---
 include/asm-generic/atomic.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index ebacbc6..d4bf803 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -143,8 +143,6 @@ ATOMIC_OP(xor, ^)
 
 #define atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
 
-#include <linux/irqflags.h>
-
 static inline void atomic_add(int i, atomic_t *v)
 {
 	atomic_add_return(i, v);

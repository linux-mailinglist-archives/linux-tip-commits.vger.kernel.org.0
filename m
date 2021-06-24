Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4243B27FD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 08:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhFXGxy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 02:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhFXGxy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 02:53:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D020C061574;
        Wed, 23 Jun 2021 23:51:34 -0700 (PDT)
Date:   Thu, 24 Jun 2021 06:51:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624517490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpioRofhYh0J51xrqHhuSYUIndCDheEmxAqKZX5C/SU=;
        b=Jmwn3QnT7tvvDnc6hanxrdXqSpyzKXtedIYMp6Pb42vlpLE7v+aUIEUH3VY9kmhYFHzlTn
        GFQzw1sjRbJ+nZjmPu5a7gLHAiaLdSwTucHvh0xws/kZxBVQlMEbQif9yWJQiG/HQjS/iT
        ltOU4J+c89sp8IOZ4Qimzr2iEByQn8swwa/UCm4YfGuXj35x4Dtj4dgOsP3zodcZuOwbdx
        A0jKaveAsmMC29XWlXwUHFSD9K1TUVPzIXej88Bk6kN+osFl+6rvDHj1crJn3JmSlTw2cP
        9z5EqzWdapC465pkezLDwTjlfYB71yxlfxdG/dTsIQb00p2N9yIjzuWQjJ3hqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624517490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpioRofhYh0J51xrqHhuSYUIndCDheEmxAqKZX5C/SU=;
        b=Mjb4jFkx2P1KLsB+wss3Q+AVS7hfXgJCkrkBK0s/+Y+otnii8vt5u4LX6KZb/41SUPsTw+
        U191GkkSXCzpvRDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/lbr: Zero the xstate buffer on allocation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87wnr0wo2z.ffs@nanos.tec.linutronix.de>
References: <87wnr0wo2z.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <162451748975.395.431664255788607673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7f049fbdd57f6ea71dc741d903c19c73b2f70950
Gitweb:        https://git.kernel.org/tip/7f049fbdd57f6ea71dc741d903c19c73b2f70950
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Jun 2021 15:03:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Jun 2021 08:49:03 +02:00

perf/x86/intel/lbr: Zero the xstate buffer on allocation

XRSTORS requires a valid xstate buffer to work correctly. XSAVES does not
guarantee to write a fully valid buffer according to the SDM:

  "XSAVES does not write to any parts of the XSAVE header other than the
   XSTATE_BV and XCOMP_BV fields."

XRSTORS triggers a #GP:

  "If bytes 63:16 of the XSAVE header are not all zero."

It's dubious at best how this can work at all when the buffer is not zeroed
before use.

Allocate the buffers with __GFP_ZERO to prevent XRSTORS failure.

Fixes: ce711ea3cab9 ("perf/x86/intel/lbr: Support XSAVES/XRSTORS for LBR context switch")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/87wnr0wo2z.ffs@nanos.tec.linutronix.de
---
 arch/x86/events/intel/lbr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 4409d2c..e8453de 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -731,7 +731,8 @@ void reserve_lbr_buffers(void)
 		if (!kmem_cache || cpuc->lbr_xsave)
 			continue;
 
-		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
+		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache,
+							GFP_KERNEL | __GFP_ZERO,
 							cpu_to_node(cpu));
 	}
 }

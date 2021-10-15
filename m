Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9432242EDB3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbhJOJeH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:34:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48732 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhJOJeH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:34:07 -0400
Date:   Fri, 15 Oct 2021 09:31:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634290319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Weg1LdhN6auDFOvmx7V+oEKfFGy1pmCOyeqy13NuG6c=;
        b=GX1uQRSkdKRT10CCzQHGyyESIrjOQBTRlrQLjHxkWqbdy4VKEp3j8AOI/2QEk5oqPW17TL
        LFEMcVdV3UzenwpKBhnpy27NkIxNv58sor9/6TStCgnHJ3yVpvt3R/0xUKFVEuaGf2B51g
        WBBm0kJCov5kk0t3PElT1DQwpd0xx0FPOzf8xxkH+W6w4cHZMOURFXWt8I2tfmDdk80Sv4
        VtK02QHRELnOsTagB0DJMQJZA+IQ2Ds698w8rY8NFp6lmmWUQbuAayYkLZGpaT8w3smTeZ
        4umrFJ5d2tgZ2ITCbcV1Vt8mt9QCkzo1Fjcm43Nf7bQE9W2NDHMwtQSRi0rubg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634290319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Weg1LdhN6auDFOvmx7V+oEKfFGy1pmCOyeqy13NuG6c=;
        b=FSQoZ/eGScsVi6T3LJsdbXt3qZFCMWSKA1GDR8618d3CHaoiZ8n5sPwc/xG3yjnhsiLer4
        vuYCuMoi+X0oPNBw==
From:   "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Allow ftrace for functions in kernel/event/core.c
Cc:     Song Liu <songliubraving@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211006210732.2826289-1-songliubraving@fb.com>
References: <20211006210732.2826289-1-songliubraving@fb.com>
MIME-Version: 1.0
Message-ID: <163429031877.25758.14250260771490000006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     79df45731da68772d2285265864a52c900b8c65f
Gitweb:        https://git.kernel.org/tip/79df45731da68772d2285265864a52c900b8c65f
Author:        Song Liu <songliubraving@fb.com>
AuthorDate:    Wed, 06 Oct 2021 14:07:32 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:31 +02:00

perf/core: Allow ftrace for functions in kernel/event/core.c

It is useful to trace functions in kernel/event/core.c. Allow ftrace for
them by removing $(CC_FLAGS_FTRACE) from Makefile.

Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211006210732.2826289-1-songliubraving@fb.com
---
 kernel/events/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/events/Makefile b/kernel/events/Makefile
index 3c022e3..8591c18 100644
--- a/kernel/events/Makefile
+++ b/kernel/events/Makefile
@@ -1,10 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
-endif
-
 obj-y := core.o ring_buffer.o callchain.o
 
 obj-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
 obj-$(CONFIG_UPROBES) += uprobes.o
-

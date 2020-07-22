Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F632294AA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Jul 2020 11:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgGVJSC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Jul 2020 05:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgGVJSC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Jul 2020 05:18:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B66EC0619DC;
        Wed, 22 Jul 2020 02:18:02 -0700 (PDT)
Date:   Wed, 22 Jul 2020 09:17:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oo8r50qLqvjKH5n8Ub2QfbqssKW2iCjVsKcLXLGM2Xo=;
        b=fAb6KclgKmyWJHVQTPxp9J06uRw+0WaFfhAbHj3H9j4SIaVe7HKlDqLDwS8PZqgxoQ+koG
        zDosPaXY4l5C6zP7y72qMbFiZcefkotJ2KSuHnnUZLj+I/mrx2usmzijCtsItpFpInHdcn
        ZjGWnocSy2n3JKLz8D6akvM6ed4ymMHZwHA6IqVl5x+Dey4iIUaf4PJrJENPfxuE+Mm2YC
        SyratFlx+n9GtJ48u2fovfgAMluauGx+qpcngF8D4rdYw5qHksojSUPicY/iRSkbQCpW1j
        kVeZVoH62vyCIjgGao4AbUCd24BvMjZBDyN0H0IjmUHmLFJ+y2gvg8fu5GA0vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oo8r50qLqvjKH5n8Ub2QfbqssKW2iCjVsKcLXLGM2Xo=;
        b=tju98SwJsp1l4rt6reR4JqNXsf+ZbpRieeSrkxuacEPCB1qJdPbRM2NBeBQUgX7stuvBQj
        VzOYjqkqNcqNBXBw==
From:   "tip-bot2 for Hu Haowen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/perf: Fix a typo
Cc:     Hu Haowen <xianfengting221@163.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200719105007.57649-1-xianfengting221@163.com>
References: <20200719105007.57649-1-xianfengting221@163.com>
MIME-Version: 1.0
Message-ID: <159540947964.4006.18119324239142743514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2ac5413e5edca6910d2ae157187a889e94be2b62
Gitweb:        https://git.kernel.org/tip/2ac5413e5edca6910d2ae157187a889e94be2b62
Author:        Hu Haowen <xianfengting221@163.com>
AuthorDate:    Sun, 19 Jul 2020 18:50:07 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:08 +02:00

x86/perf: Fix a typo

The word "Zhoaxin" is incorrect and the right one is "Zhaoxin".

Signed-off-by: Hu Haowen <xianfengting221@163.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200719105007.57649-1-xianfengting221@163.com
---
 arch/x86/events/zhaoxin/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 898fa1a..e68827e 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Zhoaxin PMU; like Intel Architectural PerfMon-v2
+ * Zhaoxin PMU; like Intel Architectural PerfMon-v2
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

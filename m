Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B4A35B526
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhDKNp1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbhDKNoh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:37 -0400
Date:   Sun, 11 Apr 2021 13:43:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ay5XazQ4ibeeVsOIaYwZO2CfVJY2I2sThSDA13DZdAo=;
        b=RFGl4lyRNxAYeGAaVeTVoAM75RFEzhtnXwVFmcEFDM/aKrtNeAoGHAWoi5SELjzfx/RYlk
        iA43Slv/i/5WgDB2W9urfSkxVI0fYvdfJMlvB1NYHpSHFEyr5rL3DgnVPpKgWQpI/vfpKi
        hOVdK9yNHklRzuuaWNUhrz1k/hpiqpPfmEW/uZO0t/soiFlhp0ZciGXNGHh3G1rgop/V6h
        S+T+rMbRFTgM/olB3KcSuZ+da5/Qfv7tK97NwYSkkDH9DHyEo8N6mptRHr8gDSnA4gZwZO
        VeIiXNEARvPmmaIAx83MdecL7mB8oQNeUMI+DaCtTeW1qPGslh6VGzMeRYW+SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ay5XazQ4ibeeVsOIaYwZO2CfVJY2I2sThSDA13DZdAo=;
        b=7zCXUHKwYV/IGgu9z5RKpuAap9oOwBpxMF1DNCyWdnJGOubAmOeezy4OvLNVCMJUprtBdl
        RDkciJhbXBkwzzDw==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lib: bitmap: move ERANGE check from set_region to
 check_region
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862504.29796.7917241741632742689.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f3c869caef648c541a7445f2a6ba2196d343f542
Gitweb:        https://git.kernel.org/tip/f3c869caef648c541a7445f2a6ba2196d343f542
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Sun, 21 Feb 2021 03:08:24 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:16:58 -08:00

lib: bitmap: move ERANGE check from set_region to check_region

It makes sense to do all the checks in check_region() and not 1/2
in check_region and 1/2 in set_region.

Since set_region is called immediately after check_region, the net
effect on runtime is zero, but it gets rid of an if (...) return...

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/bitmap.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 162e285..833f152 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -500,17 +500,12 @@ struct region {
 	unsigned int nbits;
 };
 
-static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
+static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
 {
 	unsigned int start;
 
-	if (r->end >= r->nbits)
-		return -ERANGE;
-
 	for (start = r->start; start <= r->end; start += r->group_len)
 		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
-
-	return 0;
 }
 
 static int bitmap_check_region(const struct region *r)
@@ -518,6 +513,9 @@ static int bitmap_check_region(const struct region *r)
 	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
 		return -EINVAL;
 
+	if (r->end >= r->nbits)
+		return -ERANGE;
+
 	return 0;
 }
 
@@ -656,9 +654,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (ret)
 			return ret;
 
-		ret = bitmap_set_region(&r, maskp);
-		if (ret)
-			return ret;
+		bitmap_set_region(&r, maskp);
 	}
 
 	return 0;

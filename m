Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F2B35B52B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbhDKNpa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbhDKNoi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:38 -0400
Date:   Sun, 11 Apr 2021 13:43:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n0KW3WYhb6QsLSjHKX9Be/cGaE7AspMRiPms/hj+G60=;
        b=KG8kSpsFRph0kMle+JrEzXOT6aqNDPA1v6vMNglfyrCFs1MRrJ8Xc6bdTZkDtqyRz7L4eg
        Qc7zB32QQYGHoLEsAkXFwY8PhJPiOdbjQ4sZGsijdccLk2jhIV2Lt5eBKiqm588LHb6MiI
        iVLIJiTddYZ/AxtaTm1jGPWc9AbX5J3rSYxXXxmE63u2AgTPZx/GZpjFddE5eCc5OefL+B
        jbL/L07yUChTk7/ls7za71IKF36nYxyFcol4uM+IKULG3t+7dWi8h4mGCfdNg7cLUZd7dH
        b1i1WsnlUjWrSiJ+mKfaBv3UGgsElbLjR3LZINoGISNJJtfjNmkz5dFWLkx1ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n0KW3WYhb6QsLSjHKX9Be/cGaE7AspMRiPms/hj+G60=;
        b=Vd4iKgAOJwvQZmEzDW/E/7AE+k0eWy8rwsBNj0LheejvrNKrE0PCZU2dnyYTwLAiN6X+PS
        MsecrHGkpmjQKIBQ==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862649.29796.8589271530928859239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     494215fbf298787e4ead16e4c68634d241336b02
Gitweb:        https://git.kernel.org/tip/494215fbf298787e4ead16e4c68634d241336b02
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Sun, 21 Feb 2021 03:08:20 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:16:58 -08:00

lib: test_bitmap: clearly separate ERANGE from EINVAL tests.

This block of tests was meant to find/flag incorrect use of the ":"
and "/" separators (syntax errors) and invalid (zero) group len.

However they were specified with an 8 bit width and 32 bit operations,
so they really contained two errors (EINVAL and ERANGE).

Promote them to 32 bit so it is clear what they are meant to target.
Then we can add tests specific for ERANGE (no syntax errors, just
doing 32bit op on 8 bit width, plus a typical 9-on-8 fencepost error).

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/test_bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 0ea0e82..853a3a6 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -337,12 +337,12 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
-	{-EINVAL, "0-31:", NULL, 8, 0},
-	{-EINVAL, "0-31:0", NULL, 8, 0},
-	{-EINVAL, "0-31:0/", NULL, 8, 0},
-	{-EINVAL, "0-31:0/0", NULL, 8, 0},
-	{-EINVAL, "0-31:1/0", NULL, 8, 0},
-	{-EINVAL, "0-31:10/1", NULL, 8, 0},
+	{-EINVAL, "0-31:", NULL, 32, 0},
+	{-EINVAL, "0-31:0", NULL, 32, 0},
+	{-EINVAL, "0-31:0/", NULL, 32, 0},
+	{-EINVAL, "0-31:0/0", NULL, 32, 0},
+	{-EINVAL, "0-31:1/0", NULL, 32, 0},
+	{-EINVAL, "0-31:10/1", NULL, 32, 0},
 	{-EOVERFLOW, "0-98765432123456789:10/1", NULL, 8, 0},
 
 	{-EINVAL, "a-31", NULL, 8, 0},

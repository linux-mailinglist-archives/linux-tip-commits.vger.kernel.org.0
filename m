Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0385E35B529
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhDKNpa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33298 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbhDKNoi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:38 -0400
Date:   Sun, 11 Apr 2021 13:43:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sKXFKfobxhcmyD3R97AaWpUXq0Da9PtDztKL5ih1Jfc=;
        b=ykeTIdO9Mx1ftrCIqcEgPSaSvH4zozQJss9otH57c0/yxZAcgTY61Vt2Zpv41otHI6/mmk
        CZ2ZwzpckWvbVLnxqKzAvustPZF4YNrJEsn8/c1yTk2XGoNVoAWwt68zGW/ZvpISVC9l10
        YU85sQ+3mPzPeDvZ0FgYHeL0CXwpGGDZMPa1yZS9F9sA5onn10CwnGdcEMe7nhQF8MugLq
        tfm2gzLLmr2tz20Et3sZIQSB73Snnp4jmMXtAZbNsU1aUwool8gbpkAirmhPKiAhniSTGM
        07PP4f0KGjPcrdUaehzMxZ3jGF7TNJPuZO9aBoiDwO/pxgdP5vbxquGQZYKFFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sKXFKfobxhcmyD3R97AaWpUXq0Da9PtDztKL5ih1Jfc=;
        b=D0Ftz/DPffiLdiM3uj/4h+FesMaReGSEhXKufa2gc8+PwwNLjU67Yy3EGBIQyItvN62dNa
        9Jm4Jf9j2V/JDuDQ==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lib: test_bitmap: add tests to trigger ERANGE case.
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862614.29796.8505409915398576752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6fef5905fbd691aeb91093056b27d5ee7b106097
Gitweb:        https://git.kernel.org/tip/6fef5905fbd691aeb91093056b27d5ee7b106097
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Sun, 21 Feb 2021 03:08:21 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:16:58 -08:00

lib: test_bitmap: add tests to trigger ERANGE case.

Add tests that specify a valid range, but one that is outside the
width of the bitmap for which it is to be applied to.  These should
trigger an -ERANGE response from the code.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/test_bitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 853a3a6..0f2e91d 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -337,6 +337,8 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
+	{-ERANGE, "8-8", NULL, 8, 0},
+	{-ERANGE, "0-31", NULL, 8, 0},
 	{-EINVAL, "0-31:", NULL, 32, 0},
 	{-EINVAL, "0-31:0", NULL, 32, 0},
 	{-EINVAL, "0-31:0/", NULL, 32, 0},

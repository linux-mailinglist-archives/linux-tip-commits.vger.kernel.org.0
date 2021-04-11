Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2235B528
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhDKNp3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbhDKNoj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:39 -0400
Date:   Sun, 11 Apr 2021 13:43:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=09wnDwDv4CglDwqC+bT/K69nU7SLBvBX7va/zI4Pzr8=;
        b=IrmDTtXoeaNZtlO8/IN3486leuXIQMz26DI7qVQyVf90Znc4ejH4NfXJs8Ghr5zB7hq8D3
        k01t7uAPgGHeDtRs/AxAMK5dDfSbnRSobF+AmII6qSIygAtY3KMbHkKhVHZiDirO+8hlYs
        +Wa5zpJJcsP96/EM62VNi0/ml5r5aXVp/RH+7gCY+tcVsGnoLzxXgQgNwbJd3YnczWaX3C
        fgwMttwbuEkU9YsmYlNVSb+v57F5lQ0v1uENsqve7W/UDoZ8bMpWN8Um51PSSqxveQg6N/
        RanZxq7xNKOY8mulYrEB5Sb4U/BHFNlmqDtPH47UBTcx/AbFWwyLuEZxTd55AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=09wnDwDv4CglDwqC+bT/K69nU7SLBvBX7va/zI4Pzr8=;
        b=0nLsVyHq5Baq6O5a8yQG3EqK8ta3AWEGyJ0ZBk0qn7zRuqTpnGquyqjlkFPj9OPd6xv1Bv
        GLFjfJdrQQSKgACA==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lib: test_bitmap: add more start-end:offset/len tests
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862581.29796.12464218818779948094.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     97330db3af9a41302d1ccb0f495fcb5b5da2cc44
Gitweb:        https://git.kernel.org/tip/97330db3af9a41302d1ccb0f495fcb5b5da2cc44
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Sun, 21 Feb 2021 03:08:22 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:16:58 -08:00

lib: test_bitmap: add more start-end:offset/len tests

There are inputs to bitmap_parselist() that would probably never
be entered manually by a person, but might result from some kind of
automated input generator.  Things like ranges of length 1, or group
lengths longer than nbits, overlaps, or offsets of zero.

Adding these tests serve two purposes:

1) document what might seem odd but nonetheless valid input.

2) don't regress from what we currently accept as valid.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/test_bitmap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 0f2e91d..3c1c46d 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -34,6 +34,8 @@ static const unsigned long exp1[] __initconst = {
 	BITMAP_FROM_U64(0x3333333311111111ULL),
 	BITMAP_FROM_U64(0xffffffff77777777ULL),
 	BITMAP_FROM_U64(0),
+	BITMAP_FROM_U64(0x00008000),
+	BITMAP_FROM_U64(0x80000000),
 };
 
 static const unsigned long exp2[] __initconst = {
@@ -334,6 +336,26 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, " ,  ,,  , ,   ",		&exp1[12 * step], 8, 0},
 	{0, " ,  ,,  , ,   \n",		&exp1[12 * step], 8, 0},
 
+	{0, "0-0",			&exp1[0], 32, 0},
+	{0, "1-1",			&exp1[1 * step], 32, 0},
+	{0, "15-15",			&exp1[13 * step], 32, 0},
+	{0, "31-31",			&exp1[14 * step], 32, 0},
+
+	{0, "0-0:0/1",			&exp1[12 * step], 32, 0},
+	{0, "0-0:1/1",			&exp1[0], 32, 0},
+	{0, "0-0:1/31",			&exp1[0], 32, 0},
+	{0, "0-0:31/31",		&exp1[0], 32, 0},
+	{0, "1-1:1/1",			&exp1[1 * step], 32, 0},
+	{0, "0-15:16/31",		&exp1[2 * step], 32, 0},
+	{0, "15-15:1/2",		&exp1[13 * step], 32, 0},
+	{0, "15-15:31/31",		&exp1[13 * step], 32, 0},
+	{0, "15-31:1/31",		&exp1[13 * step], 32, 0},
+	{0, "16-31:16/31",		&exp1[3 * step], 32, 0},
+	{0, "31-31:31/31",		&exp1[14 * step], 32, 0},
+
+	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
+	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
+
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},

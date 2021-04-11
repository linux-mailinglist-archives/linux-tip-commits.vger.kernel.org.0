Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A9E35B521
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhDKNpV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33308 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbhDKNod (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:33 -0400
Date:   Sun, 11 Apr 2021 13:43:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1/oe+qF9ci/Qv8lPdZZXVbaWaLIHNiCcvNVI3l0hfwI=;
        b=MQG1C/qitEVlNsgo4OuBUk+YehRES1lcnLOs3+ee1dKlrq1qC9L94H+VN1kliIUmkDLZNd
        isdbwgGuZnUOrI+g8SXLJoMLM2z0sokgdhT2F+dKe0oxvbV+zyg8yBMnYDtW3v+g90CF9r
        eYd1x8KA6v6inWUa91C9IqTh+8dy3AfWg00vFGWIgbrypx/jRpJBD5Uqh4kFwvpgKd2mli
        O7pgVtOQRbNTmd9Z7huLNAy9LdYHVhSG4Ahzihmq8eYIkZwAFMkfh3lzYLsoOfYhdzVIJn
        3s8+Rt1FhqGS27CPaNOcicOr+vbsjxJs3+TbYapVEXHREdqfh+h0SFLezFR56w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1/oe+qF9ci/Qv8lPdZZXVbaWaLIHNiCcvNVI3l0hfwI=;
        b=CT5Ug/UxvAw82ruVm+MqkLOv+yL92MI6UocCBf5F9grLF3qdFN2BaOMZ2WWweV6vCYcYZ/
        pGrkLRhqDweUciDw==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lib: test_bitmap: add tests for "N" alias
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862437.29796.17178312480591525411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     99c58d1adbca25fb3ee2469bf0904e1e3e021f7e
Gitweb:        https://git.kernel.org/tip/99c58d1adbca25fb3ee2469bf0904e1e3e021f7e
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Sun, 21 Feb 2021 03:08:26 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:16:58 -08:00

lib: test_bitmap: add tests for "N" alias

These are copies of existing tests, with just 31 --> N.  This ensures
the recently added "N" alias transparently works in any normally
numeric fields of a region specification.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/test_bitmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 3c1c46d..9cd5755 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -353,6 +353,16 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, "16-31:16/31",		&exp1[3 * step], 32, 0},
 	{0, "31-31:31/31",		&exp1[14 * step], 32, 0},
 
+	{0, "N-N",			&exp1[14 * step], 32, 0},
+	{0, "0-0:1/N",			&exp1[0], 32, 0},
+	{0, "0-0:N/N",			&exp1[0], 32, 0},
+	{0, "0-15:16/N",		&exp1[2 * step], 32, 0},
+	{0, "15-15:N/N",		&exp1[13 * step], 32, 0},
+	{0, "15-N:1/N",			&exp1[13 * step], 32, 0},
+	{0, "16-N:16/N",		&exp1[3 * step], 32, 0},
+	{0, "N-N:N/N",			&exp1[14 * step], 32, 0},
+
+	{0, "0-N:1/3,1-N:1/3,2-N:1/3",		&exp1[8 * step], 32, 0},
 	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
 	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
 

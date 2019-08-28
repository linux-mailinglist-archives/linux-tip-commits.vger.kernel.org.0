Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61927A06F5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Aug 2019 18:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfH1QJI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Aug 2019 12:09:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47790 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfH1QJI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Aug 2019 12:09:08 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i30VK-0007jp-5u; Wed, 28 Aug 2019 18:09:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B20971C07D2;
        Wed, 28 Aug 2019 18:09:01 +0200 (CEST)
Date:   Wed, 28 Aug 2019 16:09:01 -0000
From:   tip-bot2 for Jonathan =?utf-8?q?Neusch=C3=A4fer?= 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/headers] asm-generic/div64: Fix documentation of do_div()
 parameter
Cc:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190808181948.27659-1-j.neuschaefer@gmx.net>
References: <20190808181948.27659-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Message-ID: <156700854151.17246.16442278167362869374.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/headers branch of tip:

Commit-ID:     e8e4eb0fbeda570b16464208aebf5caccfb6eb95
Gitweb:        https://git.kernel.org/tip/e8e4eb0fbeda570b16464208aebf5caccfb6eb95
Author:        Jonathan Neuschäfer <j.neuschaefer@gmx.net>
AuthorDate:    Thu, 08 Aug 2019 20:19:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 16:38:46 +02:00

asm-generic/div64: Fix documentation of do_div() parameter

Contrary to the description, the first parameter (n) should not be passed
as a pointer, but directly as an lvalue. This is possible because do_div() is
a macro.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lkml.kernel.org/r/20190808181948.27659-1-j.neuschaefer@gmx.net

---
 include/asm-generic/div64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index dc9726f..b2a9c74 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -28,12 +28,12 @@
 
 /**
  * do_div - returns 2 values: calculate remainder and update new dividend
- * @n: pointer to uint64_t dividend (will be updated)
+ * @n: uint64_t dividend (will be updated)
  * @base: uint32_t divisor
  *
  * Summary:
- * ``uint32_t remainder = *n % base;``
- * ``*n = *n / base;``
+ * ``uint32_t remainder = n % base;``
+ * ``n = n / base;``
  *
  * Return: (uint32_t)remainder
  *

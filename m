Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F712D8FAC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgLMTDu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:03:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgLMTBt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:49 -0500
Date:   Sun, 13 Dec 2020 19:01:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5pW5ktJOpAh7LRxTlPhPZrk11AHLeFguguD29rVQum8=;
        b=wBmkV5P3A9Mgp14Z0MhObf4jTzQ7oeqmjXK/lcitwQD3XPZSozyZAexYzsDWOhDT0g58jS
        kSnheN1mRO1kVDNR+vNgNdVMOEy3MzPKRH4RyUDrBZPfNLfvSquJtTDxrX4RnNIZIGmn9U
        xo3Brzxx0MQnDUGpTbDS+eaNnqxcKDxlXD8lddi3t9oxO26+30MRpG4oeElIRjUJZfquq4
        Ahd2Mm5KWPKDlM+wr3urSilWpX7IxDqxLw19V500ShDq0QHstDGTZARCApezlP65fnF96P
        aZ6fKEP5C3bXv/yMgFb48zDqnJod9HOz14Oc60bev/Qk2BiVRBrZs9G1uJ0bZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5pW5ktJOpAh7LRxTlPhPZrk11AHLeFguguD29rVQum8=;
        b=H7RQZfSpnyHZGclvz0fdghnP6kVmBlf1e6E22ULK1LlSxvEGLIk7eexbyQHDvB73JWzsIJ
        lB51On3Cmj+KiFBA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kcsan: Fix encoding masks and regain address bit
Cc:     Boqun Feng <boqun.feng@gmail.com>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606598.3364.11868178128580924231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1d094cefc37e5ed4dec44a41841c8628f6b548a2
Gitweb:        https://git.kernel.org/tip/1d094cefc37e5ed4dec44a41841c8628f6b548a2
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 06 Nov 2020 10:34:56 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:19:26 -08:00

kcsan: Fix encoding masks and regain address bit

The watchpoint encoding masks for size and address were off-by-one bit
each, with the size mask using 1 unnecessary bit and the address mask
missing 1 bit. However, due to the way the size is shifted into the
encoded watchpoint, we were effectively wasting and never using the
extra bit.

For example, on x86 with PAGE_SIZE==4K, we have 1 bit for the is-write
bit, 14 bits for the size bits, and then 49 bits left for the address.
Prior to this fix we would end up with this usage:

	[ write<1> | size<14> | wasted<1> | address<48> ]

Fix it by subtracting 1 bit from the GENMASK() end and start ranges of
size and address respectively. The added static_assert()s verify that
the masks are as expected. With the fixed version, we get the expected
usage:

	[ write<1> | size<14> |             address<49> ]

Functionally no change is expected, since that extra address bit is
insignificant for enabled architectures.

Acked-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/encoding.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 4f73db6..7ee4055 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -37,14 +37,12 @@
  */
 #define WATCHPOINT_ADDR_BITS (BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
 
-/*
- * Masks to set/retrieve the encoded data.
- */
-#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG-1)
-#define WATCHPOINT_SIZE_MASK                                                   \
-	GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS)
-#define WATCHPOINT_ADDR_MASK                                                   \
-	GENMASK(BITS_PER_LONG-3 - WATCHPOINT_SIZE_BITS, 0)
+/* Bitmasks for the encoded watchpoint access information. */
+#define WATCHPOINT_WRITE_MASK	BIT(BITS_PER_LONG-1)
+#define WATCHPOINT_SIZE_MASK	GENMASK(BITS_PER_LONG-2, WATCHPOINT_ADDR_BITS)
+#define WATCHPOINT_ADDR_MASK	GENMASK(WATCHPOINT_ADDR_BITS-1, 0)
+static_assert(WATCHPOINT_ADDR_MASK == (1UL << WATCHPOINT_ADDR_BITS) - 1);
+static_assert((WATCHPOINT_WRITE_MASK ^ WATCHPOINT_SIZE_MASK ^ WATCHPOINT_ADDR_MASK) == ~0UL);
 
 static inline bool check_encodable(unsigned long addr, size_t size)
 {

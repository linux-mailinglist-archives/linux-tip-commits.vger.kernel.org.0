Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFAE2D9015
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393505AbgLMTZs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:25:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46644 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbgLMTCH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:07 -0500
Date:   Sun, 13 Dec 2020 19:01:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fm919HA6z3Qd5B0TxTG9CLKYE9QxXvC0kQGRj5u5Ik8=;
        b=sIU0aSNiCceYAcdFlKMMmWyzM88whH4d25RRjbasJlWkyYB2PgJhhyyBdN2MoP56lKRsaO
        NbTzBiSTEqMGUUB1iEdPoE9+32ZFw45v+jpC/7OusnUGvFPsDrIX9PF3h9tstNi89kOopV
        0rQYIRuq0E9dfzXSNYJ2Hccops3/iF63KQ6Q0wf6s+rXhj1tbyTQHporcLXIEAEOnGOwkJ
        2PW/Dg/oT2dC7qHZKQQB3C/2dNhuoS3+XLjauV7uiBeEP2be1oqckA1nsuNbA0GnzmO0Mp
        7jvEBdkI5YzddiaMN8+5jsEQYZi6PlhJtG03LbO5zUFn8QEJeeBI9IPkxN8Kug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fm919HA6z3Qd5B0TxTG9CLKYE9QxXvC0kQGRj5u5Ik8=;
        b=XOeDiQAjPCOsF3ofOHjt8HOcx+1rGp372Vs/MDcl4+EZ3IKaXTBWeqtykS1LFOd5Yx9xNf
        HUSTn6Dd2TqMDrAA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kcsan: Never set up watchpoints on NULL pointers
Cc:     Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607496.3364.8957116259742592147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     55a2346c7ac4bbf6ee6972394237bf31e29a1c05
Gitweb:        https://git.kernel.org/tip/55a2346c7ac4bbf6ee6972394237bf31e29a1c05
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 22 Oct 2020 13:45:53 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:08:51 -08:00

kcsan: Never set up watchpoints on NULL pointers

Avoid setting up watchpoints on NULL pointers, as otherwise we would
crash inside the KCSAN runtime (when checking for value changes) instead
of the instrumented code.

Because that may be confusing, skip any address less than PAGE_SIZE.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/encoding.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 1a6db2f..4f73db6 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -48,7 +48,11 @@
 
 static inline bool check_encodable(unsigned long addr, size_t size)
 {
-	return size <= MAX_ENCODABLE_SIZE;
+	/*
+	 * While we can encode addrs<PAGE_SIZE, avoid crashing with a NULL
+	 * pointer deref inside KCSAN.
+	 */
+	return addr >= PAGE_SIZE && size <= MAX_ENCODABLE_SIZE;
 }
 
 static inline long

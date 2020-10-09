Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0874528845E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 10:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgJIH7r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:59:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732404AbgJIH6w (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:52 -0400
Date:   Fri, 09 Oct 2020 07:58:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OfMFievdgYLzl6eLIdTQO5+R3YV+CUngnH9ECZ73ZnY=;
        b=JuJQ6UhMeoG2O7Gj2Xk1EeMm+rS5XhS1e/st1RUDXIBddbTjByq2kEKGy/RrE/PlJ9XJV0
        a/kn2zkAFQkAsZpz22mb6oPMsFPB9huJ4cEf4E+cYuW5xQ6mjuCqXBm4e28b9HVJVAu2lk
        O6Qjm4jdVmYyvBPTH77Aye2CauwWKNMn+LMtVB+exPKx7iwgmMTdGUk1TUdxsefFrKdaoC
        ppuaH5fqB7/BbpnDEQW1K2tLLJNVpYvcyQRGd+uNUI4WJInXqAdeVo8b3g3fGAyCRlseCT
        xpjJ5pDQ0HEfJTgXTwo2Vy4hU9dnh4pJGXkXEEwkaP+7jCevaeTUL15BME5m3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OfMFievdgYLzl6eLIdTQO5+R3YV+CUngnH9ECZ73ZnY=;
        b=gcP9dOK4FuJ65wuC23RHiG4ebM2GFdDTKx7idx9S/lVppNbVljpxA8tIzx0z7J60gJk5ZX
        qsCGDRAkOtPdyVDA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] instrumented.h: Introduce read-write
 instrumentation hooks
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223033006.7002.5093134086871878631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     00047c2e6d7c576c1a847f7db07ef0fc58085f22
Gitweb:        https://git.kernel.org/tip/00047c2e6d7c576c1a847f7db07ef0fc58085f22
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 24 Jul 2020 09:00:06 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:09:58 -07:00

instrumented.h: Introduce read-write instrumentation hooks

Introduce read-write instrumentation hooks, to more precisely denote an
operation's behaviour.

KCSAN is able to distinguish compound instrumentation, and with the new
instrumentation we then benefit from improved reporting. More
importantly, read-write compound operations should not implicitly be
treated as atomic, if they aren't actually atomic.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/instrumented.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 43e6ea5..42faebb 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -43,6 +43,21 @@ static __always_inline void instrument_write(const volatile void *v, size_t size
 }
 
 /**
+ * instrument_read_write - instrument regular read-write access
+ *
+ * Instrument a regular write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_read_write(v, size);
+}
+
+/**
  * instrument_atomic_read - instrument atomic read access
  *
  * Instrument an atomic read access. The instrumentation should be inserted
@@ -73,6 +88,21 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 }
 
 /**
+ * instrument_atomic_read_write - instrument atomic read-write access
+ *
+ * Instrument an atomic read-write access. The instrumentation should be
+ * inserted before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_read_write(v, size);
+}
+
+/**
  * instrument_copy_to_user - instrument reads of copy_to_user
  *
  * Instrument reads from kernel memory, that are due to copy_to_user (and

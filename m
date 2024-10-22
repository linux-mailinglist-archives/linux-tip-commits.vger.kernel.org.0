Return-Path: <linux-tip-commits+bounces-2529-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD39AB918
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 23:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA77283CBB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 21:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C8B1CDA3F;
	Tue, 22 Oct 2024 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4hLrVi3G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zbl4QmoC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88E1CC8A2;
	Tue, 22 Oct 2024 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634036; cv=none; b=MJyeAGWCUQe2OaIt03D18mcaymK9IlLW3R3455FfnE6mv+08ghuKYhH0vvFyPJpKS61+AFiXiMBrJifd5vP+PSRdC14ZstbeU1lS1D1R714ET+Tx0cWJdP5dh4rvbU0AhUruF6Q5FrQ/cFL6DUHPulO4Uah7Fz05RPG+1EFzqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634036; c=relaxed/simple;
	bh=hjY+/lu8EVJ+1m0uPn9JCrZLa/7eq9aq0fhBB08d1+g=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=S5JlPOHMuddR+Ye4n8KC+cuLxnayM1bSSA3eZseIZ6ZAW6v8fUdOEBAHvTu3SrAI9bzc+IKuv9M2x+75FNHyiqrEeAPZmNjG5iiO5RjAM0jssU0I3IbdkwNfIVLpsbHNElKbPdLRmMhYwsV5VvJ8S5uveYok1Jp96H4w5DRyegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4hLrVi3G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zbl4QmoC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Oct 2024 21:53:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729634033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3puE0pFno6cL+c0sRLIONgF0Lx0ALshSvUsfsUgyNLQ=;
	b=4hLrVi3GxXwy6GW0mI4a+GXWqhVoqF8r5QQ1Egd+h2lXwauf2v0RnVejzv3tNpgtRv/d5S
	QPZ/Gl09gBNfo8P9tuWB03MfasHK19sCJAMN7El12k8E9gbUzt2geVz8I0y81Ap1tcbsQ8
	C0pmDCVgO9P6VSz29lX7CS52gxup9TDGu+IX/UpNZqUQAFgwY6RF2dbRYNHykhGO8uSdy6
	zGkqeUtd3yFbFnhJxZePo97E4WSABqXFPDKjk7M8RRcTEugRD+1HdFXkuHbWKIr97SNawf
	jnh3BpersZsRadvTAgw6Y+ZnWYDGtd1UtNgM2/FzV6E8B/D/OnDdovkLSn7vog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729634033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3puE0pFno6cL+c0sRLIONgF0Lx0ALshSvUsfsUgyNLQ=;
	b=zbl4QmoCv5eObG2/yrdp/vnMeHQoy+rk92J0MrC1EOpYMJoLjqx8lcVGdzYfGyfY8bDy9Z
	DKqzn1t37uyMtnBg==
From: "tip-bot2 for Ahmed Ehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/lockdep: Add a test for lockdep_set_subclass()
Cc: Ahmed Ehab <bottaawesome633@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172963403231.1442.6610755531326274395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5eadeb7b3bc206e2ac9494e9499e7c1f1e44eab7
Gitweb:        https://git.kernel.org/tip/5eadeb7b3bc206e2ac9494e9499e7c1f1e44eab7
Author:        Ahmed Ehab <bottaawesome633@gmail.com>
AuthorDate:    Thu, 05 Sep 2024 04:12:20 +03:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 17 Oct 2024 21:21:16 -07:00

locking/lockdep: Add a test for lockdep_set_subclass()

Add a test case to ensure that no new name string literal will be
created in lockdep_set_subclass(), otherwise a warning will be triggered
in look_up_lock_class(). Add this to catch the problem in the future.

[boqun: Reword the title, replace #if with #ifdef and rename functions
and variables]

Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/lkml/20240905011220.356973-1-bottaawesome633@gmail.com/
---
 lib/locking-selftest.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 6f6a5fc..6e0c019 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2710,6 +2710,43 @@ static void local_lock_3B(void)
 
 }
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static inline const char *rw_semaphore_lockdep_name(struct rw_semaphore *rwsem)
+{
+	return rwsem->dep_map.name;
+}
+#else
+static inline const char *rw_semaphore_lockdep_name(struct rw_semaphore *rwsem)
+{
+	return NULL;
+}
+#endif
+
+static void test_lockdep_set_subclass_name(void)
+{
+	const char *name_before = rw_semaphore_lockdep_name(&rwsem_X1);
+	const char *name_after;
+
+	lockdep_set_subclass(&rwsem_X1, 1);
+	name_after = rw_semaphore_lockdep_name(&rwsem_X1);
+	DEBUG_LOCKS_WARN_ON(name_before != name_after);
+}
+
+/*
+ * lockdep_set_subclass() should reuse the existing lock class name instead
+ * of creating a new one.
+ */
+static void lockdep_set_subclass_name_test(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | lockdep_set_subclass() name test|\n");
+	printk("  -----------------------------------\n");
+
+	print_testname("compare name before and after");
+	dotest(test_lockdep_set_subclass_name, SUCCESS, LOCKTYPE_RWSEM);
+	pr_cont("\n");
+}
+
 static void local_lock_tests(void)
 {
 	printk("  --------------------------------------------------------------------------\n");
@@ -2920,6 +2957,8 @@ void locking_selftest(void)
 	dotest(hardirq_deadlock_softirq_not_deadlock, FAILURE, LOCKTYPE_SPECIAL);
 	pr_cont("\n");
 
+	lockdep_set_subclass_name_test();
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;


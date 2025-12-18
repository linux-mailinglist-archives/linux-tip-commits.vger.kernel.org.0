Return-Path: <linux-tip-commits+bounces-7761-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ED2CCB446
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 10:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2930F3002290
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Dec 2025 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07062EF66E;
	Thu, 18 Dec 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="21R9CNKt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1px4zwO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482319D071;
	Thu, 18 Dec 2025 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051509; cv=none; b=a5YtqYyFubfRQy6o3DH8/mh2LjjfVP4bsUzrevrRGs3n22JFMxwMNHTwlFktY4T8+0zZEoWcqskBWYl3+C0p0ZxZum+/iJLoNZhvKZHfVo26Zx+MSNFU6GpyZ8S4uieWw8zabTOEgVZsRB9oBU06455ZvxGnVCbJ11oByy+Gi1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051509; c=relaxed/simple;
	bh=290QpyWDKDDtSpRxcQfOgMFc6jhglklNnrKHOGgEMmg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=igl3kr3/izo68YQ6+6/CZOBDvAYox8IIo/MaxBTAbLKw2NJ8pZ5ZCrjeumMfSD8Znq5gIe7PgQkz1WP7jPc46tFBYKwfdIIhrK2L85cwzvlrC7/ZdbGXLFBmqULVMnZFBZdyPo+KY7wh3Cp2bw6lzRGUABJ2AEofoGfoX+e8YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=21R9CNKt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a1px4zwO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Dec 2025 09:51:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766051506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfvQB0wKERGYsDIJNXVJw6dLs4+GOxTSkxdqacBPcxc=;
	b=21R9CNKtySzGLk12xS043ghDUcj77OaS60WNvuzKBAvOAZFx+jkIBw5UbRc3fcUNqAh/bt
	sMfYfEOrpqHHLqkwf2DFF9nHMgG1DHUE7+mwUqx/znxxsvkPOJCarpjQLziryi+hkYjlWC
	DJVpmPNOJmOl3rIEvvT2ULVFEzWPijeKvpcPBc6yMHOgKneTNI5kAL/n0v5aPLohBzffFM
	URZBgwbOZFs0W7AOW/ml9wBkmwaJjzSHglIaxrhx2lTy/DOiFJkl9yBXaxj2l1XvLA5Khe
	DYvroAVP7/qT9YayspEHY/t7y2jLlhssY7qKIruw5LczmxwpoIY8MGoiq/m8xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766051506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfvQB0wKERGYsDIJNXVJw6dLs4+GOxTSkxdqacBPcxc=;
	b=a1px4zwOEnJIg5PICs+vsZs2ZmizvclK5iPa4lOkQlFt5pXoClaRY4gMBYkgrXIyijXpgu
	+NpKaRW0e00BRHDg==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] test-ww_mutex: Allow test to be run (and re-run)
 from userland
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251205013515.759030-4-jstultz@google.com>
References: <20251205013515.759030-4-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176605150525.510.484339035995262588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     de2c5a1523fde38411b6259064258a0c0a3c896a
Gitweb:        https://git.kernel.org/tip/de2c5a1523fde38411b6259064258a0c0a3=
c896a
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Fri, 05 Dec 2025 01:35:11=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 18 Dec 2025 10:45:23 +01:00

test-ww_mutex: Allow test to be run (and re-run) from userland

In cases where the ww_mutex test was occasionally tripping on
hard to find issues, leaving qemu in a reboot loop was my best
way to reproduce problems. These reboots however wasted time
when I just wanted to run the test-ww_mutex logic.

So tweak the test-ww_mutex test so that it can be re-triggered
via a sysfs file, so the test can be run repeatedly without
doing module loads or restarting.

This has been particularly valuable to stressing and finding
issues with the proxy-exec series.

To use, run as root:
  echo 1 > /sys/kernel/test_ww_mutex/run_tests

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251205013515.759030-4-jstultz@google.com
---
 kernel/locking/test-ww_mutex.c | 51 +++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 30512b3..79b5e45 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -642,7 +642,7 @@ static int stress(struct ww_class *class, int nlocks, int=
 nthreads, unsigned int
 	return 0;
 }
=20
-static int __init run_tests(struct ww_class *class)
+static int run_tests(struct ww_class *class)
 {
 	int ncpus =3D num_online_cpus();
 	int ret, i;
@@ -684,7 +684,7 @@ static int __init run_tests(struct ww_class *class)
 	return 0;
 }
=20
-static int __init run_test_classes(void)
+static int run_test_classes(void)
 {
 	int ret;
=20
@@ -703,6 +703,36 @@ static int __init run_test_classes(void)
 	return 0;
 }
=20
+static DEFINE_MUTEX(run_lock);
+
+static ssize_t run_tests_store(struct kobject *kobj, struct kobj_attribute *=
attr,
+			       const char *buf, size_t count)
+{
+	if (!mutex_trylock(&run_lock)) {
+		pr_err("Test already running\n");
+		return count;
+	}
+
+	run_test_classes();
+	mutex_unlock(&run_lock);
+
+	return count;
+}
+
+static struct kobj_attribute run_tests_attribute =3D
+	__ATTR(run_tests, 0664, NULL, run_tests_store);
+
+static struct attribute *attrs[] =3D {
+	&run_tests_attribute.attr,
+	NULL,   /* need to NULL terminate the list of attributes */
+};
+
+static struct attribute_group attr_group =3D {
+	.attrs =3D attrs,
+};
+
+static struct kobject *test_ww_mutex_kobj;
+
 static int __init test_ww_mutex_init(void)
 {
 	int ret;
@@ -713,13 +743,30 @@ static int __init test_ww_mutex_init(void)
 	if (!wq)
 		return -ENOMEM;
=20
+	test_ww_mutex_kobj =3D kobject_create_and_add("test_ww_mutex", kernel_kobj);
+	if (!test_ww_mutex_kobj) {
+		destroy_workqueue(wq);
+		return -ENOMEM;
+	}
+
+	/* Create the files associated with this kobject */
+	ret =3D sysfs_create_group(test_ww_mutex_kobj, &attr_group);
+	if (ret) {
+		kobject_put(test_ww_mutex_kobj);
+		destroy_workqueue(wq);
+		return ret;
+	}
+
+	mutex_lock(&run_lock);
 	ret =3D run_test_classes();
+	mutex_unlock(&run_lock);
=20
 	return ret;
 }
=20
 static void __exit test_ww_mutex_exit(void)
 {
+	kobject_put(test_ww_mutex_kobj);
 	destroy_workqueue(wq);
 }
=20


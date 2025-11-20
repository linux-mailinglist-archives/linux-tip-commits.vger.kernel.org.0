Return-Path: <linux-tip-commits+bounces-7434-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7462AC76132
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 20:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4019D4E3281
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 19:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C062369979;
	Thu, 20 Nov 2025 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YIuqCCso";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cB/QfUYk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8135CB81;
	Thu, 20 Nov 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666581; cv=none; b=W6rI1ZS7bdpSypWh0jor8AgHC9MpOrOQfWYzMMPJyyvkSRf0XgX9hLjgwZzAsRw9uN5a9iBGc2W3Xcu2ocq1tkdPOHwBehVRnCzj7JiJRPoirbZNRZJUqt7Ign1GomfFAFwCSeh5RAXkrfl/guQT/CgTrpinl6u/ZX+F35cR68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666581; c=relaxed/simple;
	bh=IgDBqxlSzxNdHOME0MFkZaiwFPxfSP1Q4O70nEeMg7c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l9g2R3dzQpAlqoEO8t2fP003NcKgi3C+tz/wB8wK66RgZbuh+q9Jkcy1CWa+Ie/o0Faew7Q3JzNuWI+4nvj6XMS+L+GNL1Df5nt2vjw3cUxiOW9OPwuUdsoUHG9FJWj+mxsqFd5SjqOqbgnjj+MSVnkEGsnQnUJ7bclKa3AKsQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YIuqCCso; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cB/QfUYk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 19:22:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763666577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQJx370PE5Ef7gBMyyw0ySaqodI3WEMeabfSi0dizH4=;
	b=YIuqCCsorwlSYNCjEyrwLJrOFUqMUESqj6jxHNCd7eTcyAx5U4kNIvxcbsIsOTOsqV8P0i
	zcM4gqMgGcbK79Me8FImUU/uuBpMxsMrhz7UESxi0l0T6WIKgHGt6gL3NKVpWL/PaSiXCq
	ruDKhJytZAgGpnHIsYPc++Eqff3fh7hga27hJZ98dKVA7tbyEKwxTYU6V5O98m/NiXSP3e
	1urtamAPnRByXpG6upulbW3lHdoc6IiXzKMI532MmCtqEACT3ULD7ZrCiIQADShXfbIRUF
	VmJvZZA1ddwTJOOjv9f6aLmNWGLxsQMkguDs9cK4T7GBOlc3gOER30JeZQZMfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763666577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQJx370PE5Ef7gBMyyw0ySaqodI3WEMeabfSi0dizH4=;
	b=cB/QfUYkt7EqY3jaLNLUz+XJOH/VKoBQ5okNn7cmdQKXnQ6D7JVYj9afX5zSkRDqNABt0g
	B187snFuUMYGskCw==
From: "tip-bot2 for Gabriele Monaco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Add mask for CPUs available in
 the hierarchy
Cc: Gabriele Monaco <gmonaco@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251120145653.296659-3-gmonaco@redhat.com>
References: <20251120145653.296659-3-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176366657647.498.8525846014944836287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a048ca5f00ebd5a44f8551d546a3cd81fed7a204
Gitweb:        https://git.kernel.org/tip/a048ca5f00ebd5a44f8551d546a3cd81fed=
7a204
Author:        Gabriele Monaco <gmonaco@redhat.com>
AuthorDate:    Thu, 20 Nov 2025 15:56:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Nov 2025 20:17:31 +01:00

timers/migration: Add mask for CPUs available in the hierarchy

Keep track of the CPUs available for timer migration in a cpumask. This
prepares the ground to generalise the concept of unavailable CPUs.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251120145653.296659-3-gmonaco@redhat.com
---
 kernel/time/timer_migration.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 2cfebed..3325ca7 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -424,6 +424,12 @@ static struct tmigr_group *tmigr_root;
=20
 static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
=20
+/*
+ * CPUs available for timer migration.
+ * Protected by cpuset_mutex (with cpus_read_lock held) or cpus_write_lock.
+ */
+static cpumask_var_t tmigr_available_cpumask;
+
 #define TMIGR_NONE	0xFF
 #define BIT_CNT		8
=20
@@ -1433,6 +1439,7 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	int migrator;
 	u64 firstexp;
=20
+	cpumask_clear_cpu(cpu, tmigr_available_cpumask);
 	raw_spin_lock_irq(&tmc->lock);
 	tmc->available =3D false;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
@@ -1446,7 +1453,7 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	raw_spin_unlock_irq(&tmc->lock);
=20
 	if (firstexp !=3D KTIME_MAX) {
-		migrator =3D cpumask_any_but(cpu_online_mask, cpu);
+		migrator =3D cpumask_any(tmigr_available_cpumask);
 		work_on_cpu(migrator, tmigr_trigger_active, NULL);
 	}
=20
@@ -1461,6 +1468,7 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 	if (WARN_ON_ONCE(!tmc->tmgroup))
 		return -EINVAL;
=20
+	cpumask_set_cpu(cpu, tmigr_available_cpumask);
 	raw_spin_lock_irq(&tmc->lock);
 	trace_tmigr_cpu_available(tmc);
 	tmc->idle =3D timer_base_is_idle();
@@ -1805,6 +1813,11 @@ static int __init tmigr_init(void)
 	if (ncpus =3D=3D 1)
 		return 0;
=20
+	if (!zalloc_cpumask_var(&tmigr_available_cpumask, GFP_KERNEL)) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
 	/*
 	 * Calculate the required hierarchy levels. Unfortunately there is no
 	 * reliable information available, unless all possible CPUs have been


Return-Path: <linux-tip-commits+bounces-5945-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E890AEE1E2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71FE188DCF0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780B228C2A3;
	Mon, 30 Jun 2025 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QoFzX3Gw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mb07Q8pE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30FF28C87C;
	Mon, 30 Jun 2025 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295921; cv=none; b=LWJWv5b7gEpl0Gxe+crdFrQvtAsx+5P8CKj+Z+TcgPdEH3P2pETa7x10XqCwB5+Elx1WK1VPFkYdUtUOLX+ReBrCN6zfdx5uizXGn0edNrLEsr9vm346CtZHFJXyn13NVCRzlVWUAdw1S719QSrnPpo0L5ktV8FJOUvx59h/ml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295921; c=relaxed/simple;
	bh=mQzOLchImk2bOwbEyL2iPErb7HPGqFcQD6DOF2gHe+4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EGbqfh4C7Pc6iLjUnOKa2NXZFsPKeWzIAqhqR2dwlYiv3fUR6UeyWZkT1F4thixin8N/JF8DQwaUoORH3YDPsKXq5xzQETywM+F5WWnAKuU61u4GJF65csDUvZ21kJ7V2YcFgXYHYByq5ixaD2jbcQhOEhZBlpbP9guQnE6dtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QoFzX3Gw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mb07Q8pE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:05:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751295918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulmopkkY5tPveB3D3nqgmb3vzMs0sI/pYs9cKSWYOmM=;
	b=QoFzX3Gw/UwP2xSHRuUQ9jnyDEJubkkUUyN/3Eg6NHve885RVBgSY+aJ4Ylu9dn4kWawIh
	jI/5N0U129sFuzFeSmBX7v2QhoVIpx07FCnYzcnTA4h2fdTna8grgEp2Eh+ZpPz4ZM0u3f
	HxaKK4ZfMSO+l0NQADq51QqUp0lrIBOD6F9bEZNGxCUIZptL9slz6G9CHq6Y5/sfPHiDuf
	XhYoX/L4LJP9liniPo7xsk/H5PZcmy1rgqF7XMyk6MBGl+fqSE956yt8Bs58sbG8qB5kYV
	MRuYwUOUz6IgLR+oYi0GlcBRicWKFi1MNq41PQ7IooToA5yEVoMd/JoZx4aQ/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751295918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulmopkkY5tPveB3D3nqgmb3vzMs0sI/pYs9cKSWYOmM=;
	b=mb07Q8pEYWpPCtGht0z+S9THEPNp1PvOlCfOFqOKD5qkZeZueVv3Bv+EWDzTmbHNmiJIuD
	VukQkZkL/3vm4OAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] timekeeping: Provide interface to control auxiliary clocks
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250625183758.444626478@linutronix.de>
References: <20250625183758.444626478@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129591680.406.14184432653481182434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     7b95663a3d96b39b40f169dba5faef3e20163c5c
Gitweb:        https://git.kernel.org/tip/7b95663a3d96b39b40f169dba5faef3e20163c5c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Jun 2025 20:38:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 27 Jun 2025 20:13:13 +02:00

timekeeping: Provide interface to control auxiliary clocks

Auxiliary clocks are disabled by default and attempts to access them
fail.

Provide an interface to enable/disable them at run-time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250625183758.444626478@linutronix.de

---
 Documentation/ABI/stable/sysfs-kernel-time-aux-clocks |   5 +-
 kernel/time/timekeeping.c                             | 116 +++++++++-
 2 files changed, 121 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-kernel-time-aux-clocks

diff --git a/Documentation/ABI/stable/sysfs-kernel-time-aux-clocks b/Documentation/ABI/stable/sysfs-kernel-time-aux-clocks
new file mode 100644
index 0000000..825508f
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-kernel-time-aux-clocks
@@ -0,0 +1,5 @@
+What:		/sys/kernel/time/aux_clocks/<ID>/enable
+Date:		May 2025
+Contact:	Thomas Gleixner <tglx@linutronix.de>
+Description:
+		Controls the enablement of auxiliary clock timekeepers.
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 568ba1f..6a61887 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -6,6 +6,7 @@
 #include <linux/timekeeper_internal.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/kobject.h>
 #include <linux/percpu.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -2916,6 +2917,121 @@ const struct k_clock clock_aux = {
 	.clock_adj		= aux_clock_adj,
 };
 
+static void aux_clock_enable(clockid_t id)
+{
+	struct tk_read_base *tkr_raw = &tk_core.timekeeper.tkr_raw;
+	struct tk_data *aux_tkd = aux_get_tk_data(id);
+	struct timekeeper *aux_tks = &aux_tkd->shadow_timekeeper;
+
+	/* Prevent the core timekeeper from changing. */
+	guard(raw_spinlock_irq)(&tk_core.lock);
+
+	/*
+	 * Setup the auxiliary clock assuming that the raw core timekeeper
+	 * clock frequency conversion is close enough. Userspace has to
+	 * adjust for the deviation via clock_adjtime(2).
+	 */
+	guard(raw_spinlock_nested)(&aux_tkd->lock);
+
+	/* Remove leftovers of a previous registration */
+	memset(aux_tks, 0, sizeof(*aux_tks));
+	/* Restore the timekeeper id */
+	aux_tks->id = aux_tkd->timekeeper.id;
+	/* Setup the timekeeper based on the current system clocksource */
+	tk_setup_internals(aux_tks, tkr_raw->clock);
+
+	/* Mark it valid and set it live */
+	aux_tks->clock_valid = true;
+	timekeeping_update_from_shadow(aux_tkd, TK_UPDATE_ALL);
+}
+
+static void aux_clock_disable(clockid_t id)
+{
+	struct tk_data *aux_tkd = aux_get_tk_data(id);
+
+	guard(raw_spinlock_irq)(&aux_tkd->lock);
+	aux_tkd->shadow_timekeeper.clock_valid = false;
+	timekeeping_update_from_shadow(aux_tkd, TK_UPDATE_ALL);
+}
+
+static DEFINE_MUTEX(aux_clock_mutex);
+
+static ssize_t aux_clock_enable_store(struct kobject *kobj, struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	/* Lazy atoi() as name is "0..7" */
+	int id = kobj->name[0] & 0x7;
+	bool enable;
+
+	if (!capable(CAP_SYS_TIME))
+		return -EPERM;
+
+	if (kstrtobool(buf, &enable) < 0)
+		return -EINVAL;
+
+	guard(mutex)(&aux_clock_mutex);
+	if (enable == test_bit(id, &aux_timekeepers))
+		return count;
+
+	if (enable) {
+		aux_clock_enable(CLOCK_AUX + id);
+		set_bit(id, &aux_timekeepers);
+	} else {
+		aux_clock_disable(CLOCK_AUX + id);
+		clear_bit(id, &aux_timekeepers);
+	}
+	return count;
+}
+
+static ssize_t aux_clock_enable_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	unsigned long active = READ_ONCE(aux_timekeepers);
+	/* Lazy atoi() as name is "0..7" */
+	int id = kobj->name[0] & 0x7;
+
+	return sysfs_emit(buf, "%d\n", test_bit(id, &active));
+}
+
+static struct kobj_attribute aux_clock_enable_attr = __ATTR_RW(aux_clock_enable);
+
+static struct attribute *aux_clock_enable_attrs[] = {
+	&aux_clock_enable_attr.attr,
+	NULL
+};
+
+static const struct attribute_group aux_clock_enable_attr_group = {
+	.attrs = aux_clock_enable_attrs,
+};
+
+static int __init tk_aux_sysfs_init(void)
+{
+	struct kobject *auxo, *tko = kobject_create_and_add("time", kernel_kobj);
+
+	if (!tko)
+		return -ENOMEM;
+
+	auxo = kobject_create_and_add("aux_clocks", tko);
+	if (!auxo) {
+		kobject_put(tko);
+		return -ENOMEM;
+	}
+
+	for (int i = 0; i <= MAX_AUX_CLOCKS; i++) {
+		char id[2] = { [0] = '0' + i, };
+		struct kobject *clk = kobject_create_and_add(id, auxo);
+
+		if (!clk)
+			return -ENOMEM;
+
+		int ret = sysfs_create_group(clk, &aux_clock_enable_attr_group);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+late_initcall(tk_aux_sysfs_init);
+
 static __init void tk_aux_setup(void)
 {
 	for (int i = TIMEKEEPER_AUX_FIRST; i <= TIMEKEEPER_AUX_LAST; i++)


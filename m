Return-Path: <linux-tip-commits+bounces-5012-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FE4A8B942
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 14:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C94F3A6AFD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB6112B73;
	Wed, 16 Apr 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pICX4YUP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SbS1iyD9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE14184E;
	Wed, 16 Apr 2025 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806967; cv=none; b=LpniWbdg68DIG4YEpp4EZKukoDTLwUH+RbvNhFbVDzc4rPgo6FBc5/Iq9EpHof0AD42qf9N4bSheBvru+SfsxjCM7ihBmomhsRHgGYGJIHSmDA5wO1RnMPcfQkFXa8FiICpVSv49xuXrpI2CuUbyNAST4asDyEAB2j1ZABc6CiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806967; c=relaxed/simple;
	bh=TvApC/5l6pvC2pPspRF9sQoG0e7peI7KGS8JNhU2UvI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DLUnwXzt403YeZ87liyBAoyzRpniqu7BLSwk+CT5hGslWNqsbdfGA6RpASWeM/j5RgMLJzAUuSCs7uimt4euINIULN+Vl2AtOnWsbBb2jRR+DrBCEk8YxEpCq6aJKf9/Pp0AvHhLvPPGlt5OHjZOb104jEyyDDyStBp2Um00kCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pICX4YUP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SbS1iyD9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 12:35:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744806963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bk49rUt7CkKcnkTbwudAjUaLlrsAnz4lqjKfpIS5jIM=;
	b=pICX4YUP9WT+wARtfvI9jHwpmTPYLhe6c0TG5qQpcewqByyLDMgHJ2OMolsIXsVlfAruHi
	OaFsgYJuYHIWCxYYhRmE4W5umhW7po+cattAalotZYlva6VbSIowDyB+RRD9OADmH5iPWc
	T+ux7/FcSsiQIXrQDWJh/URGSHfjYcVchilwZQR2IxkdTe5OxJmmcdPgAFL7muyokp9ti4
	hc2cHc4QgClB5SIvBkAzVDGn3xWeTcS9NL85m+q36N+JDBgQEIA0qCBhk+c1SFRE1T7Hdi
	FVLd3N7t2aDnw7PpxlqMcKWaX6guQLKx2yzhKCulBPZJtcpMVjk0G8WFflDVlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744806963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bk49rUt7CkKcnkTbwudAjUaLlrsAnz4lqjKfpIS5jIM=;
	b=SbS1iyD9BbU8ccOAfdQ0OZg/8f2Bjwq9xBakS7iEWMmLrj4yXG3/IVrI4Q528RoGDGapPR
	TUt790tqVvjNE4DQ==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq/irqdesc: Use sysfs_emit() to instead of s*printf()
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250416101651.2128688-1-andriy.shevchenko@linux.intel.com>
References: <20250416101651.2128688-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174480694878.31282.6575062256835790467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     41c95ac4839401cb15e6c9a7756226f6af52ea49
Gitweb:        https://git.kernel.org/tip/41c95ac4839401cb15e6c9a7756226f6af52ea49
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Wed, 16 Apr 2025 13:16:51 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Apr 2025 14:25:41 +02:00

genirq/irqdesc: Use sysfs_emit() to instead of s*printf()

Follow the advice of the Documentation/filesystems/sysfs.rst that show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the value
to be returned to user space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250416101651.2128688-1-andriy.shevchenko@linux.intel.com

---
 kernel/irq/irqdesc.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4258cd6..4bcc6ff 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -257,11 +257,11 @@ static ssize_t per_cpu_count_show(struct kobject *kobj,
 	for_each_possible_cpu(cpu) {
 		unsigned int c = irq_desc_kstat_cpu(desc, cpu);
 
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%u", p, c);
+		ret += sysfs_emit_at(buf, ret, "%s%u", p, c);
 		p = ",";
 	}
 
-	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += sysfs_emit_at(buf, ret, "\n");
 	return ret;
 }
 IRQ_ATTR_RO(per_cpu_count);
@@ -273,10 +273,8 @@ static ssize_t chip_name_show(struct kobject *kobj,
 	ssize_t ret = 0;
 
 	raw_spin_lock_irq(&desc->lock);
-	if (desc->irq_data.chip && desc->irq_data.chip->name) {
-		ret = scnprintf(buf, PAGE_SIZE, "%s\n",
-				desc->irq_data.chip->name);
-	}
+	if (desc->irq_data.chip && desc->irq_data.chip->name)
+		ret = sysfs_emit(buf, "%s\n", desc->irq_data.chip->name);
 	raw_spin_unlock_irq(&desc->lock);
 
 	return ret;
@@ -291,7 +289,7 @@ static ssize_t hwirq_show(struct kobject *kobj,
 
 	raw_spin_lock_irq(&desc->lock);
 	if (desc->irq_data.domain)
-		ret = sprintf(buf, "%lu\n", desc->irq_data.hwirq);
+		ret = sysfs_emit(buf, "%lu\n", desc->irq_data.hwirq);
 	raw_spin_unlock_irq(&desc->lock);
 
 	return ret;
@@ -305,8 +303,7 @@ static ssize_t type_show(struct kobject *kobj,
 	ssize_t ret = 0;
 
 	raw_spin_lock_irq(&desc->lock);
-	ret = sprintf(buf, "%s\n",
-		      irqd_is_level_type(&desc->irq_data) ? "level" : "edge");
+	ret = sysfs_emit(buf, "%s\n", irqd_is_level_type(&desc->irq_data) ? "level" : "edge");
 	raw_spin_unlock_irq(&desc->lock);
 
 	return ret;
@@ -321,7 +318,7 @@ static ssize_t wakeup_show(struct kobject *kobj,
 	ssize_t ret = 0;
 
 	raw_spin_lock_irq(&desc->lock);
-	ret = sprintf(buf, "%s\n", str_enabled_disabled(irqd_is_wakeup_set(&desc->irq_data)));
+	ret = sysfs_emit(buf, "%s\n", str_enabled_disabled(irqd_is_wakeup_set(&desc->irq_data)));
 	raw_spin_unlock_irq(&desc->lock);
 
 	return ret;
@@ -337,7 +334,7 @@ static ssize_t name_show(struct kobject *kobj,
 
 	raw_spin_lock_irq(&desc->lock);
 	if (desc->name)
-		ret = scnprintf(buf, PAGE_SIZE, "%s\n", desc->name);
+		ret = sysfs_emit(buf, "%s\n", desc->name);
 	raw_spin_unlock_irq(&desc->lock);
 
 	return ret;
@@ -354,14 +351,13 @@ static ssize_t actions_show(struct kobject *kobj,
 
 	raw_spin_lock_irq(&desc->lock);
 	for_each_action_of_desc(desc, action) {
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
-				 p, action->name);
+		ret += sysfs_emit_at(buf, ret, "%s%s", p, action->name);
 		p = ",";
 	}
 	raw_spin_unlock_irq(&desc->lock);
 
 	if (ret)
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+		ret += sysfs_emit_at(buf, ret, "\n");
 
 	return ret;
 }


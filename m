Return-Path: <linux-tip-commits+bounces-1360-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4149027D0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Jun 2024 19:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF781C2191B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Jun 2024 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF6E14885B;
	Mon, 10 Jun 2024 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MXV81zes";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MGKd13y/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469D14387E;
	Mon, 10 Jun 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040951; cv=none; b=dBAxdFcH9Tjs6h57izuVDJGEqB9aOWQjigf22WMc8Ze+awKkKBWUqu6k2uI73KVRWuFLpCESxO/idAHcLSa4LmtyO7KFCX3j1HsIsH1ErDK3xcc/AgiDuenf5I5xfFhuCTGxroIAnfy1Vh09WcY7MqXcVIvPnpwPgnaVwKpmAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040951; c=relaxed/simple;
	bh=gXK6UKjolIGO1r7nMuHUNbiLA0oxODzI+Y/jnnEy/Nc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ChoCnKrPQU2nVXif1z5z4boipE3U9v97tZTSr6oacfXVTzTyU4e1skXQpMos77ocx9CVOSBx1+O+QDjSahWyt3xRUVqsqle8GF1mSXQAXOg5V97F+LOiJOJJJzs+k9tm+5mcnyeI+mL3R/XCtEDtrKR0j2m7+bB+ofQoKp2UN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MXV81zes; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MGKd13y/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Jun 2024 17:35:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718040946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyMEHJUJO6/qQiK5PKOLatV+tf3yfVA/JShwBLC1hfE=;
	b=MXV81zes9cPL3J6PYZ1UG3YCC+qI7OtLOKeix/zNzNWH2rvi5FJJ8QcRG9pl5OJABuYQeA
	OY7jNj3z3uUYTCEx7wVsyHxjuox7x1biG3jKnIo7JyFfQx0sXmD84HopcDNojhQriQxJrw
	9x1kg5znVXMPVe5pUb2VtZYr1o/S9rYdPxKJZKLmxawIC4Phh1WvrSyPTOPzn8i/lYrLG0
	HbWYNXAJbostBcvH4iShekBTW8qaDpkYlUtOlB5/4pcow/4W51bvEr6rpWpuxaw6Pzs1mQ
	Xfwb8tnj2Dz0YYQSm30f83dwOWYUQZQzdDq8CFsUY7xMLSDB+5GcwArr1UWS8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718040946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyMEHJUJO6/qQiK5PKOLatV+tf3yfVA/JShwBLC1hfE=;
	b=MGKd13y/ZkL09Z6G2d5TA92HaIrhP0qOrhvgQDm3Tt40BWw0P5TIhDEHoRVIKqu6BDoVxD
	/eB8eSQfLlw3vlCA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] cpu: Drop "extern" from function declarations in cpuhplock.h
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240610003927.341707-3-tony.luck@intel.com>
References: <20240610003927.341707-3-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171804094647.10875.12160602953473020955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ddefcfdeb5a2238cbcb07b80dda9ac3136735b1e
Gitweb:        https://git.kernel.org/tip/ddefcfdeb5a2238cbcb07b80dda9ac3136735b1e
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Sun, 09 Jun 2024 17:39:25 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 10 Jun 2024 08:50:05 +02:00

cpu: Drop "extern" from function declarations in cpuhplock.h

This file was created with a direct cut and paste from cpu.h so
kept the legacy declaration style.

But the Linux coding standard for function declarations in header
files is to avoid use of "extern".

Drop "extern" from all function declarations.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240610003927.341707-3-tony.luck@intel.com
---
 include/linux/cpuhplock.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/cpuhplock.h b/include/linux/cpuhplock.h
index 386abc4..431560b 100644
--- a/include/linux/cpuhplock.h
+++ b/include/linux/cpuhplock.h
@@ -15,18 +15,18 @@ struct device;
 extern int lockdep_is_cpus_held(void);
 
 #ifdef CONFIG_HOTPLUG_CPU
-extern void cpus_write_lock(void);
-extern void cpus_write_unlock(void);
-extern void cpus_read_lock(void);
-extern void cpus_read_unlock(void);
-extern int  cpus_read_trylock(void);
-extern void lockdep_assert_cpus_held(void);
-extern void cpu_hotplug_disable(void);
-extern void cpu_hotplug_enable(void);
+void cpus_write_lock(void);
+void cpus_write_unlock(void);
+void cpus_read_lock(void);
+void cpus_read_unlock(void);
+int  cpus_read_trylock(void);
+void lockdep_assert_cpus_held(void);
+void cpu_hotplug_disable(void);
+void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
 int remove_cpu(unsigned int cpu);
 int cpu_device_down(struct device *dev);
-extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
+void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
 
 #else /* CONFIG_HOTPLUG_CPU */
 


Return-Path: <linux-tip-commits+bounces-2198-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E65F96FB9A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 20:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBBF1C21B45
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF111D7E54;
	Fri,  6 Sep 2024 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z6Lx2ULn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VPrsC2E6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A21D45F4;
	Fri,  6 Sep 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649020; cv=none; b=jjT2nNLGcCJEsEp29zbswpYTDHTXE5OJH2HkQXlRrZkA8mEHOw4ACPiugbx/QCrORAPbCNUnbOSgBN3KmQ+0RmRDoaw8Qy5QVLATgItJRVs8YR/3GIy5OXx/wMIyH54iZCfl3ieZMykCNJfcfpXhDNRtHxkahf0YCsbhkHJYHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649020; c=relaxed/simple;
	bh=tjyjKjjGV2fKHmH/VlitYgBEaaP+NPrNNdrQt4zChOk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MGYx2VeKzvYA2cE5+Tf+DZ0rQysn/r6LZqncHQ/QuJh8WxSL48hJnNqDb/U2daJF9xIEAI+Ac1u0F2s2Wr7QpnhFGK4aDQKdME0/Vd2EmpxAVSioM+T+3NDWAkwLTPQuGS8b69ZSx4NZ7ksYIc1xsA8yriULokFPBSgXa9eroNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z6Lx2ULn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VPrsC2E6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 18:56:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725649017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9k6RaU8sN7T1aSQ8kMcme/dyBOO8jvLYXk1DETSxtDo=;
	b=z6Lx2ULngDYhytrkOb89T5BB7fUP5SgEdLcE9fJI64m0trRW11VkunpL6/mmCEwY/2Hrws
	9SN3M/8sugr9MwoIIXxgVi/u0nqiPFH/jPH9Yq6YgmiNbYZ27SWVfW8wTfU2pKdH4SVkrH
	uZMTRieZX2eBCPeGEfMr+vWaeW901UIer7ZgLicbETYQ8h1MjSdGL7Qk+LF6CxfnsG3yZr
	T35uvbPl1wLl/KUfp8lzYVhg9HoRZjEjUNF+o0ArVx3+HvO6VPYtmloj9Vbt5E1I8yeBKK
	S5PnjX5eLKZO/eIa7mEIKHmiTANwJdZWU4c35G3Jtjv5PtDO1JkNJ5adco8wYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725649017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9k6RaU8sN7T1aSQ8kMcme/dyBOO8jvLYXk1DETSxtDo=;
	b=VPrsC2E6GJYi96JUmcQWG1QjC9m7y8dnB318IGxT3mDhGTMIq1+QV6Z+7kP7j1xHa4LVmR
	+B1d3i7Zh0+S30Aw==
From: "tip-bot2 for Marek Maslanka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: acpi_pm: Add external callback for
 suspend/resume
Cc: Marek Maslanka <mmaslanka@google.com>, Hans de Goede <hdegoede@redhat.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240812184150.1079924-1-mmaslanka@google.com>
References: <20240812184150.1079924-1-mmaslanka@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172564901698.2215.10662638029174861474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     56bd72e9cd8272687aa2a8eccddabc5526cd7845
Gitweb:        https://git.kernel.org/tip/56bd72e9cd8272687aa2a8eccddabc5526cd7845
Author:        Marek Maslanka <mmaslanka@google.com>
AuthorDate:    Mon, 12 Aug 2024 18:41:42 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 06 Sep 2024 14:49:20 +02:00

clocksource: acpi_pm: Add external callback for suspend/resume

Provides the capability to register an external callback for the ACPI PM
timer, which is called during the suspend and resume processes.

Signed-off-by: Marek Maslanka <mmaslanka@google.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240812184150.1079924-1-mmaslanka@google.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/acpi_pm.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/acpi_pmtmr.h    | 13 +++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 8233877..b4330a0 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -25,6 +25,10 @@
 #include <asm/io.h>
 #include <asm/time.h>
 
+static void *suspend_resume_cb_data;
+
+static void (*suspend_resume_callback)(void *data, bool suspend);
+
 /*
  * The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
@@ -58,6 +62,32 @@ u32 acpi_pm_read_verified(void)
 	return v2;
 }
 
+void acpi_pmtmr_register_suspend_resume_callback(void (*cb)(void *data, bool suspend), void *data)
+{
+	suspend_resume_callback = cb;
+	suspend_resume_cb_data = data;
+}
+EXPORT_SYMBOL_GPL(acpi_pmtmr_register_suspend_resume_callback);
+
+void acpi_pmtmr_unregister_suspend_resume_callback(void)
+{
+	suspend_resume_callback = NULL;
+	suspend_resume_cb_data = NULL;
+}
+EXPORT_SYMBOL_GPL(acpi_pmtmr_unregister_suspend_resume_callback);
+
+static void acpi_pm_suspend(struct clocksource *cs)
+{
+	if (suspend_resume_callback)
+		suspend_resume_callback(suspend_resume_cb_data, true);
+}
+
+static void acpi_pm_resume(struct clocksource *cs)
+{
+	if (suspend_resume_callback)
+		suspend_resume_callback(suspend_resume_cb_data, false);
+}
+
 static u64 acpi_pm_read(struct clocksource *cs)
 {
 	return (u64)read_pmtmr();
@@ -69,6 +99,8 @@ static struct clocksource clocksource_acpi_pm = {
 	.read		= acpi_pm_read,
 	.mask		= (u64)ACPI_PM_MASK,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend	= acpi_pm_suspend,
+	.resume		= acpi_pm_resume,
 };
 
 
diff --git a/include/linux/acpi_pmtmr.h b/include/linux/acpi_pmtmr.h
index 50d88bf..0ded922 100644
--- a/include/linux/acpi_pmtmr.h
+++ b/include/linux/acpi_pmtmr.h
@@ -26,6 +26,19 @@ static inline u32 acpi_pm_read_early(void)
 	return acpi_pm_read_verified() & ACPI_PM_MASK;
 }
 
+/**
+ * Register callback for suspend and resume event
+ *
+ * @cb Callback triggered on suspend and resume
+ * @data Data passed with the callback
+ */
+void acpi_pmtmr_register_suspend_resume_callback(void (*cb)(void *data, bool suspend), void *data);
+
+/**
+ * Remove registered callback for suspend and resume event
+ */
+void acpi_pmtmr_unregister_suspend_resume_callback(void);
+
 #else
 
 static inline u32 acpi_pm_read_early(void)


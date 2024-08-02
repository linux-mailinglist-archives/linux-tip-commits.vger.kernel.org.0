Return-Path: <linux-tip-commits+bounces-1921-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35688945F57
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 16:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D4F1C210F2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 14:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2521200101;
	Fri,  2 Aug 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Plvjn0rD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NHRF9nan"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558B11EA0DD;
	Fri,  2 Aug 2024 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608755; cv=none; b=ewaWlH3v1n2+ORD0Lv4M+Q2UX6pmssRU5kls+HX8pNJvgGKRy0XvXxJbCr9YsvLTn1PSDwkPYR2h2A9rU4qDoZfL+4L9VxYMIveXPDR1CoJAJAMXpJt/Z+VbgltUNfb89wEyVPxh/Jd8tta/5UyTOBJGnqp7psTNiwxWzrxmWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608755; c=relaxed/simple;
	bh=jWTWEyRNkxk/S1IibP8pRwQRXZrOKpl1XbB/SMOtiJY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sDoZPU7PYnVbJUc1HzJKSfAl/cadQEsAfTW3aU8kez4harWZAFM8pqPNOqvT7OM/jP+eFSCMQu2TxT7xD9yehf9j4V1ldgPkn15wAwmXljRWNU8FRcMbYjZLNrDOlWQB20NRlzg0THbz09sACgSSKcKMzdp/ssxSKRz9wWUdf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Plvjn0rD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NHRF9nan; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 14:25:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722608752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mmx9ryYXVLd79Enh6gIA0KUB0N7OxBQz24eHx8sPb0Y=;
	b=Plvjn0rDVJJYPleQCnXn+phCUmCRR9VuEPfHlT4V6WTrKtR76Y9lBj83P4E60L1feUirIH
	mgEx1XkQ8JrKUVvAtfqjGnkdO/Bqx7qJNhF6aVnUEI9Rjb5hUEguxBY9UKwmtP8bjjnVei
	kqtBye3AkNIEfAShH2SXNUjx4oaNl0toOklj1PbJtcIV+ysli2w75NCkIxCYN57a67VDJv
	JFZNY1wC6ezMhbMsqEMoFrKgH6ltGkmUSuKHscli15WNjXYDN0q4sq3FLH8DV5362pmfJw
	r4IVkpmFnCLLQZtgtqsqKRJmuknShmmbdZeitX/xVBygCKUoZ6RsUVKr2pbdcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722608752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mmx9ryYXVLd79Enh6gIA0KUB0N7OxBQz24eHx8sPb0Y=;
	b=NHRF9nan+XMzwJzKiIeJccTSILbCUdr+2IKnRxZbkPmicU0AizygPaH6z9D4WWOydIgL6A
	Y7qQO3lza4uMw/Bg==
From: "tip-bot2 for Jiaxun Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: smp/core] cpu/hotplug: Make HOTPLUG_PARALLEL independent of HOTPLUG_SMT
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716-loongarch-hotplug-v3-1-af59b3bb35c8@flygoat.com>
References: <20240716-loongarch-hotplug-v3-1-af59b3bb35c8@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172260875222.2215.17271320395978189545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     c0e81a455e23f77683178b8ae32651df5841f065
Gitweb:        https://git.kernel.org/tip/c0e81a455e23f77683178b8ae32651df5841f065
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Tue, 16 Jul 2024 22:14:58 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 16:06:36 +02:00

cpu/hotplug: Make HOTPLUG_PARALLEL independent of HOTPLUG_SMT

Provide stub functions for SMT related parallel bring up functions so that
HOTPLUG_PARALLEL can work without HOTPLUG_SMT.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240716-loongarch-hotplug-v3-1-af59b3bb35c8@flygoat.com

---
 kernel/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1209dda..c89e0e9 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1808,6 +1808,7 @@ static int __init parallel_bringup_parse_param(char *arg)
 }
 early_param("cpuhp.parallel", parallel_bringup_parse_param);
 
+#ifdef CONFIG_HOTPLUG_SMT
 static inline bool cpuhp_smt_aware(void)
 {
 	return cpu_smt_max_threads > 1;
@@ -1817,6 +1818,16 @@ static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
 {
 	return cpu_primary_thread_mask;
 }
+#else
+static inline bool cpuhp_smt_aware(void)
+{
+	return false;
+}
+static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
+{
+	return cpu_none_mask;
+}
+#endif
 
 /*
  * On architectures which have enabled parallel bringup this invokes all BP


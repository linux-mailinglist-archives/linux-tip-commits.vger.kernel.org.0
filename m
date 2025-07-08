Return-Path: <linux-tip-commits+bounces-6025-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC10AFC7C9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9F54837AA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C1426B760;
	Tue,  8 Jul 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w5mWwz3c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqkmlEcn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F826AAAA;
	Tue,  8 Jul 2025 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969043; cv=none; b=h/8mJa3XKjzY73isgvOO9TwAEaS50p0P0WpjF9ksO866l0OOOr9rOZDKj3g2Na+I8uFnWNl/eO5end/5ng9Po7LoZipw5IApWVGIh83lS4vCj2y009sxBRJpmOJ/6VXgaMlgSBn813VYvXQqaeMHc53fhhkaYjnXuJSY+oUyWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969043; c=relaxed/simple;
	bh=j3w+thcum+Z0vWxOQPaAHWKTdHtE7Gt76Ukvxs0xZVE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wrqv5Uq2Ez8cbOrQZhwCf9M82xTmZw934xiwQ0PPDIGvh2Q9F544QL7EesGyvUyujfNmZYgbtZECYgMoycpOsXvjjlmAuUcZm0KQk/IDRMoVhRd5GmEfHIWju7F5hrB/jX6ZiM7wqckbPfTRIl8+nmWINACqERu9kH6v+njtQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w5mWwz3c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqkmlEcn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:03:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aI/BTmBU9NH+TTI8f6sMKob7Hsp9G/L3OokCtezix4A=;
	b=w5mWwz3cPbaS5cCh480xp335a5y2wlbCkLGHoyU5c2BuW+YTJTpKy4HurbCufiU62wDwxG
	YfbCy5fRBKlPVlzSHiiX7NHQiod/3DNkZ/7vMqTyXWl5sMtThwBVZ7xzDB9Xmzec2xjBGw
	y+lRTxGJYkEaQ8FBnj87xcYABTOvIgwFwxKuN/dy5vA3EauKFvmYyz7ZUqBBJKqZfl9Ppl
	ZR6nYFn6weTH5hzUqVl9diglQBipeHcDV/2IZn6CQba+kmEZkrXRryJZ6BGDrzZWrGws1d
	M23WI/KSps0qG6r2QsgyNjmpszJ9x4NLFGEM29Tz2xrof/hQ7OTNpSaaI7Swyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aI/BTmBU9NH+TTI8f6sMKob7Hsp9G/L3OokCtezix4A=;
	b=LqkmlEcnlqdj42lz3P77tdROI3haVOmwHepnPUcpb71vMbVtyiCTl+90/XyFufZPPgfev/
	DpV870e4aX4USJCw==
From: "tip-bot2 for Perry Yuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] platform/x86: hfi: Add online and offline
 callback support
Cc: Perry Yuan <Perry.Yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, ilpo.jarvinen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-8-superm1@kernel.org>
References: <20250609200518.3616080-8-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196903744.406.5701153024420116945.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     bb20421c05fc0a0fd70a3f8af076319f7dec4cf1
Gitweb:        https://git.kernel.org/tip/bb20421c05fc0a0fd70a3f8af076319f7de=
c4cf1
Author:        Perry Yuan <Perry.Yuan@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:12 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 22:24:40 +02:00

platform/x86: hfi: Add online and offline callback support

There are some firmware parameters that need to be configured
when a CPU core is brought online or offline.

When a CPU is online, it will initialize the workload classification
parameters to CPU firmware which will trigger the workload class ID
updating function.

Once the CPU is going offline, it will need to disable the workload
classification function and clear the history.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/20250609200518.3616080-8-superm1@kernel.org
---
 drivers/platform/x86/amd/hfi/hfi.c | 88 +++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hf=
i/hfi.c
index b10bd96..28ef721 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -92,6 +92,7 @@ struct amd_hfi_classes {
  * struct amd_hfi_cpuinfo - HFI workload class info per CPU
  * @cpu:		CPU index
  * @apic_id:		APIC id of the current CPU
+ * @cpus:		mask of CPUs associated with amd_hfi_cpuinfo
  * @class_index:	workload class ID index
  * @nr_class:		max number of workload class supported
  * @ipcc_scores:	ipcc scores for each class
@@ -102,6 +103,7 @@ struct amd_hfi_classes {
 struct amd_hfi_cpuinfo {
 	int		cpu;
 	u32		apic_id;
+	cpumask_var_t	cpus;
 	s16		class_index;
 	u8		nr_class;
 	int		*ipcc_scores;
@@ -110,6 +112,8 @@ struct amd_hfi_cpuinfo {
=20
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) =3D {.class_i=
ndex =3D -1};
=20
+static DEFINE_MUTEX(hfi_cpuinfo_lock);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -237,6 +241,81 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo=
 *hfi_cpuinfo, int cpu)
 	return 0;
 }
=20
+static int amd_hfi_set_state(unsigned int cpu, bool state)
+{
+	int ret;
+
+	ret =3D wrmsrq_on_cpu(cpu, MSR_AMD_WORKLOAD_CLASS_CONFIG, state ? 1 : 0);
+	if (ret)
+		return ret;
+
+	return wrmsrq_on_cpu(cpu, MSR_AMD_WORKLOAD_HRST, 0x1);
+}
+
+/**
+ * amd_hfi_online() - Enable workload classification on @cpu
+ * @cpu: CPU in which the workload classification will be enabled
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int amd_hfi_online(unsigned int cpu)
+{
+	struct amd_hfi_cpuinfo *hfi_info =3D per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+	struct amd_hfi_classes *hfi_classes;
+	int ret;
+
+	if (WARN_ON_ONCE(!hfi_info))
+		return -EINVAL;
+
+	/*
+	 * Check if @cpu as an associated, initialized and ranking data must
+	 * be filled.
+	 */
+	hfi_classes =3D hfi_info->amd_hfi_classes;
+	if (!hfi_classes)
+		return -EINVAL;
+
+	guard(mutex)(&hfi_cpuinfo_lock);
+
+	if (!zalloc_cpumask_var(&hfi_info->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_set_cpu(cpu, hfi_info->cpus);
+
+	ret =3D amd_hfi_set_state(cpu, true);
+	if (ret)
+		pr_err("WCT enable failed for CPU %u\n", cpu);
+
+	return ret;
+}
+
+/**
+ * amd_hfi_offline() - Disable workload classification on @cpu
+ * @cpu: CPU in which the workload classification will be disabled
+ *
+ * Remove @cpu from those covered by its HFI instance.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int amd_hfi_offline(unsigned int cpu)
+{
+	struct amd_hfi_cpuinfo *hfi_info =3D &per_cpu(amd_hfi_cpuinfo, cpu);
+	int ret;
+
+	if (WARN_ON_ONCE(!hfi_info))
+		return -EINVAL;
+
+	guard(mutex)(&hfi_cpuinfo_lock);
+
+	ret =3D amd_hfi_set_state(cpu, false);
+	if (ret)
+		pr_err("WCT disable failed for CPU %u\n", cpu);
+
+	free_cpumask_var(hfi_info->cpus);
+
+	return ret;
+}
+
 static int update_hfi_ipcc_scores(void)
 {
 	int cpu;
@@ -339,6 +418,15 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
=20
+	/*
+	 * Tasks will already be running at the time this happens. This is
+	 * OK because rankings will be adjusted by the callbacks.
+	 */
+	ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/amd_hfi:online",
+				amd_hfi_online, amd_hfi_offline);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
=20


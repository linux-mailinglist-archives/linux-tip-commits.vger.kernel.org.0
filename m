Return-Path: <linux-tip-commits+bounces-6020-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C325BAFC7C0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC56483779
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FBA2690D5;
	Tue,  8 Jul 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mlsQvcO2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ah6ga+cf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003A21FF29;
	Tue,  8 Jul 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969038; cv=none; b=il43USSiTKCCUTOKR/3uppshVwJIDdXGNT90NMcHxX38c0LPbFjC5kXKPmLxyi3gajPVaOgLBs9W1LM2yAaIBSAWJiMFNDD87YsA9p+WpO5aMJe7nMbnuhMZ0dl/PqYkmlmVUG82CIY8qZ2M/XAgVIkvaGmCB9C+JAGxw+kKt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969038; c=relaxed/simple;
	bh=g6NSSI+M9p6RiFeBHfsPAkSE4PzjocWQ1Cj9wyKp9g8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LGZDtWLQDr0PmMdDl5Q21bKnLRbZc9PZfgNCWGorDygyFU7lPosD/m4Vhyil7eMU53cEeQsw6nfPti9rjqpgmVR0fYCje6ne8h39oO5ZgSsb4U0lvoE6u0aQM/mXtLv+j1dIoQOUO3Bo1owlQPjjK7MvGpRUU/+JTHRcgzs0c8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mlsQvcO2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ah6ga+cf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:03:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=114zj+412SQjVXk2zNYgvPGVVOgr0BVlQ+e+RNTZAtk=;
	b=mlsQvcO2r63q/cUGSqtCkTtAFdDoll1BDtT2am96ZC5TzrvnQfJaTvFEcH5f4oXQWUychN
	VK5xd+kBz5pcWa+1Do2+Qkd0ytm9MaEP0vtKJ+jmYC4CiL0iO1WCUMJ+KUFK+yAxUmZ9KJ
	GvAyI3zMSmLjPzgU3WaKXf1XmHe7bZGiCqWmeOg12Yc4HC9kfIHw7ec8pku6d2HR/Eci4+
	dD1z2fcrQVmEO1Ezu9gyFBbUGHyAYmD7bLrk6ZnMpqmzqjL3oQ2h+K/VUNbAfLVqvwV1fl
	bR7VuGqCsRTHz6ozegrTMR5mfZCh9bBqZ7Nb9Vt4viPmq+Z2P6Eh/FQc5F6ATA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=114zj+412SQjVXk2zNYgvPGVVOgr0BVlQ+e+RNTZAtk=;
	b=ah6ga+cfv0XCs/G4bjTe/66Q/UL4HIY3OuaXr+hmGGbT3Esmb/2TojS9hUGM8WLZzlFNRw
	uHI5T6/gK6lG9fDA==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] platform/x86/amd: hfi: Set ITMT priority from
 ranking data
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, ilpo.jarvinen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-12-superm1@kernel.org>
References: <20250609200518.3616080-12-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196903404.406.4067289694319476043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     216fe0d7680b2503e09edd1d7dca73305806591c
Gitweb:        https://git.kernel.org/tip/216fe0d7680b2503e09edd1d7dca7330580=
6591c
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:16 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 22:34:17 +02:00

platform/x86/amd: hfi: Set ITMT priority from ranking data

The static ranking data that is read at module load should be used
to set up the priorities for the cores relative to the performance
values.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/20250609200518.3616080-12-superm1@kernel.org
---
 drivers/platform/x86/amd/hfi/Kconfig |  1 +
 drivers/platform/x86/amd/hfi/hfi.c   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/=
hfi/Kconfig
index 0196380..fecef68 100644
--- a/drivers/platform/x86/amd/hfi/Kconfig
+++ b/drivers/platform/x86/amd/hfi/Kconfig
@@ -7,6 +7,7 @@ config AMD_HFI
 	bool "AMD Hetero Core Hardware Feedback Driver"
 	depends on ACPI
 	depends on CPU_SUP_AMD
+	depends on SCHED_MC_PRIO
 	help
 	  Select this option to enable the AMD Heterogeneous Core Hardware
 	  Feedback Interface. If selected, hardware provides runtime thread
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hf=
i/hfi.c
index b0a5840..805c03b 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -114,6 +114,12 @@ static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cp=
uinfo) =3D {.class_index =3D
=20
 static DEFINE_MUTEX(hfi_cpuinfo_lock);
=20
+static void amd_hfi_sched_itmt_work(struct work_struct *work)
+{
+	sched_set_itmt_support();
+}
+static DECLARE_WORK(sched_amd_hfi_itmt_work, amd_hfi_sched_itmt_work);
+
 static int find_cpu_index_by_apicid(unsigned int target_apicid)
 {
 	int cpu_index;
@@ -238,6 +244,8 @@ static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo =
*hfi_cpuinfo, int cpu)
 		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
 			   hfi_cpuinfo->amd_hfi_classes[i].perf);
=20
+	sched_set_itmt_core_prio(hfi_cpuinfo->ipcc_scores[0], cpu);
+
 	return 0;
 }
=20
@@ -459,6 +467,8 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
=20
+	schedule_work(&sched_amd_hfi_itmt_work);
+
 	return 0;
 }
=20


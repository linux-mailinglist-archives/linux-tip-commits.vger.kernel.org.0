Return-Path: <linux-tip-commits+bounces-6024-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31C7AFC7CA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA4218950C4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EDE26AA98;
	Tue,  8 Jul 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UFY3o7GS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DLIDfY+6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240D26B096;
	Tue,  8 Jul 2025 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969043; cv=none; b=hCvV/1oLW8IqFgf7weoJ9NtczCBt49n/D7Tp/vMzfPNV66K4U/Wov/qLKVA+HcCo1g7niz3aUhnQdNfzolBmDAR3qF+ckTKrscLRgQvGWS6VWIIDzg1Ptq1OCDSmcwaq28/UoW280tGVIkgio/TJ0i/Ba6gYXH+T3CdOnCfKgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969043; c=relaxed/simple;
	bh=a8mVZ/4BCBaofKSumbt95TNrL6RDOV3Z9YUdvIs1/FM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gqEH+ztMwI3PdSfNHPiOoVEPv7H3Dm8L+vnmuwExDNwvNzSE0uk2JpzFvF8zd7uS0Fxt8JcJsHFS6GMCTQZZQolx8jQqLgAN8Wv85BWs9JjF3E9waQBynoXHIn4o8EH9IAAjEyU29QXCNvEMw3MzQwqsHNyJJ7S7PkOYhKbZy8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UFY3o7GS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DLIDfY+6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:03:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ndsjl5w8dcOVoy7g5u8yeavTIzw5eiCI0N66vYoWimY=;
	b=UFY3o7GSyci6NqRjXJeQeQXS4HNXwisWmE4B+3fva56Tu8lYNdvkD6OwT8MqMl37e2NJVp
	9KeIl5XZhwG8RtFc/7hnoZYIe3+nfjkPiMFfB1JFYQj2EuV88ZSd2fDbhzCGgnMA/8waT4
	f28Lk/GT4o96VTO0vKFEF1TH34HsB5G0PtWvH4RDZ1iTi+aX7qet9FPjFIW5u5av6vvaHf
	WzXFuAzWuVOk3qx/F0hr2kI0ZFPo4rqd6sn25vexgys9urbZFphSMmEKsW1nXsqtuPUhCW
	gCfgKIOxC7W/2DMyoCfEWi2bD8GhuHwaapVNGFJfYr38LsWw+uoOv4XLsK6tcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ndsjl5w8dcOVoy7g5u8yeavTIzw5eiCI0N66vYoWimY=;
	b=DLIDfY+6INQrEze/et+jBm1HjnnEOdyNuS7AZmRtmjWlGpaPNvooDer2rOAW48rGTj/cRc
	W5VrNXH62S+3RWAw==
From: "tip-bot2 for Perry Yuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/platform] platform/x86: hfi: Init per-cpu scores for each class
Cc: Perry Yuan <Perry.Yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, ilpo.jarvinen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-7-superm1@kernel.org>
References: <20250609200518.3616080-7-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196903829.406.16120672533728371829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     b6ffe4d9e074561f95a728e1f822ed15e533ec6e
Gitweb:        https://git.kernel.org/tip/b6ffe4d9e074561f95a728e1f822ed15e53=
3ec6e
Author:        Perry Yuan <Perry.Yuan@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:11 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 21:19:17 +02:00

platform/x86: hfi: Init per-cpu scores for each class

Initialize per CPU score `amd_hfi_ipcc_scores` which store energy score
and performance score data for each class.

Classic and dense cores are ranked according to those values as energy
efficiency capability or performance capability.  OS scheduler will pick cores
from the ranking list on each class ID for the thread which provide the class
id got from hardware feedback interface.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/20250609200518.3616080-7-superm1@kernel.org
---
 drivers/platform/x86/amd/hfi/hfi.c | 29 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hf=
i/hfi.c
index 690b7b1..b10bd96 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -228,6 +228,31 @@ static int amd_hfi_alloc_class_data(struct platform_devi=
ce *pdev)
 	return 0;
 }
=20
+static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int c=
pu)
+{
+	for (int i =3D 0; i < hfi_cpuinfo->nr_class; i++)
+		WRITE_ONCE(hfi_cpuinfo->ipcc_scores[i],
+			   hfi_cpuinfo->amd_hfi_classes[i].perf);
+
+	return 0;
+}
+
+static int update_hfi_ipcc_scores(void)
+{
+	int cpu;
+	int ret;
+
+	for_each_possible_cpu(cpu) {
+		struct amd_hfi_cpuinfo *hfi_cpuinfo =3D per_cpu_ptr(&amd_hfi_cpuinfo, cpu);
+
+		ret =3D amd_set_hfi_ipcc_score(hfi_cpuinfo, cpu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int amd_hfi_metadata_parser(struct platform_device *pdev,
 				   struct amd_hfi_data *amd_hfi_data)
 {
@@ -310,6 +335,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
=20
+	ret =3D update_hfi_ipcc_scores();
+	if (ret)
+		return ret;
+
 	return 0;
 }
=20


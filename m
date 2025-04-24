Return-Path: <linux-tip-commits+bounces-5116-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BACA9B3D9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DA718839BC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502DD280A4C;
	Thu, 24 Apr 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ylYBYr7Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gDK9Efao"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D227FD4D;
	Thu, 24 Apr 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511871; cv=none; b=HIvFwnGOpRbVLpGRhQDpioyds+tl4O4Qm/va4OtNJG/vsFTwVYNdwGGeVFf/4PIuLT7FGX1oGcIrXuxtzrWHwZZlqsv8B57U6juRmH29NkVnMYiNjyTkhpScReaEbTfQEjm+oXEtLY5HttLPxtl9W9gydHQayrZje5s6XQVqWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511871; c=relaxed/simple;
	bh=BD0rbbcQBosHnEWQRHYAiP3S3Q7nvbpUWkLFOcOiKeY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qCBNiBZ0KreJV2Ge/D+D80+5NxcQlo4u7mzFtHc1FVTNF++r92bzTfjDIi7cGTgDFvMzpWeHuYfc0Rld8+4c1kqAhLzRYu786k9+4gQcWrQYGi4xi2gdnbwJCN734RrUSRfSF90v2AeRWndQoCF2bDvVcdt8lzjQD38Txm2HdbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ylYBYr7Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gDK9Efao; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 16:24:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745511867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=em8INSWLcouZFS0+cA2aEIG0/3qdxMZPeI+TnHxZrgc=;
	b=ylYBYr7Ql30KCUKxzjV5sElixKBPCoP/9UOuULPy07ntHMTfWbWLzRrQ5yKBfuKBNvFvQk
	2/37uryqCvASGPIV3P/oXyn201LH48cCei14Q5s1yBKKGlPIp1DEmApPyxcYGrFzfeEV+E
	IG92L+TlB7lkJA1by1VufDp3cgcOUY0uG1Pd3CON7rQMut8oqYx58GnOjKlf7Kk65NO66h
	UoUvcKAj0Y3yen2hxCuCIvg8odomZ7lBOpht4Bz8SkWwx3b4LH+sNm9eFKcx7e1nXorS99
	kvt0oHA8sDkZg/JK/EHAax84b272RE7dfXy+eMdBl3Pl6yVMbgfjELbkGreELw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745511867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=em8INSWLcouZFS0+cA2aEIG0/3qdxMZPeI+TnHxZrgc=;
	b=gDK9EfaoL1CfGgHwRAp8Nu7AMD2zZRzLvRpDhkcNZ65GGW3XoZIQxc8TVfvs7dsIcvB0T6
	VpW9ud9fioC3bhCg==
From: "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] platform/x86/amd/pmc: Use FCH_PM_BASE definition
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Hans de Goede <hdegoede@redhat.com>, ilpo.jarvinen@linux.intel.com,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, platform-driver-x86@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250422234830.2840784-5-superm1@kernel.org>
References: <20250422234830.2840784-5-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174551186263.31282.837973831112893685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     0fbe08e78dfd4a680806132673c520f0fc5f84d9
Gitweb:        https://git.kernel.org/tip/0fbe08e78dfd4a680806132673c520f0fc5=
f84d9
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Tue, 22 Apr 2025 18:48:29 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Apr 2025 17:55:18 +02:00

platform/x86/amd/pmc: Use FCH_PM_BASE definition

The s2idle MMIO quirk uses a scratch register in the FCH.
Adjust the code to clarify that.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: platform-driver-x86@vger.kernel.org
Link: https://lore.kernel.org/r/20250422234830.2840784-5-superm1@kernel.org
---
 arch/x86/include/asm/amd/fch.h            | 1 +
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/amd/fch.h b/arch/x86/include/asm/amd/fch.h
index 28972bd..01ee15b 100644
--- a/arch/x86/include/asm/amd/fch.h
+++ b/arch/x86/include/asm/amd/fch.h
@@ -7,5 +7,6 @@
 /* Register offsets from PM base: */
 #define FCH_PM_DECODEEN			0x00
 #define FCH_PM_DECODEEN_SMBUS0SEL	GENMASK(20, 19)
+#define FCH_PM_SCRATCH			0x80
=20
 #endif /* _ASM_X86_AMD_FCH_H_ */
diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86=
/amd/pmc/pmc-quirks.c
index b4f4972..b706b1f 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -11,6 +11,7 @@
 #include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <asm/amd/fch.h>
=20
 #include "pmc.h"
=20
@@ -20,7 +21,7 @@ struct quirk_entry {
 };
=20
 static struct quirk_entry quirk_s2idle_bug =3D {
-	.s2idle_bug_mmio =3D 0xfed80380,
+	.s2idle_bug_mmio =3D FCH_PM_BASE + FCH_PM_SCRATCH,
 };
=20
 static struct quirk_entry quirk_spurious_8042 =3D {


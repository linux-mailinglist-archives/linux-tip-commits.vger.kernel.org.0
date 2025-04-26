Return-Path: <linux-tip-commits+bounces-5125-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8D1A9D9EC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Apr 2025 11:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9F54A3BEC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Apr 2025 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F93824EABD;
	Sat, 26 Apr 2025 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="glHtuqf/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PjpL5ksX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4221188733;
	Sat, 26 Apr 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745661424; cv=none; b=CUJ6NMzwI9WgrOK37wkBQMmwmaGRuImlQlsNYuAmvrKZKcmvXRwyNwx8Ua6j30i+z2Ayj5L2DA0G3kXqm7NaFyj4Jl01DphF9J+JjoIOPifNU8fSZslmqVF03PyM37NGSL/ZJKk2ioowZdcnfbzzu5ImWrmaI3cDMpBbleXOvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745661424; c=relaxed/simple;
	bh=MDU1hpe7MUhDbj+7Jlmd85zleSl3IuJZRAxiCiOb1Do=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qelgne6RFPg0Frt1kdvM6G0R34Ny+S0DCTDWI22f2W78TYShx2GZdSYBzpmgyPoDR8xmZgiJIsRrc+0JPBZkooJmf7FmtiTplCYT/XWJLScdwHNu3dYE77y9zyDG5bj0cgZ/iByzp4QZRE00t7EAWpOS3K7bms2w2Ox0noMmf2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=glHtuqf/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PjpL5ksX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Apr 2025 09:56:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745661420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSvpJ+vgMGaPtX3iAQ6Li5JL/KPVeJOe4vWv5mn23dc=;
	b=glHtuqf//h+4hFZTaEgSjdHUK0ltujqo/4LAoA/5vNs9C8q4XKTFtY0pVuLG52tcyLtaAa
	fQB8lJ9eDmH3pmcXwW6qJnnEfbRujY6KUwrNzVbYCylBX4FfJhxsRYFDB3eU12X5HiVDWB
	lP2RrhDhWNTtToqMcSIAMM4/zuYsvyEh3xTn/gA9ttq45jocSd+JR21ZFGDo/rz1nFajOP
	Y+wGVTHk9/dNWaBdEcSe/BVEG/uuz7TTEXgFrdnHEIN45E9970r1k1ddPB/XS5KCdRaESN
	wIhwlEqryA9h9KrMnBs7gWJmFhwmQx7/S9ybUbIfcGiFUYyb+5Gq4Xc8QhWvUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745661420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSvpJ+vgMGaPtX3iAQ6Li5JL/KPVeJOe4vWv5mn23dc=;
	b=PjpL5ksXP7VIctjbugH4VJ/u6Gn52V7ktemouRljY/drmLxnrSjQcY8VItf+qDQVst0qSq
	puZ88gn++YPpOQBA==
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
Message-ID: <174566141546.31282.9421067258808557948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     7094702a9e6d1256f1444ceff7be97414db51dbb
Gitweb:        https://git.kernel.org/tip/7094702a9e6d1256f1444ceff7be97414db=
51dbb
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Tue, 22 Apr 2025 18:48:29 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 26 Apr 2025 11:41:16 +02:00

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


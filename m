Return-Path: <linux-tip-commits+bounces-6478-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE7B439EC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D852F5A31AA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997D43064A2;
	Thu,  4 Sep 2025 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a6LV0G82";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5jzqh0k0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D242FC01F;
	Thu,  4 Sep 2025 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984873; cv=none; b=EHlz/yLdvFaPdCFpilVRJNqvUdIO9mPl0d2Y68m00XuZ2LdC9R2PfqPqRZEjDi9Xf4+es8P0VVqXuZtAX0hWe1Sdccnb9gJeNAgRLCrRIuBs78IKKVQ78lfrEMFVf+BRZ7yWGAQKdRipRKA39NmWYk7xY0MB8bFucU/AzwH7z7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984873; c=relaxed/simple;
	bh=/Lizzaqc94Jn64pcIwdmLxrccdeC9IZq2xpA0QcqO5o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wyq5hozZ9GIUsOkkRZZR8J81HtjrJK2TE9UGEjfILTKHmy5msae3XIyZscvQvYnrJ2u7lBR33rE89kRKvxgwkeqkkllQELdSrVPVJGVnDSYGkiUb8JTDzuXwh4KW3poYGUNtDG1b/OP7+YJhB8weyu6YZkjxSQOkTk2hK2biVc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a6LV0G82; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5jzqh0k0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:21:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAEEulsvDB9nyk7kzbVFyMMtM1G4tUiuuGKfw/QYalo=;
	b=a6LV0G82YRE95BUUJE083a4rBRq+MzRwm98QZ9Nye+m9KEF+MyIxk+FCenJM4zQk5C/RRs
	v3FnfGyEhoo1viituMxcnwpujczQYrUxohSp28Hx9xEAfsdmyS7Z5q/5gg1Rw3UH0rIzzt
	ZCVl9AAbwpxY9CEkHLHmlJYoJW0yjU0OAu46ftsi/pmTWOM8IV0WLEshBIqShQKomg/+QM
	9WwNRNuaZD2x4AV2CrpxQWT4sJCrq5rcQ6DGsazDn/CGI1TG5U2HPsMVtxZ3TjGBMvpgoB
	9KdplIf1NM2Iv+nX6Bb0k5jZ9Fw/S3G8qfCU/axOnW5SF+GpXzSPgsUr7QqeAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAEEulsvDB9nyk7kzbVFyMMtM1G4tUiuuGKfw/QYalo=;
	b=5jzqh0k0If+rTDNw2oRtw0Bo1vx6tOBVKF7QArlVrzceVXqETRaw/z1QlddWVY51zhdYQW
	oR0JDwc1nRIPZBBg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Use MSR protocol for remapping SVSM calling area
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-26-ardb+git@google.com>
References: <20250828102202.1849035-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698486885.1920.14326082574278362849.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     c15a4705d59caeb44f4c373cf04e89041309e568
Gitweb:        https://git.kernel.org/tip/c15a4705d59caeb44f4c373cf04e8904130=
9e568
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:05 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 31 Aug 2025 12:40:55 +02:00

x86/sev: Use MSR protocol for remapping SVSM calling area

As the preceding code comment already indicates, remapping the SVSM
calling area occurs long before the GHCB page is configured, and so
calling svsm_perform_call_protocol() is guaranteed to result in a call
to svsm_perform_msr_protocol().

So just call the latter directly. This allows most of the GHCB based API
infrastructure to be moved out of the startup code in a subsequent
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/20250828102202.1849035-26-ardb+git@google.com
---
 arch/x86/boot/startup/sev-shared.c  | 11 +++++++++++
 arch/x86/boot/startup/sev-startup.c |  5 ++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index ed88dfe..975d2b0 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -724,6 +724,17 @@ static void __head setup_cpuid_table(const struct cc_blo=
b_sev_info *cc_info)
 	}
 }
=20
+static int __head svsm_call_msr_protocol(struct svsm_call *call)
+{
+	int ret;
+
+	do {
+		ret =3D svsm_perform_msr_protocol(call);
+	} while (ret =3D=3D -EAGAIN);
+
+	return ret;
+}
+
 static void __head svsm_pval_4k_page(unsigned long paddr, bool validate)
 {
 	struct svsm_pvalidate_call *pc;
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index 0b7e3b9..8412807 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -295,7 +295,6 @@ found_cc_info:
 static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
 {
 	struct svsm_call call =3D {};
-	int ret;
 	u64 pa;
=20
 	/*
@@ -325,8 +324,8 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc=
_info)
 	call.caa =3D svsm_get_caa();
 	call.rax =3D SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
 	call.rcx =3D pa;
-	ret =3D svsm_perform_call_protocol(&call);
-	if (ret)
+
+	if (svsm_call_msr_protocol(&call))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CA_REMAP_FAIL);
=20
 	boot_svsm_caa =3D (struct svsm_ca *)pa;


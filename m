Return-Path: <linux-tip-commits+bounces-6476-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1D0B439E8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD2817085F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6373054D2;
	Thu,  4 Sep 2025 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y9v1Oewx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwtFj8CI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CD4304BD4;
	Thu,  4 Sep 2025 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984871; cv=none; b=Mjari+EYRJLJF5W1d7S7XSrHGDW4PqTbu6ux5a6T+U4gmrn6EOkI1Y8qdslhnqZV7JXTE9tDSbE5+rex2DFPnIY/dJc+vXJBp2xFyOSdZAD0kt1RERHLpuLyg6F59W0GSyO8BJBGlcvbqF/W6dy1jrRFqUJ2okS8WjqQDkuOAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984871; c=relaxed/simple;
	bh=4YjTSTZTYnyLPOrJKlLEMQEcyWUeqjetOLb4OxgLRZY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bT8QzfxUHGUXpqewa79Ie4EcRYzkf19SbXVEyycvyVB8zaDOeX7dZZ36zvb4opVRV2mL9ssneeU6TmHwNVmwT3E8XZJLO/9FrZfDv4hd0icFLHdaGo6O6MZtSmMg+83n3egx3/HXeBT1wJ65DGxBtChLKYchY44Sdjj9UpRMzHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y9v1Oewx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwtFj8CI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:21:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWVNO9+eQ+kvHsID/3D9cb4p9mupmk7PqfkKoiePmDg=;
	b=Y9v1OewxhWby9l0EU/lvW1X6TjOetyFurJNAqMxUwR8XmWLoRm/tlnEp9wh9sSLLEPbXHd
	ZG42M4AMxKEqRhDnh2IuQzyng3OVUck9y/Rqx4xFpJGqsdC2rQckzRCmDU0sZwACzix6i+
	lFLUlgfnyHyLe9QGUuxPTk78tG5dO3BkiwNqtLAXZuHSkpgb/BDIlCXtb1Q269LOyvVpTv
	AnPcLzl7g9VTaVuHJpIQXW8zG9Z5E1vZlZe7ivoJ7e0+gS6xeWCKHzSH+GRQcHHmTlczel
	OIvQyrAYjCMeMSB8WBWekauWY1muSSksphi0wzODMen6ess39MxuSGQLh0MwQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWVNO9+eQ+kvHsID/3D9cb4p9mupmk7PqfkKoiePmDg=;
	b=YwtFj8CI6CN0CeKh1lwL+FF6WPJV5VgamIrit0YTvh7MhOIee2WmH7NrX1TuOmB5JVAb3Q
	GBuHQHOOx5j6U8Ag==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Run RMPADJUST on SVSM calling area page to test VMPL
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-28-ardb+git@google.com>
References: <20250828102202.1849035-28-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698486662.1920.11846897018314186763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e349241b97a8b1169a4e90375159df4d22061f9a
Gitweb:        https://git.kernel.org/tip/e349241b97a8b1169a4e90375159df4d220=
61f9a
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:07 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 31 Aug 2025 12:40:56 +02:00

x86/sev: Run RMPADJUST on SVSM calling area page to test VMPL

Determining the VMPL at which the kernel runs involves performing a RMPADJUST
operation on an arbitrary page of memory, and observing whether it succeeds.

The use of boot_ghcb_page in the core kernel in this case is completely
arbitrary, but results in the need to provide a PIC alias for it. So use
boot_svsm_ca_page instead, which already needs this alias for other reasons.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/20250828102202.1849035-28-ardb+git@google.com
---
 arch/x86/boot/compressed/sev.c      | 2 +-
 arch/x86/boot/startup/sev-shared.c  | 5 +++--
 arch/x86/boot/startup/sev-startup.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index b71c1ab..3628e9b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -327,7 +327,7 @@ static bool early_snp_init(struct boot_params *bp)
 	 * running at VMPL0. The CA will be used to communicate with the
 	 * SVSM and request its services.
 	 */
-	svsm_setup_ca(cc_info);
+	svsm_setup_ca(cc_info, rip_rel_ptr(&boot_ghcb_page));
=20
 	/*
 	 * Pass run-time kernel a pointer to CC info via boot_params so EFI
diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index 7bd7346..83c222a 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -801,7 +801,8 @@ static void __head pvalidate_4k_page(unsigned long vaddr,=
 unsigned long paddr,
  * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SV=
SM
  * services needed when not running in VMPL0.
  */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
+static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info,
+				 void *page)
 {
 	struct snp_secrets_page *secrets_page;
 	struct snp_cpuid_table *cpuid_table;
@@ -824,7 +825,7 @@ static bool __head svsm_setup_ca(const struct cc_blob_sev=
_info *cc_info)
 	 * routine is running identity mapped when called, both by the decompressor
 	 * code and the early kernel code.
 	 */
-	if (!rmpadjust((unsigned long)rip_rel_ptr(&boot_ghcb_page), RMP_PG_SIZE_4K,=
 1))
+	if (!rmpadjust((unsigned long)page, RMP_PG_SIZE_4K, 1))
 		return false;
=20
 	/*
diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index 8412807..3da04a7 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -302,7 +302,7 @@ static __head void svsm_setup(struct cc_blob_sev_info *cc=
_info)
 	 * running at VMPL0. The CA will be used to communicate with the
 	 * SVSM to perform the SVSM services.
 	 */
-	if (!svsm_setup_ca(cc_info))
+	if (!svsm_setup_ca(cc_info, rip_rel_ptr(&boot_svsm_ca_page)))
 		return;
=20
 	/*


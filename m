Return-Path: <linux-tip-commits+bounces-6557-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5044B52E4D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4ED1BC75D8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61189310768;
	Thu, 11 Sep 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LYD76YBj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="03QFR/Oq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CD030FF24;
	Thu, 11 Sep 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586536; cv=none; b=H8JVWkjoBJZiEoCHNf3dFP2g8azMGzDqy/WYtXl+QYi/jxVZdbyooIEw3+jmEv4FKKgObHezk14qhy+DH0xcnI6H6IPm/D8uf74/2s3MBfJm2cwEg0rzIzdpdzJhLepMkX0u14sG15GOmmtIO7cyijLSUhmzPYY15JfEcd/H2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586536; c=relaxed/simple;
	bh=gEP4SIrRIhT8qNqel1o10qp2tUqjIfPvvwfuU/X7qJg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Q5fs7bqfyOyQ0tcItded3tMLSYp4xfig7BKzoKnommbnbuL0+t+sERYmbn27Vkx/okJoko92Cm6jRejrORhZQkO+bhFQ37GdD5ZOYPewCzHgHUnriYDbGF7QDTVUZHglDNxXkPakA0pdkmDG5aA+Ohyt0dNTNA2cfoM7VmCTuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LYD76YBj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=03QFR/Oq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:28:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=F0NfMM+nMNV+7S4g8vFFYl5npQmejT8JytEggF33ZaQ=;
	b=LYD76YBjH8pPNy3La0Z3WUPf65gGvygCMOitE1U21Nc/DhQqm7m0NGQFz4DlNZBpUXLMLh
	JdQexrsJgfaUfY/dhmVOzg0OWG1dz1nlR6dOAAFAfxQ2+rYJfxW/wTlltoidDyJh/B650E
	E2ZqNiFua23t9i5aTnGAr0aX8+p4LW7r1GZEBCWK5iCq6bkGDemGFdHZZLrP/DIbGsTFVy
	tTLYxK1leuX7axrIw7W40oWomHnGaDpeYzZEElh6LMo29T1vVaCWUMsLaT/oIxVAAUTdB2
	8JXk4xQsyPsHJczeZbJobGdRXLb8FTG5LNAzaG7A0CtoFpgDEkwF3lYBACqM+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=F0NfMM+nMNV+7S4g8vFFYl5npQmejT8JytEggF33ZaQ=;
	b=03QFR/OqydSqb/Yt6L3URSI1IP3QBJIneMV0LgcB+OvcK0RPdaMUFkotJ2X4GRn29PlyH/
	7/60nqchSrvqHdCw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: ras/core] x86/mce/amd: Define threshold restart function for banks
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175758653133.709179.16801874345100038068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     5a92e88ffc49c383472f4b686d1bbe89e7b33cf3
Gitweb:        https://git.kernel.org/tip/5a92e88ffc49c383472f4b686d1bbe89e7b=
33cf3
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:42=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:23:49 +02:00

x86/mce/amd: Define threshold restart function for banks

Prepare for CMCI storm support by moving the common bank/block iterator code
to a helper function.

Include a parameter to switch the interrupt enable. This will be used by
the CMCI storm handling function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c | 37 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9ca4079..fbdb0ce 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -471,6 +471,24 @@ static void threshold_restart_block(void *_tr)
 	wrmsr(tr->b->address, lo, hi);
 }
=20
+static void threshold_restart_bank(unsigned int bank, bool intr_en)
+{
+	struct threshold_bank **thr_banks =3D this_cpu_read(threshold_banks);
+	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
+
+	if (!thr_banks || !thr_banks[bank])
+		return;
+
+	memset(&tr, 0, sizeof(tr));
+
+	list_for_each_entry_safe(block, tmp, &thr_banks[bank]->miscj, miscj) {
+		tr.b =3D block;
+		tr.b->interrupt_enable =3D intr_en;
+		threshold_restart_block(&tr);
+	}
+}
+
 static void mce_threshold_block_init(struct threshold_block *b, int offset)
 {
 	struct thresh_restart tr =3D {
@@ -814,24 +832,7 @@ static void amd_deferred_error_interrupt(void)
=20
 static void amd_reset_thr_limit(unsigned int bank)
 {
-	struct threshold_bank **bp =3D this_cpu_read(threshold_banks);
-	struct threshold_block *block, *tmp;
-	struct thresh_restart tr;
-
-	/*
-	 * Validate that the threshold bank has been initialized already. The
-	 * handler is installed at boot time, but on a hotplug event the
-	 * interrupt might fire before the data has been initialized.
-	 */
-	if (!bp || !bp[bank])
-		return;
-
-	memset(&tr, 0, sizeof(tr));
-
-	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj) {
-		tr.b =3D block;
-		threshold_restart_block(&tr);
-	}
+	threshold_restart_bank(bank, true);
 }
=20
 /*


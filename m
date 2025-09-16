Return-Path: <linux-tip-commits+bounces-6654-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8273B596B1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 14:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91154E452B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3B42C15AB;
	Tue, 16 Sep 2025 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LFS1HqRG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="btrrqlrA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285521CC59;
	Tue, 16 Sep 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027275; cv=none; b=fFp8IF1lmlkFLzMOjJfxYZXtxhOvgMvy1lQKBMVQaPZQ3sb5FDhUSfjQQUTkwhSvWVD0ouL/dcvAvUOFxVC8DaD6tX/pl1HjoVHKopadS9Jy2ns9ITl07vAUKLv4I8Ly3KHTNsR5IePYvscOyIrngu8EO80Lh+KIfSpEhFTqwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027275; c=relaxed/simple;
	bh=14qnxcBLPZBti/BtRPGHUeF5EggVBpYqVeiU0uoecTE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=S/6QAE+0BLAu7bhsZl2pnoBSoaDB4aokTY4aw5zpMg1HiEZl/a4n9eTLqHYXQrT0W00kY8+jMdO8oDBHscuuqEVMCAMW2G+UYYUWe9TYhKOA9Q694auygUmKbN1ylsDbbqLNdrA+XwKMFZYBGucYjIfDAVg71CJME67Cj0yFeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LFS1HqRG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=btrrqlrA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 12:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758027272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vAvAeWYgkmml6MsSctBNyOWUsg66URDwdrJMrW+azUk=;
	b=LFS1HqRG6Rr89qK+4KQYzuCPmKXEI2QxakjdA+t0NloAEeinkYe/3vG7Nt3f+9MENVglTu
	IKcxudSbLzFvN9wIIsoQvA66x7a84WKgDlh/u1OSezLgFKjVs6o9Z8wfjup2hQ5xtECtWG
	8LFTAOSJ6SAbvjmJUik+rdwcQfLIR/Tar1RvJTkhxg/v+3WxKIMcy9Q2cjllRXtDyH83bB
	1jGibcIJvWb+pLitMLgD5GhtVeYYfSS0ysror3LvEpNnzL9/g+hGIcL6aQ9BrKLILfbOiy
	hbqFGNtJ5iTbuu9Nq594rctL3DtZhwtzHHhwbrA8Hr/lUQnX/StnCISVCidFEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758027272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vAvAeWYgkmml6MsSctBNyOWUsg66URDwdrJMrW+azUk=;
	b=btrrqlrA1a2y2WXJaboLcDVD4lW9+a8H8la+9bXBqujQAT8Gv2k9iPocP/gZQNwehf1CU2
	6cgvwuNlaroqqYCA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Remove uses of cpu_mitigations_off()
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175802727099.709179.4226213229123935402.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     440d20154add24082eb43305f85288a756a5cc56
Gitweb:        https://git.kernel.org/tip/440d20154add24082eb43305f85288a756a=
5cc56
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 15 Sep 2025 08:47:03 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 21:10:44 +02:00

x86/bugs: Remove uses of cpu_mitigations_off()

cpu_mitigations_off() is no longer needed because all bugs use attack
vector controls to select a mitigation, and cpu_mitigations_off() is
equivalent to no attack vectors being selected.

Remove the few remaining unnecessary uses of this function in this file.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 570de55..f28a738 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -687,8 +687,7 @@ static const char * const mmio_strings[] =3D {
=20
 static void __init mmio_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
-	     cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
 		mmio_mitigation =3D MMIO_MITIGATION_OFF;
 		return;
 	}
@@ -3125,14 +3124,15 @@ ibpb_on_vmexit:
=20
 static void __init srso_update_mitigation(void)
 {
+	if (!boot_cpu_has_bug(X86_BUG_SRSO))
+		return;
+
 	/* If retbleed is using IBPB, that works for SRSO as well */
 	if (retbleed_mitigation =3D=3D RETBLEED_MITIGATION_IBPB &&
 	    boot_cpu_has(X86_FEATURE_IBPB_BRTYPE))
 		srso_mitigation =3D SRSO_MITIGATION_IBPB;
=20
-	if (boot_cpu_has_bug(X86_BUG_SRSO) &&
-	    !cpu_mitigations_off())
-		pr_info("%s\n", srso_strings[srso_mitigation]);
+	pr_info("%s\n", srso_strings[srso_mitigation]);
 }
=20
 static void __init srso_apply_mitigation(void)


Return-Path: <linux-tip-commits+bounces-6406-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE083B3FCB2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB1664E39D6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756462F5313;
	Tue,  2 Sep 2025 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z31CuGDZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0V8eiW+b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A92ECD1B;
	Tue,  2 Sep 2025 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809403; cv=none; b=fjRTkFbFqttbVrPopwWDEspxka53amHqn6TOCeG1MbczUCnB50YgMi8iv7Y+sOkV4rOH66oMD56xWK7ge8wY+P8oNKWFhA+VCCZU1+v+9xwGAwGtiWmCWVGDAE3AdqpnssCtYy5XNZlGSDPWx7diS9c1FjFBuqtIJFFBw7UAWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809403; c=relaxed/simple;
	bh=L4/n3yOMiDeh0zlRA8RQQ5GoGIdUvAuhjOFDqGYYMU0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PVyU0gT5RhOqbtAos6NQgXE9V86C8M3e0galjyOuefl9Ta2/EJE/kg588mjESaS6etFv8FLld5uyKfdO53HSUU4Q8GgTr/hz+6OP3pXcIVBxF9QWMw8pdxBJr7cZZdmQMNcUS7+itTN64kMyhQQyA4T3l1hvrx5ueiHGXcFrCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z31CuGDZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0V8eiW+b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmSFSOXBSVyxH9hFuCEBL5AcHgQdlSNc8vj48ynhYFw=;
	b=z31CuGDZlgSBQoNhnQlEEWJqMF6P1AP7IvKPbXEyK/GJLX+bZssGfMt6KnH8tSbuzzO8wt
	qZ2zN3WWqdweD3WvBe57cs4pOLa35esPl94wpXXHJChrNQD8ckD7i4Rzir1n/dQs+mMxY9
	Q2i5m15Xp2QSSLQBCdETLvGGTc3vlLuTTkzoubgdj4VTe+0Gtw0Myqx1hLpv7UBzGMPCGd
	lIHuw8wxyWPp847C/Zc6gMCQbWMR6K7GskkJzW3CrEqpxrosAUfhEYk5yd0xWfY5iIXn+O
	tsRMWdsSyYprVBA0RFBuy7aU5ZgIrrZw/CfhuwhFk+1R4JCZTDKaY367hUUe/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmSFSOXBSVyxH9hFuCEBL5AcHgQdlSNc8vj48ynhYFw=;
	b=0V8eiW+bYKHlCaPJPFKYL8A2CfMH9Y6LGIyqw5OxuwHOP1RsIGm+ZOTjLwVZS9OX2/rlvd
	TiUxFr74uBp9/hBQ==
From: "tip-bot2 for Kishon Vijay Abraham I" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/sev: Enable NMI support for Secure AVIC
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828111315.208959-1-Neeraj.Upadhyay@amd.com>
References: <20250828111315.208959-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680939838.1920.4355617400904918113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     28bbfad229e4addf9990279c73c07b762b4a04e4
Gitweb:        https://git.kernel.org/tip/28bbfad229e4addf9990279c73c07b762b4=
a04e4
Author:        Kishon Vijay Abraham I <kvijayab@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:43:15 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 13:00:43 +02:00

x86/sev: Enable NMI support for Secure AVIC

Now that support to send NMI IPI and support to inject NMI from the hypervisor
has been added, set V_NMI_ENABLE in the VINTR_CTRL field of the VMSA to enable
NMI for Secure AVIC guests.

  [ bp: Zap useless brackets. ]

Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828111315.208959-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/coco/sev/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 37b1d41..e474061 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -975,7 +975,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned l=
ong start_ip, unsigned=20
 	vmsa->x87_fcw		=3D AP_INIT_X87_FCW_DEFAULT;
=20
 	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
-		vmsa->vintr_ctrl	|=3D V_GIF_MASK;
+		vmsa->vintr_ctrl |=3D V_GIF_MASK | V_NMI_ENABLE_MASK;
=20
 	/* SVME must be set. */
 	vmsa->efer		=3D EFER_SVME;


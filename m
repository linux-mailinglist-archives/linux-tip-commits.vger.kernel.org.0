Return-Path: <linux-tip-commits+bounces-2607-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 640279B1686
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 11:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45547283067
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49F1CFEC2;
	Sat, 26 Oct 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rbkDWvCm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pXY+opjr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B8B18B464;
	Sat, 26 Oct 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729935171; cv=none; b=jjjrgBH+SBG8Boy6rBGNT732hyps8Fi3S3qh2ahUMWcywFHJan2WistLqa5drry+8H18Ib87pOOR5SUFjD/5LdF4GpDGjHBua3MqUQmqUIBA2CQMURW51Z2CCDvMPlHkQZOSmpfhawtDBefSyp2m++OdJNT8y0vTJkEJi2MaN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729935171; c=relaxed/simple;
	bh=xBAaMbxXHz1JGVfHuwbUpv3B9UPq9spBnGWiISHyQHs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nrE6rUzgc9WGdljpf6Kd847UVtV4lIzhdllS4lE3a6yZgmz6/OjkJgh5cnmHMsigL7Jrew8ypKiUDoiGR8hkbxZ7xqm2SEkBXLArvP9Qc74dKoEXHv4vBj7eupJRy8wnChbuLsvqn+mEF5f/GBd9Z2uDSgka8JTMmMosouyCLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rbkDWvCm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pXY+opjr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Oct 2024 09:32:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729935167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ptuG5tBMtSrA8ltYL4pYYEq8qq0O8lzzR6joRU+u9k=;
	b=rbkDWvCmfGpoCG0NgtotWg4T6m3hrFvVFnPaNHUi3IY/E3vZYGVi9UEPk/+BaQoL3Mav0B
	vXwCzlTyo4TzvGtG5xd+y2CPm/20Ia/4zuWz2SuuZ5e8x27y7FeKisBo7vV8cbVfaf+Ot3
	sEkpikUN9n5nlE/jG1/4AFZUYvNw8oQl0+W4pn7twg1ZVOJbf8ZLwT/YYV7l06HlXyw8ne
	DH3xsSUCLjybh0LL0ELGuwrfX3AJ9xvbgM4v77nP5vurN4gHIf6eRSHxIOSCNfR9xBgdwG
	5axJn1qmBzScSuD0PGzvIJIKqw4AVIFg8wTaPY5ErP/qh/qADZwa6umweW2/cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729935167;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ptuG5tBMtSrA8ltYL4pYYEq8qq0O8lzzR6joRU+u9k=;
	b=pXY+opjrZdQlpsmpaC3xT8sHM2PzEmA8bJApVV9RBiZyQyY54w2z3gacp4scDvq4fyPAp6
	CFwN4FC3vscXzIAQ==
From: "tip-bot2 for Perry Yuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on AMD
Cc: Perry Yuan <perry.yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241025171459.1093-4-mario.limonciello@amd.com>
References: <20241025171459.1093-4-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172993516683.1442.1977940515372789414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b0979e53645825a38f814ca5d3d09aed2745911d
Gitweb:        https://git.kernel.org/tip/b0979e53645825a38f814ca5d3d09aed2745911d
Author:        Perry Yuan <perry.yuan@amd.com>
AuthorDate:    Fri, 25 Oct 2024 12:14:57 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 25 Oct 2024 20:43:22 +02:00

x86/cpu: Enable SD_ASYM_PACKING for PKG domain on AMD

Enable the SD_ASYM_PACKING domain flag for the PKG domain on AMD heterogeneous
processors.  This flag is beneficial for processors with one or more CCDs and
relies on x86_sched_itmt_flags().

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/r/20241025171459.1093-4-mario.limonciello@amd.com
---
 arch/x86/kernel/smpboot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 766f092..b5a8f08 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -497,8 +497,9 @@ static int x86_cluster_flags(void)
 
 static int x86_die_flags(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-	       return x86_sched_itmt_flags();
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU) ||
+	    cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
+		return x86_sched_itmt_flags();
 
 	return 0;
 }


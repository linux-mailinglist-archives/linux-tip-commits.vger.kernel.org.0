Return-Path: <linux-tip-commits+bounces-6466-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9388B439D8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865B71C815F1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BFC3002B3;
	Thu,  4 Sep 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="14N/mCK5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uBZfdfuS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB42FF654;
	Thu,  4 Sep 2025 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984859; cv=none; b=Rse2OVXKks4uOHspODK9CkQP7q0q/iBrlnXvnu0qIrv2OsHIiADTX5Ltt7UCruBmG3sitMHBvyzaknkcgGxv9c4Aox68IqEmFTuZggcr9GvpRbQcZcx5YeGephHpUZ/vYtlmvBlmkiACz6gVnG1xkVSXmhflF0FdpRh1vK7OTCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984859; c=relaxed/simple;
	bh=h1MK+rwwsALgZ7Fh2L4UB1WdCS3LxCLAoORJbacjVio=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u+HXvDarF7/bbuX490P222WMOv+3AlkufBQdOv5sjPA7ujCVf37gTmjFiHwP5O+tIAKT4LB78KH4wYnyY2LfzjyRZUpTTO2lhL+oBP9UbyM+/YPvrSnoppSCIsmvmGS6PlFvuTfcMxmkCcBW3m+eKw8ZgazTftjyB7Q6s8sFdFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=14N/mCK5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uBZfdfuS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6eBarERf41r6id+ToqHLCHbe3b2abVPXqgh6Wt2fBMI=;
	b=14N/mCK5qorJY1qSIoLi30Y7E4sIXPvvH82NgsquAx7CD6q//NoOYmP/yljPp7x5Aik1pq
	OBPD9EfKcZlemstnWIG2fBmXBOk5ejbQ1GiURkeNjqKdAUv2/cwrLYNz0L6RKaees7U/nt
	rlrD/uWSmcXbtY7HxhiF4hwp8llLl3xFlUNDfQBo7gG93Bd/+kGUnOFJgMeuARgR/dJBfn
	BBInvr8ZZ5RC0DbSX8Egj3ZlaVEjwwS2Q+qsp1hiUwDAuVTx4+EdiGV4kaQtva/qMWO0W3
	Gh8x+qW0mCg35zZUKnYqLQOARky+35lqhOmU75kGYxQ/Vz8cHrfu1rLbs4LHDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6eBarERf41r6id+ToqHLCHbe3b2abVPXqgh6Wt2fBMI=;
	b=uBZfdfuSdAETKxXbpAzGub56HTdCz7GbIInzmpzum+AKAmoNQ+Q38u3j17BlNpshtt+AAh
	SmxbEAiOc64XayCQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Export startup routines for later use
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-38-ardb+git@google.com>
References: <20250828102202.1849035-38-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698485474.1920.3751563806975208449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     05ce314ba5155d57c86f8f276cb17f78ac5fb4f0
Gitweb:        https://git.kernel.org/tip/05ce314ba5155d57c86f8f276cb17f78ac5=
fb4f0
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:17 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:59:49 +02:00

x86/sev: Export startup routines for later use

Create aliases that expose routines that are part of the startup code to
other code in the core kernel, so that they can be called later as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-38-ardb+git@google.com
---
 arch/x86/boot/startup/exports.h | 14 ++++++++++++++
 arch/x86/kernel/vmlinux.lds.S   |  2 ++
 2 files changed, 16 insertions(+)
 create mode 100644 arch/x86/boot/startup/exports.h

diff --git a/arch/x86/boot/startup/exports.h b/arch/x86/boot/startup/exports.h
new file mode 100644
index 0000000..01d2363
--- /dev/null
+++ b/arch/x86/boot/startup/exports.h
@@ -0,0 +1,14 @@
+
+/*
+ * The symbols below are functions that are implemented by the startup code,
+ * but called at runtime by the SEV code residing in the core kernel.
+ */
+PROVIDE(early_set_pages_state		=3D __pi_early_set_pages_state);
+PROVIDE(early_snp_set_memory_private	=3D __pi_early_snp_set_memory_private);
+PROVIDE(early_snp_set_memory_shared	=3D __pi_early_snp_set_memory_shared);
+PROVIDE(get_hv_features			=3D __pi_get_hv_features);
+PROVIDE(sev_es_terminate		=3D __pi_sev_es_terminate);
+PROVIDE(snp_cpuid			=3D __pi_snp_cpuid);
+PROVIDE(snp_cpuid_get_table		=3D __pi_snp_cpuid_get_table);
+PROVIDE(svsm_issue_call			=3D __pi_svsm_issue_call);
+PROVIDE(svsm_process_result_codes	=3D __pi_svsm_process_result_codes);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4fa0be7..5d5e3a9 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -535,3 +535,5 @@ xen_elfnote_entry_value =3D
 xen_elfnote_phys32_entry_value =3D
 	ABSOLUTE(xen_elfnote_phys32_entry) + ABSOLUTE(pvh_start_xen - LOAD_OFFSET);
 #endif
+
+#include "../boot/startup/exports.h"


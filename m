Return-Path: <linux-tip-commits+bounces-7476-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48771C7E608
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Nov 2025 20:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F1DB4E18E6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Nov 2025 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4F315ECD7;
	Sun, 23 Nov 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PjjO3ga2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s7cnNA/G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCCE1A295;
	Sun, 23 Nov 2025 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924641; cv=none; b=X1e3f12Z4Rrt9gj0NU/aHIcuyicASEEG6gQFsv61SPg92R9ugj3MHtNKp++tb6T6wB9aHIgd33MgpN0NA3sttC8FDmRix1rClH2eibGcUhHcqwyxjUyEYRwq3Pmtiv6jAW3G89zQYvXwYu4CS0KJ4jDmdCidj4w6XaQ9490rAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924641; c=relaxed/simple;
	bh=Y46Xi8yXMAThhR/3TwZp+g4Wkh1UPZq8Y390zA053lU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SD+9Aq0qYSNPaw4WaptGYlF9mbqfEfowMAKhflzcViL1palDZXzfRjCDLbxZb2Uz7H2R1ik4uXjyipQHv1UCNPNnjI9fMhbzM+Gp6uImKtlz2x1ObF3qblEo16AQrXkyI7YRnW06MD4zjLw80uv4aBDays/4nZ4KGbFeSQBfbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PjjO3ga2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s7cnNA/G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Nov 2025 19:03:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763924638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yj6o+qnYM6B8mHCNrfSuPAWUA4Ij6bBJRXVSZ/zweDA=;
	b=PjjO3ga2mmKR0D5DoB+371HCuxe15HR6OS5aFsD5eLDuTRuIeZ+yTkAVVRhRY9xTh2RhSy
	icb6zc7mcJ7rg43y5zfjB9JKoKawkLKKSnxBmM7NULdiTBgB1HyKxlhl0Xux0xzQzWeBuf
	yLqZYBwcfpgENzeEXxaUDGlMlELZ6F1q3/jZ1W39SpEKqKLvXgXlYKuJYP+r34pDXzu1DM
	QtcZkjclX7sq3oNLiDLa3cNZTiXbCY8buIhn/iE8PVckIpoDAGkjsWh84wEj2huK4Wkl/s
	xN5Ckk/eWPC1NCuJT/uR6qi3kkDQEPy/1/RIMr7yLVqvHxBUe+d1H5MIgAUNKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763924638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yj6o+qnYM6B8mHCNrfSuPAWUA4Ij6bBJRXVSZ/zweDA=;
	b=s7cnNA/GZY0GmQCLrf+nmgeyDmyURdY2e0AdHvWphLJFkmMDZGsL59FbigEMIofa3nF6hl
	24oas2ya9a/fLSAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] cpu: Initialize __num_possible_cpus correctly
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Nathan Chancellor <nathan@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87zf8ehyf7.ffs@tglx>
References: <87zf8ehyf7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176392463299.498.1637732702053037299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     21782b3a5cd40892cb2995aa1ec3e74dd1112f1d
Gitweb:        https://git.kernel.org/tip/21782b3a5cd40892cb2995aa1ec3e74dd11=
12f1d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 22 Nov 2025 16:19:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Nov 2025 19:59:30 +01:00

cpu: Initialize __num_possible_cpus correctly

The variable to cache the number of possible CPUs is initialized to NR_CPUS
at build time, but that's only correct when cpu_possible_mask is
initialized with CPU_BITS_ALL. That's only the case on PARISC.

On x86 and some other architectures this does not matter because they
initialize cpu_possible_mask via init_cpu_possible() which does a proper
weight calculation. Though on architectures which do not, this results
in a completely wrong cached value 'NR_CPUS + actual possible CPUs'.

Initialize it correctly to 0 when CONFIG_INIT_ALL_POSSIBLE=3Dn and move the
NR_CPUS initialization into the PARISC specific section.

Fixes: d0f23ccf6ba9 ("cpumask: Cache num_possible_cpus()")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://patch.msgid.link/87zf8ehyf7.ffs@tglx
Closes: https://lore.kernel.org/all/89c7106e-a431-443a-9527-3d5fbce77fe1@sams=
ung.com
Closes: https://lore.kernel.org/all/20251122002755.GA2682494@ax162
Closes: https://lore.kernel.org/all/ad2a55f9-9bca-41bf-a6ec-efb23eaa778f@paul=
mck-laptop
---
 kernel/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 18e530d..b674fdf 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3085,10 +3085,13 @@ EXPORT_SYMBOL(cpu_all_bits);
 #ifdef CONFIG_INIT_ALL_POSSIBLE
 struct cpumask __cpu_possible_mask __ro_after_init
 	=3D {CPU_BITS_ALL};
+unsigned int __num_possible_cpus __ro_after_init =3D NR_CPUS;
 #else
 struct cpumask __cpu_possible_mask __ro_after_init;
+unsigned int __num_possible_cpus __ro_after_init;
 #endif
 EXPORT_SYMBOL(__cpu_possible_mask);
+EXPORT_SYMBOL(__num_possible_cpus);
=20
 struct cpumask __cpu_online_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_online_mask);
@@ -3108,9 +3111,6 @@ EXPORT_SYMBOL(__cpu_dying_mask);
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
=20
-unsigned int __num_possible_cpus __ro_after_init =3D NR_CPUS;
-EXPORT_SYMBOL(__num_possible_cpus);
-
 void init_cpu_present(const struct cpumask *src)
 {
 	cpumask_copy(&__cpu_present_mask, src);


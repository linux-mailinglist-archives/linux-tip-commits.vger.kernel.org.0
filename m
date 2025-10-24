Return-Path: <linux-tip-commits+bounces-6997-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47FDC080E6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 22:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67693A2382
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 20:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6B62F1FD5;
	Fri, 24 Oct 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jikZcWTd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xtVdEVVU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22BE2F1FC7;
	Fri, 24 Oct 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337625; cv=none; b=tLcwnUMGtzGW/l3ipzklheF0ia+MHGzVWbFfhkQkFeVpKjlUpkrJdQO4jkBiYCgIXZchf0+pOEV+ci2bksqY60+1dO2JgbpoHnHHCRPz9lRVwvmjBx5HTlcXa7EQfoSILWU6sVOebte5PXKMHIXrw67fBKYlKmqK1CEri5PP/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337625; c=relaxed/simple;
	bh=yj5KUSn5sn+dfasMGDILS/49PvuZzKNeN9Ie3SqV00U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=WjCi91ImlXoqCEdDO9oKdi6XfqOm9qxQk9UtzjXEkeiQWIFbNHITyzh2b6C2uQWNYCpkxPQfw5ASszUpNe768IV27+yHiLkS12CCjozlH9XFq4OSjYZRYwFWeX1DjE5YU4YdwTfRl63KZqNAw77bVL0pJ2aHhep6rWT+NXz6rOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jikZcWTd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xtVdEVVU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 20:27:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761337622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qAoMF2xUQEaLiFS2JydJFyhFHbAunzFSzkNk/0Y0TtQ=;
	b=jikZcWTdM1yf7iLpqwDddc75qS7LdhouzHJ1rddkcvsmwpsqI6UZWa8MYwrJRr9EiIczR+
	CQ81y/sVr5iqwH8jEkmVBJMIAjbn7Fw37+5Tc6wRjW5sISPNEkHIpbsI62vySHqqyGUamm
	fAwtCi4Hr6TaGn65Z6E3PBlH5YRKGXUZ6ZOTHnyN8C35NNGYTN+v3bc78/qHD+DwkWDDKO
	qTLz0l3XQL9FnhUGRPIppsCR8Eg29H+TDgeTkuDUHPrk9s3IYLHGzBk4wmD6nPYf0DoohY
	LRWCXpjAXX9U6BuSqqDzonIColPsILO/GB+UcM+P/EvStt5qDr0l59/oPznBjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761337622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qAoMF2xUQEaLiFS2JydJFyhFHbAunzFSzkNk/0Y0TtQ=;
	b=xtVdEVVUTs9utSHnrExwZ5dF423VnGaGY0xQKTDghHIocqYfcoTZva8YGA9x/ER8V2suqj
	fMXe0ZzGvR8Zg/Dw==
From: "tip-bot2 for Petr Tesarik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/tsx: Make tsx_ctrl_state static
Cc: Petr Tesarik <ptesarik@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176133762078.2601451.5193589047570405990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     f018fca8f90bc383fefd97e3b2db03ea612ac789
Gitweb:        https://git.kernel.org/tip/f018fca8f90bc383fefd97e3b2db03ea612=
ac789
Author:        Petr Tesarik <ptesarik@suse.com>
AuthorDate:    Wed, 22 Oct 2025 12:26:12 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 24 Oct 2025 18:24:42 +02:00

x86/tsx: Make tsx_ctrl_state static

Move all definitions related to tsx_ctrl_state to tsx.c. They are
never referenced outside this file.

No functional change.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/all/cover.1758906115.git.ptesarik@suse.com
---
 arch/x86/kernel/cpu/cpu.h |  9 ---------
 arch/x86/kernel/cpu/tsx.c |  9 ++++++++-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index bc38b2d..5c7a3a7 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -42,15 +42,6 @@ extern const struct cpu_dev *const __x86_cpu_dev_start[],
 			    *const __x86_cpu_dev_end[];
=20
 #ifdef CONFIG_CPU_SUP_INTEL
-enum tsx_ctrl_states {
-	TSX_CTRL_ENABLE,
-	TSX_CTRL_DISABLE,
-	TSX_CTRL_RTM_ALWAYS_ABORT,
-	TSX_CTRL_NOT_SUPPORTED,
-};
-
-extern __ro_after_init enum tsx_ctrl_states tsx_ctrl_state;
-
 extern void __init tsx_init(void);
 void tsx_ap_init(void);
 void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 4978272..8be08ec 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -19,7 +19,14 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "tsx: " fmt
=20
-enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =3D TSX_CTRL_NOT_SUPPORT=
ED;
+enum tsx_ctrl_states {
+	TSX_CTRL_ENABLE,
+	TSX_CTRL_DISABLE,
+	TSX_CTRL_RTM_ALWAYS_ABORT,
+	TSX_CTRL_NOT_SUPPORTED,
+};
+
+static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =3D TSX_CTRL_NOT_=
SUPPORTED;
=20
 static void tsx_disable(void)
 {

